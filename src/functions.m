(* ::Package:: *)

(* ::Input::Initialization:: *)
Clear[transformToStandardView]
transformToStandardView[pt_,angle_:45,axis_:{1,0,0}]:=RotationTransform[angle Degree,axis][pt]


(* ::Input::Initialization:: *)
Clear[transformToStandardView]
transformToStandardView[pt_]:=stdTransform[pt]


(* ::Input::Initialization:: *)
brewerDiv=Blend[RGBColor[#/255.]&/@{{178,24,43},{214,96,77},{244,165,130},{253,219,199},{247,247,247},{209,229,240},{146,197,222},{67,147,195},{33,102,172}},1-#]&;


(* ::Input::Initialization:: *)
brewerQ1=RGBColor[Sequence@@(#/255.)]&/@{{166,206,227},{
31,120,180},{
178,223,138},{
51,160,44},
{251,154,153},
{227,26,28},
{253,191,111}};


(* ::Input::Initialization:: *)
brewerDiv2=Blend[RGBColor[#/255.]&/@{{208,28,139},{
241,182,218},
{247,247,247},
{184,225,134},
{77,172,38}},1-#]&;


(* ::Input::Initialization:: *)
brewerDiv3=Blend[RGBColor[#/255.]&/@{{215,25,28},
{253,174,97},
{255,255,191},
{166,217,106},
{26,150,65}},1-#]&;


(* ::Input::Initialization:: *)
brewerGray=Blend[RGBColor[#/255.]&/@{
{240,240,240},
{189,189,189},
{99,99,99}},1-#]&;


(* ::Input::Initialization:: *)
atrialColor=brewerDiv[0.2];


(* ::Input::Initialization:: *)
ventricularColor=brewerDiv[0.8];


(* ::Input::Initialization:: *)
(*compute \[CapitalDelta]F/F_0*)
Clear[preproc]
preproc[series_]:=(series-Min[series])/(Min[series])
(*this is more reasonable in our case, as the dynamic range of the signal depends on the imaging (light sheet thickness etc.)*)
Clear[preproc]
preproc[series_]:=(series-Min[series])/(Max[series]-Min[series])


(* ::Input::Initialization:: *)
Clear[smoothSeries]
smoothSeries[series_,omega_:freqCut]:=Module[
{dat, lpdat,ip, tmin, tmax, tminS, tmaxS, t0},
dat= preproc[series];
lpdat = LowpassFilter[dat,omega,Padding->"Periodic"];
lpdat = preproc[lpdat];
lpdat
]


(* ::Input::Initialization:: *)
Clear[extractProperties]
extractProperties[series_,omega_:freqCut]:=Module[
{dat, lpdat,ip, tmin, tmax, tminS, tmaxS, t0},
dat= preproc[series];
lpdat = LowpassFilter[dat,omega,Padding->"Periodic"];
lpdat = preproc[lpdat];
ip = Interpolation[lpdat, Method->"Spline", InterpolationOrder->3];
tmin = Ordering[lpdat,1];
tmax = Ordering[lpdat, -1];
tminS = z/.FindRoot[ip'[z],{z,tmin[[1]]}];
tmaxS = z/.FindRoot[ip'[z],{z,tmax[[1]]}];
t0 =z/. FindRoot[ip[z]-0.05, {z, tmin[[1]], tmax[[1]]}];

{t0,Abs[tmaxS-tminS]}
]


(* ::Input::Initialization:: *)
Clear[myGrad]
myGrad[lst_]:=Most[RotateLeft[lst]-lst]


(* ::Input::Initialization:: *)
Clear[shift2min]
shift2min[series_,omega_:freqCut]:=Module[
{dat, lpdat,ip, tmin, tmax, tminS, tmaxS, t0},
dat= preproc[series];
lpdat = LowpassFilter[dat,omega,Padding->"Periodic"];
(*lpdat = preproc[lpdat];*)

tmin = Ordering[lpdat,1];
tmax = Ordering[lpdat, -1];
RotateLeft[lpdat,tmin]
]


(* ::Input::Initialization:: *)
Clear[simpleOnset]
simpleOnset[signal_,\[Omega]_:freqCut, thresh_:0.1]:=Module[
{smooth,aboveT,minT},
smooth = preproc@LowpassFilter[signal, \[Omega],Padding->"Periodic"];
aboveT=Position[smooth, x_/;x>0.05];
minT=Position[smooth,0.][[1,1]];
First[Position[smooth[[minT;;Length[signal]]],x_/;x>thresh]][[1]]+minT+1
]
Clear[argMaxDerivative]
argMaxDerivative[series_,order_:1]:=Module[
{dF},
dF = DerivativeFilter[series,{order},Padding->"Periodic"];
Position[dF,Max[dF]][[1,1]]
]

Clear[getActivationTime]
getActivationTime[series_,\[Omega]_:freqCut]:=argMaxDerivative[LowpassFilter[preproc[series],\[Omega],Padding->"Periodic"]]

Clear[getRiseTime]
getRiseTime[series_,\[Omega]_:freqCut,Fmin_:0.1,Fmax_:0.9]:=Module[{shifted},
shifted=preproc[shift2min[series,\[Omega]]];
-Position[shifted,x_/;x>Fmin][[1]][[1]]+Position[shifted,x_/;x>Fmax][[1]][[1]]
]



(* ::Input::Initialization:: *)
Clear[extractFeatures]
extractFeatures[series_, \[Omega]_:freqCut,Fm_:0.1]:=Module[{s,ss,gs,runs,hit,range,t,raw,smooth,sloperaw,slopesmooth,lmraw,lmsmooth,onset,onsetOld,estimatedSlope,SNR,onset2},
s = preproc[series];
ss = LowpassFilter[s, \[Omega],Padding->"Periodic"];
gs = DerivativeFilter[ss, {1},Padding->"Periodic"];
runs = Split[ If[#>0,1,0]&/@gs];
hit=SortBy[DeleteCases[runs,x_/;Total[x]==0],-Length[#]&][[1]];
range=SequencePosition[Flatten[runs],hit][[1]];
{t,raw,smooth }=Transpose[Table[{t-range[[1]],s[[t]],ss[[t]]},{t,range[[1]],range[[2]]}]];
sloperaw=Transpose[{t,raw}];
slopesmooth=Transpose[{t,smooth}];
lmraw= LinearModelFit[sloperaw,x,x];
estimatedSlope=Normal[lmraw][[2]][[1]];
SNR=Total[Abs[ss-s]]/Length[ss];
SNR = StandardDeviation[s-ss];
onset = simpleOnset[series,\[Omega],Fm];
{onset, estimatedSlope,SNR}
]


(* ::Input::Initialization:: *)
Clear[localTopology]
localTopology[pt_,ptLst_,nearestFunction_, nCandidates_:10, maxDistance_:100, maxDistanceToPlane_:2.5]:=Module[
{candidates,localID2globalID,Y,U,S,V, projectedPts, dm, edges,outliers,projectedPtsClean,idMap},

candidates  = Select[nearestFunction[pt, nCandidates],EuclideanDistance[pt, #]<=maxDistance&];
localID2globalID = MapIndexed[#2[[1]]-> Position[ptLst, #1][[1,1]]&,candidates];

(*Y=#-Mean/@#&[candidates\[Transpose]];*)
(*This is an adapted version of SVD. Instead of subtracting mean, we want our original point to be at the plane.*)
(*Y=#-First[candidates]&@Transpose[candidates];*)
Y=#-Mean/@#&[candidates\[Transpose]];
{U,S,V}=SingularValueDecomposition[Y];
projectedPts=Transpose[{V[[All,1]],V[[All,2]]}];
outliers = Position[V[[All,3]],x_/;Abs[x]>maxDistanceToPlane];
projectedPtsClean = Delete[projectedPts,outliers];
idMap = MapIndexed[#2[[1]]-> Position[projectedPts,#1][[1,1]]&,projectedPtsClean];

dm=DelaunayMesh[(projectedPtsClean)];
edges=UndirectedEdge[Sequence@@#]&/@((MeshCells[dm,1]/.idMap)/.{Line[x_/;MemberQ[x,1/.idMap]]->x,Line[_]->Nothing[]});
edges/.localID2globalID
]


(* ::Input::Initialization:: *)
Clear[transform2phase]
transform2phase[series_,tau_:\[Tau]/2]:=Transpose[{series, RotateLeft[series,tau]}]


(* ::Input::Initialization:: *)
Clear[estimateDiscreteWaveSpeedAtCell]
estimateDiscreteWaveSpeedAtCell[cellID_, dmax_:2,dtMin_:2,activationTime_:onsetAP,graphDistanceFunction_:spfun,graphDistanceMatrix_:gdistMat,vertexList_:cells]:=Module[
{candidates,dtlst,dslst,vlst},
candidates=Flatten[Position[gdistMat[[cellID]],x_/;0<x<=dmax]];
dtlst=2.5Abs[(activationTime[[#]]-activationTime[[cellID]])]&/@candidates;
{candidates,dtlst}=Transpose[MapThread[If[#2<=dtMin,Nothing,{#1,#2}]&,{candidates,dtlst}]];
dslst = (Length[spfun[cellID,#]]-1)&/@candidates;
vlst=MapThread[#1/#2&,{dslst,dtlst}];
HarmonicMean[vlst]
]


(* ::Input::Initialization:: *)
Clear[estimateMetricWaveSpeedAtCell]
estimateMetricWaveSpeedAtCell[cellID_, dmax_:2,dtMin_:2,activationTime_:onsetAP,graphDistanceFunction_:spfun,graphDistanceMatrix_:gdistMat,vertexList_:cells]:=Module[
{candidates,dtlst,dslst,vlst},
candidates=Flatten[Position[gdistMat[[cellID]],x_/;0<x<=dmax]];
dtlst=2.5 Abs[(activationTime[[#]]-activationTime[[cellID]])]&/@candidates;
{candidates,dtlst}=Transpose[MapThread[If[#2<=dtMin,Nothing,{#1,#2}]&,{candidates,dtlst}]];
dslst=Total/@Map[Function[{lst},EuclideanDistance[cells[[lst[[1]]]],cells[[lst[[2]]]]]],Partition[spfun[cellID,#],2,1]&/@candidates,{2}];
vlst=MapThread[#1/#2&,{dslst,dtlst}];
HarmonicMean[vlst]
]


(* ::Input::Initialization:: *)
Clear[estimateLocalDistanceAtCell]
estimateLocalDistanceAtCell[cellID_, dmax_:2,dtMin_:2,activationTime_:onsetAP,graphDistanceFunction_:spfun,graphDistanceMatrix_:gdistMat,vertexList_:cells]:=Module[
{candidates,dtlst,dslst,vlst,timingDifferences,upstream,downstream,neighbors},
candidates=Flatten[Position[gdistMat[[cellID]],x_/;0<x<=dmax]];
timingDifferences=onsetAP[[cellID]]-onsetAP[[#]]&/@candidates;
upstream=candidates[[Flatten[Position[timingDifferences,x_/;x>0]]]];
downstream=candidates[[Flatten[Position[timingDifferences,x_/;x<0]]]];
upstream=#->timingDifferences[[Position[candidates,#][[1,1]]]]&/@upstream;
downstream=#->-timingDifferences[[Position[candidates,#][[1,1]]]]&/@downstream;
neighbors=First/@(First/@{SortBy[upstream,Last],SortBy[downstream,Last]});
If[FreeQ[neighbors,{}],Mean[EuclideanDistance[cells[[cellID]],cells[[#]]]&/@neighbors],(EuclideanDistance[cells[[cellID]],cells[[#]]]&/@Flatten[neighbors])[[1]]]
]


(* ::Input::Initialization:: *)
Clear[frontViewDiscrete]
frontViewDiscrete[cells_,feature_,color_, opacity_,opacityEdges_,scaleCells_,cellSize_,showPacemakers_]:=Module[{cells2,maxZ,minZ,edges},

cells2 = transformToStandardView/@cells;
{maxZ, minZ} = {Max[#[[3]]&/@cells2],Min[#[[3]]&/@cells2]};

minZ = minZ;

edges=If[opacityEdges>0,{Gray,Opacity[1-opacityEdges (First[#][[3]]-minZ)/(maxZ-minZ)],AbsoluteThickness[1],Line[{#[[1]],#[[2]]}]}&/@(myEdges/.MapIndexed[#2[[1]]->#1&,cells2]),{}];

Graphics3D[{edges,{AbsolutePointSize[8],
If[feature[[#]]==0,White,ColorData[color,feature[[#]]]],
If[opacity>0, Opacity[1-opacity (cells2[[#]][[3]]-minZ)/(maxZ-minZ)],{}],
Specularity[0],
Sphere[cells2[[#]],If[scaleCells,(Sqrt[((cells2[[#]][[3]]-minZ)/(maxZ-minZ))]+1)*0.5cellSize,cellSize]]}&/@Range[1,Length[cells2]],
If[showPacemakers,{{Black,
Sphere[cells2[[#]],0.25cellSize]}&/@pacemakers},{}]},Boxed->False,ImageSize->imsize,

ViewPoint->{0,0,Infinity},Lighting->{{"Ambient",White}}]]

Clear[viewHeartDiscrete]
viewHeartDiscrete[cells_,feature_,color_,opacity_:0.5,opacityEdges_:0,scaleCells_:False,cellSize_:4,showPacemakers_:True]:=Rasterize[
frontViewDiscrete[cells, feature, color,opacity,opacityEdges,scaleCells,cellSize,showPacemakers],RasterSize->2imsize,ImageSize->imsize]



Clear[frontView]
frontView[cells_,feature_,min_,max_,color_, opacity_,opacityEdges_,scaleCells_,cellSize_,showPacemakers_]:=Module[{cells2,maxZ,minZ,edges},

cells2 = transformToStandardView/@cells;
{maxZ, minZ} = {Max[#[[3]]&/@cells2],Min[#[[3]]&/@cells2]};

minZ = minZ;

edges=If[opacityEdges>0,{Gray,Opacity[1-opacityEdges (First[#][[3]]-minZ)/(maxZ-minZ)],AbsoluteThickness[1],Line[{#[[1]],#[[2]]}]}&/@(myEdges/.MapIndexed[#2[[1]]->#1&,cells2]),{}];

Graphics3D[{edges,{AbsolutePointSize[8],
If[StringQ[color],ColorData[color,(feature[[#]]-min)/(max-min)],color[(feature[[#]]-min)/(max-min)]],
If[opacity>0, Opacity[1-opacity (cells2[[#]][[3]]-minZ)/(maxZ-minZ)],{}],
Specularity[0],
Sphere[cells2[[#]],If[scaleCells,(Sqrt[((cells2[[#]][[3]]-minZ)/(maxZ-minZ))]+1)*0.5cellSize,cellSize]]}&/@Range[1,Length[cells2]],
If[showPacemakers,{{Black,
Sphere[cells2[[#]],0.25cellSize]}&/@pacemakers},{}]},Boxed->False,ImageSize->imsize,

ViewPoint->{0,0,Infinity},Lighting->{{"Ambient",White}}]]

Clear[viewHeart]
viewHeart[cells_,feature_,min_,max_,color_,opacity_:0.5,opacityEdges_:0,scaleCells_:False,cellSize_:4,showPacemakers_:True]:=Rasterize[
frontView[cells, feature, min,max,color,opacity,opacityEdges,scaleCells,cellSize,showPacemakers],RasterSize->2imsize,ImageSize->imsize]


Clear[averageDistanceAtCell]
averageDistanceAtCell[cellID_,graphDistanceFunction_:spfun,graphDistanceMatrix_:gdistMat,vertexList_:cells]:=Module[
{candidates,dtlst,dslst,vlst},
candidates=Flatten[Position[gdistMat[[cellID]],1]];

dslst = spfun[cells[[cellID]],cells[[#]]]&/@candidates;
dslst=Total/@Map[Function[pair,EuclideanDistance[Sequence@@pair]],Partition[#,2,1]&/@dslst,{2}];
Mean[dslst]
]

Clear[projectPointToMidline]
projectPointToMidline[pt_,xint_:xint2,yint_:yint2,zint_:zint2, frenetFrame_:FrenetSerretSystem[{xint2[t],yint2[t],zint2[t]},t]]:=Module[
{pieces, minDist, minPar,minVec,Ti,Ni,Bi,dv,\[Kappa],\[Tau],vec,z,\[Rho],\[Phi]},

{minDist, minPar}=NMinimize[{EuclideanDistance[pt,{xint[t],yint[t],zint[t]}],0<t<1},t];
{minDist,minPar}={minDist, t/.minPar};
minVec={xint[minPar],yint[minPar],zint[minPar]};

{{\[Kappa],\[Tau]},{Ti,Ni,Bi}} = frenetFrame/.t->minPar;

vec=pt-minVec;
{\[Rho],\[Phi],z}=Append[ToPolarCoordinates[{vec.Bi,vec.Ni}],minPar]
]

Clear[estimateCellShape]
estimateCellShape[cellID_,graphDistanceFunction_:spfun,graphDistanceMatrix_:gdistMat,vertexList_:cells]:=Module[
{candidates,dtlst,dslst,vlst,centroids,centerOfMass,fittedEgg,\[Lambda]1, \[Lambda]2, \[Lambda]3,\[Nu]1, \[Nu]2, \[Nu]3,\[Lambda]0,fractionalAnisotropy},
candidates=Flatten[Position[gdistMat[[cellID]],1]];
(*This function should be used to calculate the distance between cells if paths longer than 1 are used to define neighborhoods in the graph*)
(*dslst = spfun[cells[[cellID]],cells[[#]]]&/@candidates;
dslst=Total/@Map[Function[pair,EuclideanDistance[Sequence@@pair]],Partition[#,2,1]&/@dslst,{2}];*)
dslst=EuclideanDistance[cells[[cellID]],cells[[#]]]&/@candidates;
centroids=cells[[#]]&/@Prepend[candidates,cellID];
centerOfMass=Mean[centroids];
fittedEgg=Ellipsoid[transformToStandardView@centerOfMass,0.2Covariance[transformToStandardView/@centroids]];
{{\[Lambda]1, \[Lambda]2, \[Lambda]3},{\[Nu]1, \[Nu]2, \[Nu]3}} = Eigensystem[Covariance[centroids]];
\[Lambda]0=Mean[{\[Lambda]1, \[Lambda]2, \[Lambda]3}];
fractionalAnisotropy=Sqrt[3/2]Norm[{\[Lambda]1, \[Lambda]2, \[Lambda]3}-\[Lambda]0]/Norm[{\[Lambda]1, \[Lambda]2, \[Lambda]3}];
{dslst,fractionalAnisotropy,1-(\[Lambda]2/\[Lambda]1),(4/3)\[Pi] \[Lambda]1 \[Lambda]2 \[Lambda]3,\[Pi] \[Lambda]1 \[Lambda]2,Length[candidates],fittedEgg, \[Nu]1}
]
