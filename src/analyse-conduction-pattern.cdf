(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 11.1' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1064,         20]
NotebookDataLength[     81474,       2297]
NotebookOptionsPosition[     68693,       2003]
NotebookOutlinePosition[     69196,       2025]
CellTagsIndexPosition[     69153,       2022]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["\<\
Cell-accurate optical mapping across the entire developing heart\
\>", "Title",ExpressionUUID->"265e1ae8-b6c4-4318-9c7f-330aeae00951"],

Cell["\<\
First of all, we have to load the function definitions we will use throughout \
the analysis from an external file \[OpenCurlyDoubleQuote]./functions.m\
\[CloseCurlyDoubleQuote]. \
\>", "Text",ExpressionUUID->"85778b1f-2ffc-485a-bf7d-37c801009af2"],

Cell[BoxData[
 RowBox[{"Get", "[", 
  RowBox[{
   RowBox[{"NotebookDirectory", "[", "]"}], "<>", "\"\<functions.m\>\""}], 
  "]"}]], "Input",ExpressionUUID->"8fcce809-2c09-487c-adb7-a628ca59c731"],

Cell[BoxData[
 RowBox[{"root", "=", 
  RowBox[{"FileNameJoin", "[", 
   RowBox[{"Most", "[", 
    RowBox[{"FileNameSplit", "[", 
     RowBox[{"NotebookDirectory", "[", "]"}], "]"}], "]"}], "]"}]}]], "Input",\
ExpressionUUID->"a91c74ba-3492-4f58-a8d4-688f8c8c52f1"],

Cell[CellGroupData[{

Cell["select dataset to analyze", "Subchapter",ExpressionUUID->"450d5e3a-636f-462d-bd7b-c754640511af"],

Cell["\<\
We used the data from 5 different experiments for the analysis presented in \
the manuscript. An overview of the specific characteristics can be found in \
the datasheet: \[OpenCurlyQuote]datasets.xls\[CloseCurlyQuote].\
\>", "Text",ExpressionUUID->"64a56c60-d3dd-4d1c-96f4-9f4b72913b22"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"overview", " ", "=", " ", 
   RowBox[{
    RowBox[{"Import", "[", 
     RowBox[{"root", "<>", "\"\</data/datasets.xls\>\""}], "]"}], "[", 
    RowBox[{"[", "1", "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"TableForm", "[", "overview", "]"}]}], "Input",ExpressionUUID->\
"7bb4cd30-45c1-49d4-89e9-aa35a8fba92a"],

Cell["\<\
Indicate number of dataset for analysis here. For illustration purposes we \
will use dataset 4:\
\>", "Text",ExpressionUUID->"f0567b58-db90-4320-8e39-b91a157309a0"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"dataset", " ", "=", " ", "4"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"overview", "[", 
   RowBox[{"[", 
    RowBox[{"dataset", "+", "1"}], "]"}], "]"}], "[", 
  RowBox[{"[", "1", "]"}], "]"}]}], "Input",ExpressionUUID->"03b06680-1abb-\
47d2-8e4e-a2470599b620"]
}, Open  ]],

Cell[CellGroupData[{

Cell["global parameters for analysis", "Subchapter",ExpressionUUID->"5d0fea98-d224-4ac4-bbbb-6575f8574972"],

Cell[CellGroupData[{

Cell["dataset-specific information", "Section",ExpressionUUID->"26e93bb1-bb90-40ec-b7d2-459898f65a46"],

Cell[BoxData[{
 RowBox[{"fname", " ", "=", " ", 
  RowBox[{"overview", "[", 
   RowBox[{"[", 
    RowBox[{
     RowBox[{"dataset", "+", "1"}], ",", "1"}], "]"}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"age", " ", "=", " ", 
  RowBox[{"overview", "[", 
   RowBox[{"[", 
    RowBox[{
     RowBox[{"dataset", "+", "1"}], ",", "7"}], "]"}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"sampling", " ", "=", " ", 
  RowBox[{"overview", "[", 
   RowBox[{"[", 
    RowBox[{
     RowBox[{"dataset", "+", "1"}], ",", "11"}], "]"}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"dx", " ", "=", " ", 
  RowBox[{"overview", "[", 
   RowBox[{"[", 
    RowBox[{
     RowBox[{"dataset", "+", "1"}], ",", "12"}], "]"}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"samplingCorrectionFactor", " ", "=", " ", 
   RowBox[{"400", "/", "sampling"}]}], ";"}]}], "Input",ExpressionUUID->\
"7c90d0f6-89ea-4e18-b3a8-09ca8452d43f"]
}, Open  ]],

Cell[CellGroupData[{

Cell["settings for import and export", "Section",ExpressionUUID->"f1f6bee0-1d65-4d93-8d6c-91061c3d7540"],

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{"directory", " ", "prefix", " ", "for", " ", "import"}], "*)"}], 
  "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"prefix", " ", "=", " ", 
     RowBox[{"root", "<>", "\"\</results/\>\""}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
    "Ca", " ", "signals", " ", "per", " ", "cell", " ", "from", " ", "HDF5", 
     " ", "file"}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"in", " ", "=", 
     RowBox[{
     "prefix", "<>", "\"\<myl7-GCaMP5G-from-processed-labels/\>\"", "<>", 
      "fname", "<>", "\"\<-curated-signal.h5\>\""}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
    "labelled", " ", "volume", " ", "of", " ", "detected", " ", "cells"}], 
    "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"map", " ", "=", " ", 
     RowBox[{
     "prefix", "<>", "\"\<myl7-H2A-processed-labels/\>\"", "<>", "fname", 
      "<>", "\"\<-curated-labels.tif\>\""}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
    "coordinates", " ", "of", " ", "manually", " ", "extracted", " ", 
     "midline"}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"mline", " ", "=", " ", 
     RowBox[{
     "prefix", "<>", "\"\<extracted-midline/\>\"", "<>", "fname", "<>", 
      "\"\<-midline.m\>\""}]}], ";"}]}]}]], "Input",ExpressionUUID->"f07438aa-\
5c17-4055-976d-8a38bd55e71d"]
}, Open  ]],

Cell[CellGroupData[{

Cell["general parameters", "Section",ExpressionUUID->"52af9ff1-e475-4056-af10-bad0d2641181"],

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{
   "frequency", " ", "cutoff", " ", "for", " ", "lowpass", " ", "filter"}], 
   "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"freqCut", "=", "0.06"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
     RowBox[{"arbitrary", " ", "'"}], 
     RowBox[{"zero", "'"}], " ", "point", " ", "for", " ", "all", " ", "time",
      " ", "series"}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"startPoint", "=", "140"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{"settings", " ", "for", " ", "exported", " ", "graphics"}], 
    "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"maxRes", "=", "600"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"imsize", "=", " ", "600"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"imres", " ", "=", " ", "300"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
    "color", " ", "range", " ", "clipping", " ", "for", " ", "plotting"}], 
    "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"minDelay", "=", "0.0"}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"maxDelay", " ", "=", " ", "0.2"}], ";"}], "\[IndentingNewLine]", 
   
   RowBox[{
    RowBox[{"maxMetricSpeed", "=", "4"}], ";"}]}]}]], "Input",ExpressionUUID->\
"50e61ea8-0177-44aa-9ae8-78a56f2d34ce"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["data analysis and visualization", "Subchapter",ExpressionUUID->"d0db934c-da87-4e51-8f29-ea4d592f5436"],

Cell[CellGroupData[{

Cell["import position and Ca signals for each cell", "Section",ExpressionUUID->"b1f03652-a172-4473-8944-54e563d9bb7c"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"names", "=", 
   RowBox[{"Import", "[", 
    RowBox[{"in", ",", 
     RowBox[{"{", 
      RowBox[{"\"\<HDF5\>\"", ",", "\"\<Datasets\>\""}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ns", " ", "=", " ", 
   RowBox[{"Length", "[", "names", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"series", " ", "=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"Import", "[", 
      RowBox[{"in", ",", 
       RowBox[{"{", 
        RowBox[{"\"\<HDF5\>\"", ",", "\"\<Datasets\>\"", ",", "n"}], "}"}]}], 
      "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"n", ",", " ", "1", ",", " ", "ns", ",", "1"}], "}"}]}], 
    "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"heart", "=", 
   RowBox[{"Import", "[", "map", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"img", "=", 
   RowBox[{"Image3D", "[", 
    RowBox[{"heart", ",", "\"\<Bit16\>\""}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"lab", " ", "=", " ", 
   RowBox[{"ComponentMeasurements", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"ImageData", "[", 
        RowBox[{"img", ",", "\"\<Bit16\>\""}], "]"}], ",", "img"}], "}"}], 
     ",", 
     RowBox[{"{", "\"\<Label\>\"", "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"cnts", " ", "=", " ", 
   RowBox[{"ComponentMeasurements", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"ImageData", "[", 
        RowBox[{"img", ",", "\"\<Bit16\>\""}], "]"}], ",", "img"}], "}"}], 
     ",", 
     RowBox[{"{", "\"\<Centroid\>\"", "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"sizes", " ", "=", " ", 
   RowBox[{"ComponentMeasurements", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"ImageData", "[", 
        RowBox[{"img", ",", "\"\<Bit16\>\""}], "]"}], ",", "img"}], "}"}], 
     ",", 
     RowBox[{"{", "\"\<Count\>\"", "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"pts", "=", 
   RowBox[{"Join", "@@", 
    RowBox[{"(", 
     RowBox[{"Last", "/@", "cnts"}], ")"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"pts2", " ", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{"#", "*", 
      RowBox[{"{", 
       RowBox[{"dx", ",", "dx", ",", "1"}], "}"}]}], "&"}], "/@", "pts"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"series", " ", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{"RotateLeft", "[", 
      RowBox[{"#", ",", "startPoint"}], "]"}], "&"}], "/@", "series"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ids", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"ToExpression", "[", 
      RowBox[{"StringDrop", "[", 
       RowBox[{"#", ",", "3"}], "]"}], "]"}], "&"}], "/@", "names"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"series", "=", 
   RowBox[{"Last", "/@", 
    RowBox[{"SortBy", "[", 
     RowBox[{
      RowBox[{"Transpose", "[", 
       RowBox[{"{", 
        RowBox[{"ids", ",", "series"}], "}"}], "]"}], ",", "First"}], 
     "]"}]}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"stdTransform", "=", 
   RowBox[{"Import", "[", 
    RowBox[{
    "prefix", "<>", "\"\<standard-view-transforms/\>\"", "<>", "fname", "<>", 
     "\"\<-standardTransform.m\>\""}], "]"}]}], ";"}]}], "Input",ExpressionUUI\
D->"108765ff-96c4-4278-9cba-42d75ec3b654"]
}, Open  ]],

Cell[CellGroupData[{

Cell["pre-process calcium signals", "Section",ExpressionUUID->"7a810d62-b5ca-49b0-b67b-bd36f145ecc8"],

Cell["\<\
Here, we process the raw GCaMP signals using lowpass filtering, extract the \
features of interest, and also discard time series where SNR is too low \
(defined as an outlier from the SNR statistics over all time series from this \
experiment)\
\>", "Text",ExpressionUUID->"37ff9078-f7e6-4d41-b9bb-08be3c87f3c8"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"res", " ", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{"smoothSeries", "[", "#", "]"}], "&"}], "/@", "series"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"shifted", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{"shift2min", "[", 
      RowBox[{"smoothSeries", "[", "#", "]"}], "]"}], "&"}], "/@", 
    "series"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"onsetAP", ",", "slopes", ",", "SNR"}], "}"}], "=", 
   RowBox[{"Transpose", "[", 
    RowBox[{"extractFeatures", "/@", "series"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"cutoffSNR", " ", "=", " ", 
   RowBox[{
    RowBox[{"1.5", " ", 
     RowBox[{"InterquartileRange", "[", "SNR", "]"}]}], "+", 
    RowBox[{"Quantile", "[", 
     RowBox[{"SNR", ",", " ", "0.75"}], "]"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"del", "=", 
   RowBox[{"Position", "[", 
    RowBox[{"SNR", ",", " ", 
     RowBox[{"z_", "/;", 
      RowBox[{"z", ">", "cutoffSNR"}]}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"series", "=", 
   RowBox[{"Delete", "[", 
    RowBox[{"series", ",", "del"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"pts2", " ", "=", " ", 
   RowBox[{"Delete", "[", 
    RowBox[{"pts2", ",", "del"}], "]"}]}], ";"}]}], "Input",ExpressionUUID->\
"ad85bc9b-03ad-4fd4-b013-d56b31a1ef05"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"onsetAP", ",", "slopes", ",", "SNR"}], "}"}], "=", 
   RowBox[{"Transpose", "[", 
    RowBox[{"extractFeatures", "/@", "series"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"res", " ", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{"smoothSeries", "[", "#", "]"}], "&"}], "/@", "series"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"shifted", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{"shift2min", "[", 
      RowBox[{"smoothSeries", "[", "#", "]"}], "]"}], "&"}], "/@", 
    "series"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"tAct", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"getActivationTime", "[", "#", "]"}], "&"}], "/@", "series"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"riseTime", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"getRiseTime", "[", "#", "]"}], "&"}], "/@", "series"}]}], 
  ";"}]}], "Input",ExpressionUUID->"5d0cb75c-945c-481d-8065-36b3d0335614"]
}, Open  ]],

Cell[CellGroupData[{

Cell["compute nearest-neighbor graph from cell positions", "Section",ExpressionUUID->"d1e74493-6db6-44fc-966e-6909021974e5"],

Cell["\<\
We compute the nearest neighbor graph from local flat projections of cell \
positions around each cell.\
\>", "Text",ExpressionUUID->"c41fb71b-9cc9-4047-85d7-ff3ffcf104ca"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"nnfun", " ", "=", " ", 
   RowBox[{"Nearest", "[", "pts2", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"myEdges", "=", 
   RowBox[{"Flatten", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"localTopology", "[", 
       RowBox[{"#", ",", "pts2", ",", "nnfun"}], "]"}], "&"}], "/@", "pts2"}],
     "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"vertexIDs", "=", 
   RowBox[{"Range", "[", 
    RowBox[{"Length", "[", "pts2", "]"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"edgeDelays", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"Abs", "[", 
      RowBox[{
       RowBox[{"onsetAP", "[", 
        RowBox[{"[", 
         RowBox[{"#", "[", 
          RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], "-", 
       RowBox[{"onsetAP", "[", 
        RowBox[{"[", 
         RowBox[{"#", "[", 
          RowBox[{"[", "2", "]"}], "]"}], "]"}], "]"}]}], "]"}], "&"}], "/@", 
    "myEdges"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"myGraph", "=", 
   RowBox[{"Graph", "[", 
    RowBox[{"vertexIDs", ",", " ", 
     RowBox[{"DeleteDuplicates", "[", 
      RowBox[{"Sort", "/@", "myEdges"}], "]"}], ",", " ", 
     RowBox[{"VertexCoordinates", "\[Rule]", 
      RowBox[{"MapIndexed", "[", 
       RowBox[{
        RowBox[{
         RowBox[{
          RowBox[{"#2", "[", 
           RowBox[{"[", "1", "]"}], "]"}], "\[Rule]", "#1"}], "&"}], ",", 
        "pts2"}], "]"}]}], ",", 
     RowBox[{"EdgeStyle", "\[Rule]", 
      RowBox[{"Directive", "[", 
       RowBox[{
        RowBox[{"AbsoluteThickness", "[", "1", "]"}], ",", "LightGray"}], 
       "]"}]}]}], "]"}]}], ";"}]}], "Input",ExpressionUUID->"b2b9f154-040a-\
41cc-aada-6ccd144e6a78"],

Cell["\<\
The z depth of each cell is used to fade the edges into the background to \
increase depth perception in the 3D visualization of the graph.\
\>", "Text",ExpressionUUID->"a40586c3-f012-492d-9001-8765b29f1dfb"],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"maxZ", ",", " ", "minZ"}], "}"}], " ", "=", " ", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"Max", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"#", "[", 
         RowBox[{"[", "2", "]"}], "]"}], "&"}], "/@", "pts2"}], "]"}], ",", 
     RowBox[{"Min", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"#", "[", 
         RowBox[{"[", "2", "]"}], "]"}], "&"}], "/@", "pts2"}], "]"}]}], 
    "}"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"edges", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"GrayLevel", "[", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{
           RowBox[{
            RowBox[{"First", "[", "#", "]"}], "[", 
            RowBox[{"[", "2", "]"}], "]"}], "-", "minZ"}], ")"}], "/", 
         RowBox[{"(", 
          RowBox[{"maxZ", "-", "minZ"}], ")"}]}], "]"}], ",", 
       RowBox[{"AbsoluteThickness", "[", "1", "]"}], ",", 
       RowBox[{"Line", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"#", "[", 
           RowBox[{"[", "1", "]"}], "]"}], ",", 
          RowBox[{"#", "[", 
           RowBox[{"[", "2", "]"}], "]"}]}], "}"}], "]"}]}], "}"}], "&"}], "/@", 
    RowBox[{"(", 
     RowBox[{"myEdges", "/.", 
      RowBox[{"MapIndexed", "[", 
       RowBox[{
        RowBox[{
         RowBox[{
          RowBox[{"#2", "[", 
           RowBox[{"[", "1", "]"}], "]"}], "\[Rule]", "#1"}], "&"}], ",", 
        "pts2"}], "]"}]}], ")"}]}]}], ";"}]}], "Input",ExpressionUUID->\
"3be82bea-e379-438b-9927-2bd77870a936"],

Cell[BoxData[
 RowBox[{
  RowBox[{"cells", " ", "=", " ", "pts2"}], ";"}]], "Input",ExpressionUUID->\
"0733cccd-8054-473f-9f24-44e6dc35e529"],

Cell["\<\
The graph distance matrix stores the shortest distance along the graph \
between any pair of vertices.\
\>", "Text",ExpressionUUID->"416bdfd9-9c0c-45d9-a3ec-2c26d1d6f746"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"spfun", "=", 
   RowBox[{"FindShortestPath", "[", 
    RowBox[{"myGraph", ",", "All", ",", "All"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"gdistMat", " ", "=", " ", 
   RowBox[{"GraphDistanceMatrix", "[", "myGraph", "]"}]}], ";"}]}], "Input",Ex\
pressionUUID->"380638bf-c757-4fb9-a0b5-f533e0f465b9"]
}, Open  ]],

Cell[CellGroupData[{

Cell["compute curved cylindrical coordinate system", "Section",ExpressionUUID->"89036fef-7914-4f5e-8188-6b7a8f95f352"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"xmin", ",", "xmax"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"ymin", ",", "ymax"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"zmin", ",", "zmax"}], "}"}]}], "}"}], "=", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Min", "[", "#", "]"}], ",", 
       RowBox[{"Max", "[", "#", "]"}]}], "}"}], "&"}], "/@", 
    RowBox[{"Transpose", "[", "pts2", "]"}]}]}], ";"}]], "Input",ExpressionUUI\
D->"972cce38-8efa-4f58-9a1a-9081a6203f8a"],

Cell["Import the manually extracted midline (a polyline).", "Text",ExpressionUUID->"8b6386eb-c05d-457d-aec2-740ae3331370"],

Cell[BoxData[
 RowBox[{
  RowBox[{"ctrlPts", "=", 
   RowBox[{"Import", "[", "mline", "]"}]}], ";"}]], "Input",ExpressionUUID->\
"87f85632-d317-4c9d-90c4-cd4327da454e"],

Cell["\<\
Computing the spline interpolation of the manually annotated control points \
of the midline (parameterized in [0,1]).
(Note: The spline degree can influences the computation of the Frenet frame, \
we set it to 4 for all experiments in the paper.)\
\>", "Text",ExpressionUUID->"ab83705e-43b4-4c03-bbce-9be6505af92e"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"xi", ",", "yi", ",", "zi"}], "}"}], "=", 
   RowBox[{
    RowBox[{
     RowBox[{"BSplineFunction", "[", 
      RowBox[{"#", ",", 
       RowBox[{"SplineDegree", "\[Rule]", "4"}]}], "]"}], "&"}], "/@", 
    RowBox[{"Transpose", "[", "ctrlPts", "]"}]}]}], ";"}]], "Input",Expression\
UUID->"2cd0f545-1f90-4335-afca-a856a000826f"],

Cell["Computing the arclength along curcve...", "Text",ExpressionUUID->"bd76d4e9-00ab-4f4c-afd0-0e44c71efabb"],

Cell[BoxData[{
 RowBox[{"Clear", "[", "s", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"s", "[", "t_", "]"}], ":=", 
  RowBox[{"NIntegrate", "[", 
   RowBox[{
    RowBox[{"Sqrt", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"(", 
        RowBox[{
         RowBox[{"xi", "'"}], "[", "t0", "]"}], ")"}], "^", "2"}], " ", "+", 
      " ", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{
         RowBox[{"yi", "'"}], "[", "t0", "]"}], ")"}], "^", "2"}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{
         RowBox[{"zi", "'"}], "[", "t0", "]"}], ")"}], "^", "2"}]}], "]"}], 
    ",", 
    RowBox[{"{", 
     RowBox[{"t0", ",", "0", ",", "t"}], "}"}]}], "]"}]}]}], "Input",Expressio\
nUUID->"3d67db05-cb24-40da-b299-3209478311e5"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"smin", "=", 
   RowBox[{"s", "[", "0", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"smax", " ", "=", " ", 
   RowBox[{
    RowBox[{"s", "[", "1.", "]"}], "-", "0.001"}]}], ";"}]}], "Input",Expressi\
onUUID->"84b13af9-977f-4b34-87f2-e7606ef44631"],

Cell["\<\
Interpolated mapping from normalized parameters in [0,1]  to corresponding \
arclength along the curve:\
\>", "Text",ExpressionUUID->"5a881446-0259-4168-995a-c78f6026fc5d"],

Cell[BoxData[
 RowBox[{
  RowBox[{"ipol", "=", 
   RowBox[{"ListInterpolation", "[", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"{", "t", "}"}], ",", 
        RowBox[{"s", "[", "t", "]"}]}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"t", ",", "0", ",", "1", ",", "0.05"}], "}"}]}], "]"}], 
    "]"}]}], ";"}]], "Input",ExpressionUUID->"335e9f18-6571-4612-8a82-\
70985b0ceaff"],

Cell["Compute inverse parametrization (from arclength to [0,1]):", "Text",ExpressionUUID->"b26999aa-3aee-4a18-aec3-a746638cb8e2"],

Cell[BoxData[{
 RowBox[{"Clear", "[", "t", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"t", "[", "s_", "]"}], ":=", 
  RowBox[{
   RowBox[{"InverseFunction", "[", "ipol", "]"}], "[", "s", "]"}]}]}], "Input",\
ExpressionUUID->"fb731fad-ef64-4f53-8dbf-1cb8cb531e27"],

Cell["\<\
These mappings can be used to compute and equidistant (with respect to the \
arclength) parametrization of the midline in [0,1]\
\>", "Text",ExpressionUUID->"ebb497bb-fabd-455a-bddb-0b90510df441"],

Cell[BoxData[{
 RowBox[{"Clear", "[", "xint", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"xint", "[", "s_", "]"}], ":=", 
  RowBox[{"Chop", "[", 
   RowBox[{"xi", "[", 
    RowBox[{"t", "[", 
     RowBox[{"s", "*", "smax"}], "]"}], "]"}], "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"Clear", "[", "yint", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"yint", "[", "s_", "]"}], ":=", 
  RowBox[{"Chop", "[", 
   RowBox[{"yi", "[", 
    RowBox[{"t", "[", 
     RowBox[{"s", "*", "smax"}], "]"}], "]"}], "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"Clear", "[", "zint", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"zint", "[", "s_", "]"}], ":=", 
  RowBox[{"Chop", "[", 
   RowBox[{"zi", "[", 
    RowBox[{"t", "[", 
     RowBox[{"s", "*", "smax"}], "]"}], "]"}], "]"}]}]}], "Input",ExpressionUU\
ID->"e4fa0bef-1317-47b8-b997-1b6c695accac"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"xint2", "=", 
   RowBox[{"BSplineFunction", "[", 
    RowBox[{
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"xint", "[", "s", "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"s", ",", "0", ",", "1", ",", "0.01"}], "}"}]}], "]"}], ",", 
     RowBox[{"SplineDegree", "\[Rule]", "4"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"yint2", "=", 
   RowBox[{"BSplineFunction", "[", 
    RowBox[{
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"yint", "[", "s", "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"s", ",", "0", ",", "1", ",", "0.01"}], "}"}]}], "]"}], ",", 
     RowBox[{"SplineDegree", "\[Rule]", "4"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"zint2", "=", 
   RowBox[{"BSplineFunction", "[", 
    RowBox[{
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"zint", "[", "s", "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"s", ",", "0", ",", "1", ",", "0.01"}], "}"}]}], "]"}], ",", 
     RowBox[{"SplineDegree", "\[Rule]", "4"}]}], "]"}]}], ";"}]}], "Input",Exp\
ressionUUID->"081a229d-1bf6-447e-b5ba-1990d8380109"],

Cell[BoxData[
 RowBox[{"Graphics3D", "[", 
  RowBox[{"{", 
   RowBox[{"Red", ",", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"Point", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"xint2", "[", "t", "]"}], ",", 
         RowBox[{"yint2", "[", "t", "]"}], ",", " ", 
         RowBox[{"zint2", "[", "t", "]"}]}], "}"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"t", ",", "0", ",", "1", ",", "0.1"}], "}"}]}], "]"}], ",", 
    RowBox[{"(*", 
     RowBox[{"Black", ",", 
      RowBox[{"Point", "/@", 
       RowBox[{"Table", "[", 
        RowBox[{
         RowBox[{"Evaluate", "[", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"xint", "[", "t", "]"}], ",", 
            RowBox[{"yint", "[", "t", "]"}], ",", " ", 
            RowBox[{"zint", "[", "t", "]"}]}], "}"}], "]"}], ",", 
         RowBox[{"{", 
          RowBox[{"t", ",", "0", ",", "1", ",", "0.1"}], "}"}]}], "]"}]}], 
      ","}], "*)"}], "\[IndentingNewLine]", "Blue", ",", 
    RowBox[{"Point", "/@", 
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"Evaluate", "[", 
        RowBox[{"{", 
         RowBox[{
          RowBox[{"xi", "[", "t", "]"}], ",", 
          RowBox[{"yi", "[", "t", "]"}], ",", " ", 
          RowBox[{"zi", "[", "t", "]"}]}], "}"}], "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"t", ",", "0", ",", "1", ",", "0.1"}], "}"}]}], "]"}]}]}], 
   "}"}], "]"}]], "Input",ExpressionUUID->"02b56f67-641e-4938-957d-\
8b786ceb874e"],

Cell["\<\
From the parametrization, the moving local reference system can be obtained:\
\>", "Text",ExpressionUUID->"b5948897-8c6f-4c0d-8cca-bb8e2cd731d2"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{"\[Kappa]", ",", "\[Tau]"}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"Ti", ",", "Ni", ",", "Bi"}], "}"}]}], "}"}], " ", "=", 
   RowBox[{"FrenetSerretSystem", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"xint2", "[", "t", "]"}], ",", 
       RowBox[{"yint2", "[", "t", "]"}], ",", 
       RowBox[{"zint2", "[", "t", "]"}]}], "}"}], ",", "t"}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"3bc2305b-43d7-44f9-bf23-ea21270ec043"],

Cell[BoxData[
 RowBox[{
  RowBox[{"ptsCylinder", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"projectPointToMidline", "[", 
      RowBox[{"#", ",", "xint2", ",", "yint2", ",", "zint2", ",", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"\[Kappa]", ",", "\[Tau]"}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"Ti", ",", "Ni", ",", "Bi"}], "}"}]}], "}"}]}], "]"}], 
     "&"}], "/@", "pts2"}]}], ";"}]], "Input",ExpressionUUID->"69241621-8c0c-\
488a-a96e-1dccc0b9844f"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"minParameter", "=", 
   RowBox[{"Min", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"Last", "[", "#", "]"}], "&"}], "/@", "ptsCylinder"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"maxParameter", "=", 
   RowBox[{"Max", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"Last", "[", "#", "]"}], "&"}], "/@", "ptsCylinder"}], "]"}]}], 
  ";"}]}], "Input",ExpressionUUID->"2780ad10-a179-46a4-8aec-616041fd4503"],

Cell[BoxData[
 RowBox[{"smax", "=", 
  RowBox[{
   RowBox[{"s", "[", "1.0", "]"}], " ", "*", " ", 
   RowBox[{"(", 
    RowBox[{"maxParameter", "-", "minParameter"}], ")"}]}]}]], "Input",Express\
ionUUID->"c6719178-1bb3-4b06-bc66-630233678b54"],

Cell["\<\
The local Frenet Serret coordinates allow us to project the position of cells \
onto a curved cylindrical reference frame.\
\>", "Text",ExpressionUUID->"93feffdb-cfb6-4541-ba13-56630595f59f"],

Cell[BoxData[
 RowBox[{
  RowBox[{"ptsCylinder", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"#", "[", 
        RowBox[{"[", "1", "]"}], "]"}], ",", 
       RowBox[{"#", "[", 
        RowBox[{"[", "2", "]"}], "]"}], ",", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{
          RowBox[{"#", "[", 
           RowBox[{"[", "3", "]"}], "]"}], "-", "minParameter"}], ")"}], "/", 
        
        RowBox[{"(", 
         RowBox[{"maxParameter", "-", "minParameter"}], ")"}]}]}], "}"}], 
     "&"}], "/@", "ptsCylinder"}]}], ";"}]], "Input",ExpressionUUID->\
"028d40ed-8900-47dd-bac6-70c70c120dce"],

Cell[BoxData[
 RowBox[{
  RowBox[{"torsion", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{"#", ",", 
       RowBox[{"(", 
        RowBox[{"\[Tau]", "/.", 
         RowBox[{"t", "\[Rule]", "#"}]}], ")"}]}], "}"}], "&"}], "/@", 
    RowBox[{"(", 
     RowBox[{"Last", "/@", "ptsCylinder"}], ")"}]}]}], ";"}]], "Input",Express\
ionUUID->"458052b4-7663-4430-a31a-1d477afa4fd8"]
}, Open  ]],

Cell[CellGroupData[{

Cell["visualize the cell positions and the midline for reference", "Section",ExpressionUUID->"18249000-c0ca-4f30-9668-fdf0efe87d09"],

Cell[BoxData[
 RowBox[{"Graphics3D", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"AbsolutePointSize", "[", "4", "]"}], ",", 
     RowBox[{"MapIndexed", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"Darker", "@", "Gray"}], ",", 
          RowBox[{"AbsolutePointSize", "[", "5", "]"}], ",", 
          RowBox[{"Point", "[", 
           RowBox[{"transformToStandardView", "[", "#1", "]"}], "]"}], ",", 
          RowBox[{"AbsolutePointSize", "[", "4", "]"}], ",", 
          RowBox[{"brewerDiv", "[", 
           RowBox[{
            RowBox[{"ptsCylinder", "[", 
             RowBox[{"[", 
              RowBox[{"#2", "[", 
               RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], "[", 
            RowBox[{"[", "3", "]"}], "]"}], "]"}], ",", 
          RowBox[{"Point", "[", 
           RowBox[{"transformToStandardView", "[", "#1", "]"}], "]"}]}], 
         "}"}], "&"}], ",", "pts2"}], "]"}], ",", 
     RowBox[{"(*", 
      RowBox[{
       RowBox[{"Line", "[", 
        RowBox[{"Table", "[", 
         RowBox[{
          RowBox[{"{", 
           RowBox[{
            RowBox[{"xint", "[", "t", "]"}], ",", 
            RowBox[{"yint", "[", "t", "]"}], ",", 
            RowBox[{"zint", "[", "t", "]"}]}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"t", ",", "0", ",", "1", ",", 
            RowBox[{"1", "/", "25"}]}], "}"}]}], "]"}], "]"}], ","}], "*)"}], 
     ",", 
     RowBox[{"AbsoluteThickness", "[", "5", "]"}], ",", 
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"{", 
        RowBox[{
         RowBox[{"brewerDiv", "[", "ti", "]"}], ",", 
         RowBox[{"Line", "[", 
          RowBox[{"transformToStandardView", "/@", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"{", 
              RowBox[{
               RowBox[{"xint2", "[", "ti", "]"}], ",", 
               RowBox[{"yint2", "[", "ti", "]"}], ",", 
               RowBox[{"zint2", "[", "ti", "]"}]}], "}"}], ",", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"xint2", "[", 
                RowBox[{"ti", "+", "0.01"}], "]"}], ",", 
               RowBox[{"yint2", "[", 
                RowBox[{"ti", "+", "0.01"}], "]"}], ",", 
               RowBox[{"zint2", "[", 
                RowBox[{"ti", "+", "0.01"}], "]"}]}], "}"}]}], "}"}]}], 
          "]"}]}], "}"}], ",", 
       RowBox[{"{", 
        RowBox[{"ti", ",", "minParameter", ",", 
         RowBox[{"maxParameter", "-", "0.01"}], ",", "0.01"}], "}"}]}], 
      "]"}]}], "}"}], ",", 
   RowBox[{"ViewPoint", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"0", ",", "0", ",", "Infinity"}], "}"}]}], ",", " ", 
   RowBox[{"Boxed", "\[Rule]", "False"}]}], "]"}]], "Input",ExpressionUUID->\
"bd494991-abee-4f87-8f34-af54fc20cc8b"]
}, Open  ]],

Cell[CellGroupData[{

Cell["estimate cell numbers in each chamber", "Section",ExpressionUUID->"4a72e71b-0249-412a-8bfc-6268a3ce3e66"],

Cell["\<\
Usually, the border between atrium and ventricle can be estimated from the \
data by using the point of highest torsion along the midline. However, for \
some stages of development, this estimate might be unstable. We empirically \
found a value of 0.55 is optimal to be used for all datasets. For \
reproducibility we suggest to leave the parameter at this fixed value. \
\>", "Text",ExpressionUUID->"8bb9f377-aef0-4b65-9424-b9e78d807fc0"],

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{"maxTorsionPoint", "=", 
    RowBox[{
     RowBox[{"torsion", "[", 
      RowBox[{"[", 
       RowBox[{
        RowBox[{"Position", "[", 
         RowBox[{
          RowBox[{"Abs", "[", "torsion", "]"}], ",", 
          RowBox[{"Max", "[", 
           RowBox[{"Abs", "[", 
            RowBox[{"Last", "/@", "torsion"}], "]"}], "]"}]}], "]"}], "[", 
        RowBox[{"[", 
         RowBox[{"1", ",", "1"}], "]"}], "]"}], "]"}], "]"}], "[", 
     RowBox[{"[", "1", "]"}], "]"}]}], "*)"}], "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{"maxTorsionPoint", "=", "0.55"}], ";"}]}]], "Input",ExpressionUUID-\
>"2f01d061-831d-48f8-ad57-06194c6b1a20"],

Cell["\<\
The parameter corresponding to the maximum torsion in the midline might not \
be a very accurate measure of the actual border between atrium and ventricle. \
Thus, we will compute expected number of A and V cells by averaging over a \
range of potential midpoint(s).\
\>", "Text",ExpressionUUID->"ee8398e6-a2f1-4ad9-a9b1-1586ebaedd8f"],

Cell[BoxData[
 RowBox[{
  RowBox[{"cellnums", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"Length", "/@", 
      RowBox[{"SplitBy", "[", 
       RowBox[{
        RowBox[{"SortBy", "[", 
         RowBox[{
          RowBox[{
           RowBox[{
            RowBox[{"If", "[", 
             RowBox[{
              RowBox[{
               RowBox[{"Last", "[", 
                RowBox[{"ptsCylinder", "[", 
                 RowBox[{"[", "#", "]"}], "]"}], "]"}], "\[LessEqual]", 
               RowBox[{"maxTorsionPoint", "+", "dt"}]}], ",", 
              RowBox[{"#", "\[Rule]", "\"\<A\>\""}], ",", 
              RowBox[{"#", "\[Rule]", "\"\<V\>\""}]}], "]"}], "&"}], "/@", 
           RowBox[{"Range", "[", 
            RowBox[{"Length", "[", "cells", "]"}], "]"}]}], ",", "Last"}], 
         "]"}], ",", "Last"}], "]"}]}], ",", 
     RowBox[{"{", 
      RowBox[{"dt", ",", 
       RowBox[{"-", "0.05"}], ",", "0.05", ",", "0.005"}], "}"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"c527f355-41cd-4925-816b-7dd677854345"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"N", "@", 
      RowBox[{"Mean", "[", "#", "]"}]}], ",", 
     RowBox[{"N", "@", 
      RowBox[{"StandardDeviation", "[", "#", "]"}]}]}], "}"}], "&"}], "/@", 
  RowBox[{"Transpose", "[", "cellnums", "]"}]}]], "Input",ExpressionUUID->\
"23d045aa-d691-462b-8b40-20bb497f2924"],

Cell["\<\
We will also need some rough idea of the chamber identity for each cell for \
later visualization purposes. \
\>", "Text",ExpressionUUID->"fc52dcd1-65df-43a9-a6b0-a144d9b25926"],

Cell[BoxData[
 RowBox[{
  RowBox[{"avList", "=", 
   RowBox[{"SortBy", "[", 
    RowBox[{
     RowBox[{
      RowBox[{
       RowBox[{"If", "[", 
        RowBox[{
         RowBox[{
          RowBox[{"Last", "[", 
           RowBox[{"ptsCylinder", "[", 
            RowBox[{"[", "#", "]"}], "]"}], "]"}], "\[LessEqual]", 
          RowBox[{"maxTorsionPoint", "-", "0.04"}]}], ",", 
         RowBox[{"#", "\[Rule]", "\"\<A\>\""}], ",", 
         RowBox[{"If", "[", 
          RowBox[{
           RowBox[{
            RowBox[{"Last", "[", 
             RowBox[{"ptsCylinder", "[", 
              RowBox[{"[", "#", "]"}], "]"}], "]"}], "\[GreaterEqual]", " ", 
            RowBox[{"maxTorsionPoint", "+", "0.04"}]}], ",", 
           RowBox[{"#", "\[Rule]", "\"\<V\>\""}], ",", 
           RowBox[{"#", "\[Rule]", "\"\<AV\>\""}]}], "]"}]}], "]"}], "&"}], "/@", 
      RowBox[{"Range", "[", 
       RowBox[{"Length", "[", "cells", "]"}], "]"}]}], ",", "Last"}], "]"}]}],
   ";"}]], "Input",ExpressionUUID->"5fd7acbe-6d0f-409e-b4db-afbaf7211030"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"atrialCells", ",", "avCells", ",", "ventricularCells"}], "}"}], 
   "=", 
   RowBox[{"Map", "[", 
    RowBox[{"First", ",", 
     RowBox[{"SplitBy", "[", 
      RowBox[{"avList", ",", "Last"}], "]"}], ",", 
     RowBox[{"{", "2", "}"}]}], "]"}]}], ";"}]], "Input",ExpressionUUID->\
"a93cefe6-59bc-42fd-99da-6996e4fd5e97"]
}, Open  ]],

Cell[CellGroupData[{

Cell["timing of activation onset", "Section",ExpressionUUID->"3bc30f13-0192-4302-941f-7844803ae40b"],

Cell[BoxData[
 RowBox[{"activationMap", "=", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", " ", "onsetAP", ",", " ", 
    RowBox[{"Min", "[", "onsetAP", "]"}], ",", 
    RowBox[{"Quantile", "[", 
     RowBox[{"onsetAP", ",", "0.99"}], "]"}], ",", "\"\<BrightBands\>\"", ",",
     "0.2", ",", "0.", ",", "False", ",", "3.5", ",", "False"}], 
   "]"}]}]], "Input",ExpressionUUID->"34227bd6-f40b-4f44-8744-9f3f92ffad1e"]
}, Open  ]],

Cell[CellGroupData[{

Cell["rise time of Ca signal", "Section",ExpressionUUID->"d5b1b50a-66cd-4ad8-b429-c4f216edab84"],

Cell[BoxData[
 RowBox[{"ListPlot", "[", 
  RowBox[{"Transpose", "[", 
   RowBox[{"{", 
    RowBox[{"onsetAP", ",", "riseTime"}], "}"}], "]"}], "]"}]], "Input",Expres\
sionUUID->"5daa5736-0efa-4f3f-a01c-a6bdef425d3f"],

Cell[BoxData[
 RowBox[{"Histogram", "[", 
  RowBox[{"riseTime", ",", 
   RowBox[{"PlotTheme", "\[Rule]", "\"\<Monochrome\>\""}], ",", 
   RowBox[{"Axes", "\[Rule]", 
    RowBox[{"{", 
     RowBox[{"False", ",", "True"}], "}"}]}]}], "]"}]], "Input",ExpressionUUID\
->"3b682c3f-061f-40d8-a075-16a32232b5cf"],

Cell[BoxData[""], "Input",ExpressionUUID->"91ca2436-005e-4694-affc-04a57fee2db4"],

Cell[BoxData[
 RowBox[{"riseTimeMap", "=", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", "riseTime", ",", 
    RowBox[{"Quantile", "[", 
     RowBox[{"riseTime", ",", "0.05"}], "]"}], ",", 
    RowBox[{"Quantile", "[", 
     RowBox[{"riseTime", ",", "0.95"}], "]"}], ",", "brewerDiv", ",", "0.6", 
    ",", "0.", ",", "False", ",", "3.5", ",", "False"}], "]"}]}]], "Input",Exp\
ressionUUID->"f318fb08-6d57-4493-9c63-1fae44d915ff"]
}, Open  ]],

Cell[CellGroupData[{

Cell["pacemaker cells", "Section",ExpressionUUID->"41e447d2-d8a4-4f57-9a38-0ba217f22645"],

Cell["\<\
Pacemaker cells are the earliest cells to be active in the cardiac cycle and \
are known to conduct slowly. Thus we filter the data for corresponding \
candidate cells that fulfill both criteria.\
\>", "Text",ExpressionUUID->"c2d42973-79bb-4cb2-ab87-a66625abecf1"],

Cell[BoxData[
 RowBox[{
  RowBox[{"dspeeds", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
      RowBox[{"i", ",", "2", ",", "0"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"6d05a400-9ef8-45a1-95ca-9f4d2eccf077"],

Cell[BoxData[
 RowBox[{
  RowBox[{"dspeeds", "=", 
   RowBox[{"dspeeds", "/.", 
    RowBox[{"Indeterminate", "\[Rule]", "0"}]}]}], ";"}]], "Input",ExpressionU\
UID->"5b2f7349-1665-4aef-8f88-42e658ba1da5"],

Cell[BoxData[
 RowBox[{"speedThresh", "=", 
  RowBox[{"N", "[", 
   RowBox[{"Quantile", "[", 
    RowBox[{"dspeeds", ",", "0.25"}], "]"}], "]"}]}]], "Input",ExpressionUUID-\
>"6f7257f4-f662-4c0f-9501-1e48234cfa76"],

Cell[BoxData[
 RowBox[{"onsetThresh", "=", 
  RowBox[{"N", "[", 
   RowBox[{"Quantile", "[", 
    RowBox[{"tAct", ",", "0.05"}], "]"}], "]"}]}]], "Input",ExpressionUUID->\
"64926589-d39d-4f74-bee1-96d7e2b01b43"],

Cell[BoxData[
 RowBox[{"candidateConduction", "=", 
  RowBox[{"Flatten", "[", 
   RowBox[{"Position", "[", 
    RowBox[{"dspeeds", ",", 
     RowBox[{"x_", "/;", 
      RowBox[{"x", "\[LessEqual]", "speedThresh"}]}]}], "]"}], 
   "]"}]}]], "Input",ExpressionUUID->"91367d96-f273-4954-ae51-f89d9cfca15a"],

Cell[BoxData[
 RowBox[{"candidateActivation", "=", 
  RowBox[{"Flatten", "[", 
   RowBox[{"Position", "[", 
    RowBox[{"tAct", ",", 
     RowBox[{"x_", "/;", 
      RowBox[{"x", "\[LessEqual]", " ", "onsetThresh"}]}]}], "]"}], 
   "]"}]}]], "Input",ExpressionUUID->"f9636821-837e-452c-a56a-965d039ccd26"],

Cell[BoxData[
 RowBox[{"pacemakers", "=", 
  RowBox[{"Intersection", "[", 
   RowBox[{"candidateConduction", ",", "candidateActivation"}], 
   "]"}]}]], "Input",ExpressionUUID->"c385ecc9-6784-4eb4-b1e7-e67dc9eb2fe3"],

Cell[BoxData[
 RowBox[{"pacemakers", "=", 
  RowBox[{"Sort", "[", 
   RowBox[{"pacemakers", ",", 
    RowBox[{
     RowBox[{
      RowBox[{"onsetAP", "[", 
       RowBox[{"[", "#1", "]"}], "]"}], "\[LessEqual]", 
      RowBox[{"onsetAP", "[", 
       RowBox[{"[", "#2", "]"}], "]"}]}], "&"}]}], "]"}]}]], "Input",Expressio\
nUUID->"b66cad27-a44c-4259-82fc-0db4f0850de3"],

Cell[BoxData[
 RowBox[{"pacemakerReference", "=", 
  RowBox[{"Graphics3D", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{
        RowBox[{"Point", "[", 
         RowBox[{"transformToStandardView", "[", "#", "]"}], "]"}], "&"}], "/@",
        "pts2"}], ",", 
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"brewerQ1", "[", 
           RowBox[{"[", "i", "]"}], "]"}], ",", 
          RowBox[{"AbsolutePointSize", "[", "12", "]"}], ",", 
          RowBox[{"Point", "[", 
           RowBox[{"transformToStandardView", "[", 
            RowBox[{"pts2", "[", 
             RowBox[{"[", 
              RowBox[{"pacemakers", "[", 
               RowBox[{"[", "i", "]"}], "]"}], "]"}], "]"}], "]"}], "]"}], 
          ",", "\[IndentingNewLine]", "Black", ",", 
          RowBox[{"AbsolutePointSize", "[", "5", "]"}], ",", 
          RowBox[{"Point", "[", 
           RowBox[{"transformToStandardView", "[", 
            RowBox[{"pts2", "[", 
             RowBox[{"[", 
              RowBox[{"pacemakers", "[", 
               RowBox[{"[", "i", "]"}], "]"}], "]"}], "]"}], "]"}], "]"}]}], 
         "\[IndentingNewLine]", "}"}], ",", 
        RowBox[{"{", 
         RowBox[{"i", ",", "1", ",", 
          RowBox[{"Length", "[", "pacemakers", "]"}]}], "}"}]}], "]"}]}], 
     "}"}], ",", 
    RowBox[{"ViewPoint", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0", ",", "Infinity"}], "}"}]}], ",", 
    RowBox[{"Boxed", "\[Rule]", "False"}], ",", 
    RowBox[{"ImageSize", "\[Rule]", "400"}]}], "]"}]}]], "Input",ExpressionUUI\
D->"ed95a541-46d5-48b1-8de0-8e42527e9871"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"lambda", ",", "evecs"}], "}"}], "=", 
   RowBox[{"Eigensystem", "[", 
    RowBox[{"Covariance", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"pts2", "[", 
        RowBox[{"[", "#", "]"}], "]"}], "&"}], "/@", "pacemakers"}], "]"}], 
    "]"}]}], ";"}]], "Input",ExpressionUUID->"4079fa37-1685-443e-a090-\
cac824b9def3"],

Cell[BoxData[
 RowBox[{
  RowBox[{"planarPos", "=", 
   RowBox[{"Most", "/@", 
    RowBox[{"PrincipalComponents", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"pts2", "[", 
        RowBox[{"[", "#", "]"}], "]"}], "&"}], "/@", "pacemakers"}], 
     "]"}]}]}], ";"}]], "Input",ExpressionUUID->"8505bb61-fbca-44ce-8e93-\
e3222cb0bd79"],

Cell[BoxData[
 RowBox[{"planarView", "=", 
  RowBox[{"Graphics", "[", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"brewerQ1", "[", 
        RowBox[{"[", "i", "]"}], "]"}], ",", 
       RowBox[{"AbsolutePointSize", "[", "12", "]"}], ",", 
       RowBox[{"Point", "[", 
        RowBox[{"planarPos", "[", 
         RowBox[{"[", "i", "]"}], "]"}], "]"}], ",", "Black", ",", 
       RowBox[{"AbsolutePointSize", "[", "5", "]"}], ",", 
       RowBox[{"Point", "[", 
        RowBox[{"planarPos", "[", 
         RowBox[{"[", "i", "]"}], "]"}], "]"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "pacemakers", "]"}]}], "}"}]}], "]"}], 
   "]"}]}]], "Input",ExpressionUUID->"af4596e6-9ca2-4481-a446-19a08f737d8d"]
}, Open  ]],

Cell[CellGroupData[{

Cell["metric vs. discrete conduction speed", "Section",ExpressionUUID->"8fbb0df6-68e1-4f8a-bfc5-c8516096f041"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"dspeeds", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
      RowBox[{"i", ",", "2", ",", "0"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"metricSpeeds", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
      RowBox[{"i", ",", "2", ",", "0"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}]}], 
  ";"}]}], "Input",ExpressionUUID->"02b6cac7-3b1d-4682-9258-e6131464499b"],

Cell[BoxData[
 RowBox[{"metricSpeedMap", " ", "=", " ", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
       RowBox[{"i", ",", "2", ",", "0"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}], ",", "0", 
    ",", "maxMetricSpeed", ",", "brewerDiv", ",", "0.6", ",", "0.8", ",", 
    "False", ",", "3.5"}], "]"}]}]], "Input",ExpressionUUID->"a03928db-c672-\
4776-bfce-f66639ff19cd"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"feat", "=", 
   RowBox[{
    RowBox[{
     RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
      RowBox[{"#", ",", "2", ",", "0", ",", "tAct"}], "]"}], "&"}], "/@", 
    RowBox[{"Range", "[", 
     RowBox[{"Length", "[", "cells", "]"}], "]"}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Graphics", "[", 
  RowBox[{
   RowBox[{"MapIndexed", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"AbsolutePointSize", "[", "8", "]"}], ",", 
        RowBox[{"brewerDiv", "[", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{"feat", "[", 
            RowBox[{"[", 
             RowBox[{"#2", "[", 
              RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], ")"}], "/", 
          RowBox[{"(", "4", ")"}]}], "]"}], ",", 
        RowBox[{"Point", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{
            RowBox[{"-", "10"}], 
            RowBox[{"#1", "[", 
             RowBox[{"[", "3", "]"}], "]"}]}], ",", 
           RowBox[{"#1", "[", 
            RowBox[{"[", "2", "]"}], "]"}]}], "}"}], "]"}]}], "}"}], "&"}], 
     ",", "ptsCylinder"}], "]"}], ",", 
   RowBox[{"Axes", "\[Rule]", "True"}]}], "]"}]}], "Input",ExpressionUUID->\
"712bc132-b18a-4310-8e3d-83e39425163d"],

Cell[BoxData[
 RowBox[{"averageDelayMap", " ", "=", " ", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
       RowBox[{"i", ",", "2", ",", "0"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", 
        RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}], ",", 
    "minDelay", ",", ".18", ",", "brewerDiv", ",", "0.6", ",", "0.8", ",", 
    "False", ",", "3.5"}], "]"}]}]], "Input",ExpressionUUID->"87f7c7ed-3c60-\
4932-9db2-68507b3b34ab"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"feat", "=", "dspeeds"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"Graphics", "[", 
  RowBox[{
   RowBox[{"MapIndexed", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"AbsolutePointSize", "[", "8", "]"}], ",", 
        RowBox[{"brewerDiv", "[", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{
            RowBox[{"feat", "[", 
             RowBox[{"[", 
              RowBox[{"#2", "[", 
               RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], "-", "0"}], 
           ")"}], "/", 
          RowBox[{"(", 
           RowBox[{"maxDelay", "-", "0"}], ")"}]}], "]"}], ",", 
        RowBox[{"Point", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{
            RowBox[{"-", "10"}], 
            RowBox[{"#1", "[", 
             RowBox[{"[", "3", "]"}], "]"}]}], ",", 
           RowBox[{"#1", "[", 
            RowBox[{"[", "2", "]"}], "]"}]}], "}"}], "]"}]}], "}"}], "&"}], 
     ",", "ptsCylinder"}], "]"}], ",", 
   RowBox[{"Axes", "\[Rule]", "True"}]}], "]"}]}], "Input",ExpressionUUID->\
"65415cbb-2243-4a59-8804-35049a932385"],

Cell[BoxData[
 RowBox[{"speedScatter", "=", 
  RowBox[{"ListPlot", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
           RowBox[{"#", ",", "2", ",", "0"}], "]"}], ",", 
          RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
           RowBox[{"#", ",", "2", ",", "0"}], "]"}]}], "}"}], "&"}], "/@", 
       "atrialCells"}], ",", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
           RowBox[{"#", ",", "2", ",", "0"}], "]"}], ",", 
          RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
           RowBox[{"#", ",", "2", ",", "0"}], "]"}]}], "}"}], "&"}], "/@", 
       "ventricularCells"}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
           RowBox[{"#", ",", "2", ",", "0"}], "]"}], ",", 
          RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
           RowBox[{"#", ",", "2", ",", "0"}], "]"}]}], "}"}], "&"}], "/@", 
       "avCells"}]}], "}"}], ",", 
    RowBox[{"PlotStyle", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"atrialColor", ",", "ventricularColor", ",", "Gray"}], 
      "}"}]}]}], "]"}]}]], "Input",ExpressionUUID->"62080309-7411-431f-a4ed-\
f777a0264819"]
}, Open  ]],

Cell[CellGroupData[{

Cell["estimate local cell density and shape", "Section",ExpressionUUID->"2b674b6b-2759-454b-b439-35a9afe8d0f0"],

Cell[BoxData[
 RowBox[{"cellshapePlot", "=", 
  RowBox[{"Graphics3D", "[", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"Opacity", "[", "1", "]"}], ",", 
        RowBox[{
         RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
         RowBox[{"[", 
          RowBox[{"-", "2"}], "]"}], "]"}]}], "}"}], "&"}], "/@", 
     RowBox[{"Range", "[", 
      RowBox[{"Length", "[", "cells", "]"}], "]"}]}], ",", 
    RowBox[{"ViewPoint", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0", ",", "Infinity"}], "}"}]}], ",", 
    RowBox[{"Boxed", "\[Rule]", "False"}], ",", 
    RowBox[{"ImageSize", "\[Rule]", "800"}]}], "]"}]}]], "Input",ExpressionUUI\
D->"92d89501-d7be-41d0-9c10-0b3a56340643"],

Cell[BoxData[
 RowBox[{"cellshapePlotActTime", "=", 
  RowBox[{"Graphics3D", "[", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"ColorData", "[", 
         RowBox[{"\"\<BrightBands\>\"", ",", 
          RowBox[{
           RowBox[{"(", 
            RowBox[{
             RowBox[{"onsetAP", "[", 
              RowBox[{"[", "#", "]"}], "]"}], "-", 
             RowBox[{"Min", "[", "onsetAP", "]"}]}], ")"}], "/", 
           RowBox[{"(", "123", ")"}]}]}], "]"}], ",", 
        RowBox[{
         RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
         RowBox[{"[", 
          RowBox[{"-", "2"}], "]"}], "]"}]}], "}"}], "&"}], "/@", 
     RowBox[{"Range", "[", 
      RowBox[{"Length", "[", "cells", "]"}], "]"}]}], ",", 
    RowBox[{"ViewPoint", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0", ",", "Infinity"}], "}"}]}], ",", 
    RowBox[{"Boxed", "\[Rule]", "False"}], ",", 
    RowBox[{"ImageSize", "\[Rule]", "800"}], ",", 
    RowBox[{"Lighting", "\[Rule]", "\"\<Neutral\>\""}]}], "]"}]}]], "Input",Ex\
pressionUUID->"d7f657b2-d17a-4595-b316-cb0eafcff63c"],

Cell[BoxData[
 RowBox[{
  RowBox[{"volumes", " ", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
      RowBox[{"[", "4", "]"}], "]"}], "&"}], "/@", 
    RowBox[{"Range", "[", 
     RowBox[{"Length", "[", "cells", "]"}], "]"}]}]}], ";"}]], "Input",Express\
ionUUID->"0c9b76c8-2da4-4afe-91ab-a55aecf7df1f"],

Cell[BoxData[
 RowBox[{
  RowBox[{"areas", " ", "=", " ", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
      RowBox[{"[", "5", "]"}], "]"}], "&"}], "/@", 
    RowBox[{"Range", "[", 
     RowBox[{"Length", "[", "cells", "]"}], "]"}]}]}], ";"}]], "Input",Express\
ionUUID->"ddb371a9-48a3-4803-b268-3e19e1a7e8ff"],

Cell["\<\
To visualize and individual dataset the robust quantiles should be used to \
adjust the color scale instead of actual min and max of the data.\
\>", "Text",ExpressionUUID->"797ee6e3-93f4-49d5-9218-c488832676cd"],

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{"min", ",", "max", ",", "span"}], "}"}], "=", 
  RowBox[{"{", 
   RowBox[{
    RowBox[{"Min", "[", "areas", "]"}], ",", " ", 
    RowBox[{"Quantile", "[", 
     RowBox[{"areas", ",", "0.95"}], "]"}], ",", 
    RowBox[{
     RowBox[{"Quantile", "[", 
      RowBox[{"areas", ",", "0.95"}], "]"}], "-", 
     RowBox[{"Min", "[", "areas", "]"}]}]}], "}"}]}]], "Input",ExpressionUUID-\
>"1e2dce69-932a-4e11-bdea-f96b5501d6ca"],

Cell["\<\
However, to facilitate visual comparison across datasets, the robust \
statistics should be taken across all samples. Here are the values for \
reproducibility:\
\>", "Text",ExpressionUUID->"bf0c3983-5c40-4bb5-8207-184f4bdec318"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"{", 
    RowBox[{"min", ",", "max", ",", "span"}], "}"}], "=", 
   RowBox[{"{", 
    RowBox[{
    "4325.125782909306`", ",", "279616.4530206217`", ",", 
     "275291.3272377124`"}], "}"}]}], ";"}]], "Input",ExpressionUUID->\
"72c48416-ac56-4903-8b1c-ddce0d4ac97a"],

Cell[BoxData[
 RowBox[{"cellShapePlotSizes", "=", 
  RowBox[{"Graphics3D", "[", 
   RowBox[{
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"EdgeForm", "[", 
         RowBox[{"Directive", "[", 
          RowBox[{"Thick", ",", "Black"}], "]"}], "]"}], ",", 
        RowBox[{"Specularity", "[", "0", "]"}], ",", 
        RowBox[{"If", "[", 
         RowBox[{
          RowBox[{
           RowBox[{
            RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
            RowBox[{"[", "6", "]"}], "]"}], "\[LessEqual]", "5"}], ",", 
          RowBox[{"Opacity", "[", "0.05", "]"}], ",", 
          RowBox[{"Opacity", "[", "1", "]"}]}], "]"}], ",", 
        RowBox[{"brewerDiv", "[", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{
            RowBox[{
             RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
             RowBox[{"[", "5", "]"}], "]"}], "-", 
            RowBox[{"(", "min", ")"}]}], ")"}], "/", 
          RowBox[{"(", "span", ")"}]}], "]"}], ",", 
        RowBox[{
         RowBox[{"estimateCellShape", "[", "#", "]"}], "[", 
         RowBox[{"[", 
          RowBox[{"-", "2"}], "]"}], "]"}]}], "}"}], "&"}], "/@", 
     RowBox[{"Range", "[", 
      RowBox[{"Length", "[", "cells", "]"}], "]"}]}], ",", 
    RowBox[{"Lighting", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"{", 
       RowBox[{"\"\<Ambient\>\"", ",", "White"}], "}"}], "}"}]}], ",", 
    RowBox[{"ViewPoint", "\[Rule]", 
     RowBox[{"{", 
      RowBox[{"0", ",", "0", ",", "Infinity"}], "}"}]}], ",", 
    RowBox[{"Boxed", "\[Rule]", "False"}], ",", 
    RowBox[{"ImageSize", "\[Rule]", "800"}]}], "]"}]}]], "Input",ExpressionUUI\
D->"1a0c8147-ac04-4f5a-9840-ac02ab8147b6"]
}, Open  ]],

Cell[CellGroupData[{

Cell["plot Calcium transients", "Section",ExpressionUUID->"5d58b44f-f503-448b-8410-13796f9f67ee"],

Cell[BoxData[
 RowBox[{"waveFormsShapePlotColSlope", "=", 
  RowBox[{"ListLinePlot", "[", 
   RowBox[{"shifted", ",", 
    RowBox[{"PlotStyle", "\[Rule]", 
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"Directive", "[", 
        RowBox[{
         RowBox[{"Opacity", "[", "0.15", "]"}], ",", 
         RowBox[{"brewerDiv", "[", 
          RowBox[{
           RowBox[{"Rescale", "[", "riseTime", "]"}], "[", 
           RowBox[{"[", "i", "]"}], "]"}], "]"}]}], "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"i", ",", "1", ",", 
         RowBox[{"Length", "[", "res", "]"}]}], "}"}]}], "]"}]}], ",", 
    RowBox[{"LabelStyle", "\[Rule]", "Medium"}]}], "]"}]}]], "Input",Expressio\
nUUID->"116be407-945d-4f64-932b-7b9576d3be51"],

Cell[BoxData[
 RowBox[{"waveFormsShapePlotColOnset", "=", 
  RowBox[{"ListLinePlot", "[", 
   RowBox[{"res", ",", 
    RowBox[{"PlotStyle", "\[Rule]", 
     RowBox[{"Table", "[", 
      RowBox[{
       RowBox[{"Directive", "[", 
        RowBox[{
         RowBox[{"Opacity", "[", "0.15", "]"}], ",", 
         RowBox[{"ColorData", "[", 
          RowBox[{"\"\<BrightBands\>\"", ",", 
           RowBox[{
            RowBox[{"Rescale", "[", "onsetAP", "]"}], "[", 
            RowBox[{"[", "i", "]"}], "]"}]}], "]"}]}], "]"}], ",", 
       RowBox[{"{", 
        RowBox[{"i", ",", "1", ",", 
         RowBox[{"Length", "[", "res", "]"}]}], "}"}]}], "]"}]}], ",", 
    RowBox[{"LabelStyle", "\[Rule]", "Medium"}]}], "]"}]}]], "Input",Expressio\
nUUID->"d96c92e5-e446-40bd-b483-56021f28b7f6"]
}, Open  ]],

Cell[CellGroupData[{

Cell["\<\
Simulation of isotropic nearest neighbor signal propagation (SIR model)\
\>", "Section",ExpressionUUID->"a44d478e-8132-47b2-bedf-e576f26c8646"],

Cell[BoxData[{
 RowBox[{"Clear", "[", "getNeighbors", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"getNeighbors", "[", 
   RowBox[{"cell_", ",", "gdistMat_"}], "]"}], ":=", 
  RowBox[{"Flatten", "[", 
   RowBox[{"Position", "[", 
    RowBox[{
     RowBox[{"gdistMat", "[", 
      RowBox[{"[", "cell", "]"}], "]"}], ",", 
     RowBox[{"x_", "/;", 
      RowBox[{"0", "<", "x", "\[LessEqual]", "1"}]}]}], "]"}], 
   "]"}]}], "\[IndentingNewLine]", 
 RowBox[{"Clear", "[", "simulationStep", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"simulationStep", "[", 
   RowBox[{"active_", ",", "susceptible_", ",", "recovering_"}], "]"}], ":=", 
  
  RowBox[{"Module", "[", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"newactive", ",", "newsusceptible", ",", "newrecovering"}], 
     "}"}], ",", "\[IndentingNewLine]", 
    RowBox[{
     RowBox[{"newactive", "=", 
      RowBox[{"Complement", "[", 
       RowBox[{
        RowBox[{"Union", "[", 
         RowBox[{"Flatten", "[", 
          RowBox[{
           RowBox[{
            RowBox[{"getNeighbors", "[", 
             RowBox[{"#", ",", "gdistMat"}], "]"}], "&"}], "/@", "active"}], 
          "]"}], "]"}], ",", 
        RowBox[{"Union", "[", 
         RowBox[{"active", ",", "recovering"}], "]"}]}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"newrecovering", " ", "=", " ", 
      RowBox[{"Union", "[", 
       RowBox[{"Join", "[", 
        RowBox[{"recovering", ",", " ", "active"}], "]"}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"newsusceptible", " ", "=", " ", 
      RowBox[{"Complement", "[", 
       RowBox[{"susceptible", ",", "newactive"}], "]"}]}], ";", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
      "newactive", ",", " ", "newsusceptible", ",", " ", "newrecovering"}], 
      "}"}]}]}], "\[IndentingNewLine]", "]"}]}]}], "Input",ExpressionUUID->\
"d73a3857-bd5a-4947-94a7-2c7639ec9e11"],

Cell[BoxData[
 RowBox[{"source", "=", "pacemakers"}]], "Input",ExpressionUUID->"5d716f38-8493-4b26-a9e7-32c32a0b47ea"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"susceptible", "=", 
   RowBox[{"Complement", "[", 
    RowBox[{
     RowBox[{"Range", "[", 
      RowBox[{"Length", "[", "cells", "]"}], "]"}], ",", "source"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"active", " ", "=", " ", "source"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"recovering", "=", 
   RowBox[{"{", "}"}]}], ";"}]}], "Input",ExpressionUUID->"fc8c5dd0-9de9-4950-\
b3b4-361601a525c7"],

Cell[BoxData[
 RowBox[{"simulation", "=", 
  RowBox[{"First", "/@", 
   RowBox[{"NestList", " ", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"simulationStep", "[", 
       RowBox[{"Sequence", "@@", "#"}], "]"}], "&"}], ",", 
     RowBox[{"{", 
      RowBox[{"active", ",", "susceptible", ",", "recovering"}], "}"}], ",", 
     "15"}], "]"}]}]}]], "Input",ExpressionUUID->"ee6322b8-42f4-48d1-b480-\
2b58dbdf4851"],

Cell[BoxData[
 RowBox[{
  RowBox[{"onsetSim", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"Position", "[", 
       RowBox[{"simulation", ",", "i"}], "]"}], "[", 
      RowBox[{"[", 
       RowBox[{"1", ",", "1"}], "]"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"4a199713-4e66-4478-93e0-5b45f901953f"],

Cell["\<\
We can look at the synthetic activation front. They look different than the \
measured patterns:\
\>", "Text",ExpressionUUID->"cb9cd468-0d6a-46ef-8545-cd28a6ca3a5d"],

Cell[BoxData[
 RowBox[{"activationMapSim", "=", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", " ", "onsetSim", ",", " ", 
    RowBox[{"Min", "[", "onsetSim", "]"}], ",", 
    RowBox[{"Max", "[", "onsetSim", "]"}], ",", "\"\<BrightBands\>\"", ",", 
    "0.2", ",", "0.", ",", "False", ",", "3.5", ",", "False"}], 
   "]"}]}]], "Input",ExpressionUUID->"f361cc5b-01b6-41a8-893a-d5d6dc2493e3"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"feat", "=", "onsetSim"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"Quantile", "[", 
  RowBox[{"feat", ",", "0.95"}], "]"}], "\[IndentingNewLine]", 
 RowBox[{"Graphics", "[", 
  RowBox[{
   RowBox[{"MapIndexed", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"AbsolutePointSize", "[", "8", "]"}], ",", 
        RowBox[{"ColorData", "[", 
         RowBox[{"\"\<BrightBands\>\"", ",", 
          RowBox[{
           RowBox[{"(", 
            RowBox[{
             RowBox[{"feat", "[", 
              RowBox[{"[", 
               RowBox[{"#2", "[", 
                RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], "-", 
             RowBox[{"Min", "[", "feat", "]"}]}], ")"}], "/", 
           RowBox[{"(", 
            RowBox[{
             RowBox[{"Max", "[", "feat", "]"}], "-", 
             RowBox[{"Min", "[", "feat", "]"}]}], ")"}]}]}], "]"}], ",", 
        RowBox[{"Point", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{
            RowBox[{"-", "10"}], 
            RowBox[{"#1", "[", 
             RowBox[{"[", "3", "]"}], "]"}]}], ",", 
           RowBox[{"#1", "[", 
            RowBox[{"[", "2", "]"}], "]"}]}], "}"}], "]"}]}], "}"}], "&"}], 
     ",", "ptsCylinder"}], "]"}], ",", 
   RowBox[{"Axes", "\[Rule]", "True"}]}], "]"}]}], "Input",ExpressionUUID->\
"5cf9e979-ffc9-42be-bef2-a843a8247069"],

Cell["\<\
The discrete conduction speed show no pattern and the metric speeds are \
simply biased due to the longer distances in the atrium (as expected).\
\>", "Text",ExpressionUUID->"ba0716b7-8f91-4c6e-bea9-43daec667351"],

Cell[BoxData[
 RowBox[{
  RowBox[{"dspeedsSim", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"estimateDiscreteWaveSpeedAtCell", "[", 
      RowBox[{"i", ",", "2", ",", "0", ",", "onsetSim"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"8930781b-08d6-4e1a-b0d3-31d1f4ea2ce3"],

Cell[BoxData[
 RowBox[{"averageDelayMapSim", " ", "=", " ", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", "dspeedsSim", ",", 
    RowBox[{"Min", "[", "dspeedsSim", "]"}], ",", 
    RowBox[{"Quantile", "[", 
     RowBox[{"dspeedsSim", ",", "0.99"}], "]"}], ",", "brewerDiv", ",", "0.6",
     ",", "0.8", ",", "False", ",", "3.5"}], "]"}]}]], "Input",ExpressionUUID-\
>"c8705382-16d3-418c-9bff-ad28682e9b79"],

Cell[BoxData[
 RowBox[{
  RowBox[{"mspeedsSim", "=", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"estimateMetricWaveSpeedAtCell", "[", 
      RowBox[{"i", ",", "2", ",", "0", ",", "onsetSim"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "cells", "]"}]}], "}"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"44ab4bd1-56f7-47e9-a129-00476cc159d6"],

Cell[BoxData[
 RowBox[{"averageMetricMapSim", " ", "=", " ", 
  RowBox[{"viewHeart", "[", 
   RowBox[{"cells", ",", "mspeedsSim", ",", 
    RowBox[{"Min", "[", "mspeedsSim", "]"}], ",", 
    RowBox[{"Quantile", "[", 
     RowBox[{"mspeedsSim", ",", "0.99"}], "]"}], ",", "brewerDiv", ",", "0.6",
     ",", "0.8", ",", "False", ",", "3.5"}], "]"}]}]], "Input",ExpressionUUID-\
>"73573994-72b7-4972-99b9-ab2e1c8abb59"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"feat", "=", "dspeedsSim"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"Quantile", "[", 
  RowBox[{"feat", ",", "0.95"}], "]"}], "\[IndentingNewLine]", 
 RowBox[{"Graphics", "[", 
  RowBox[{
   RowBox[{"MapIndexed", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"AbsolutePointSize", "[", "8", "]"}], ",", 
        RowBox[{"brewerDiv", "[", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{
            RowBox[{"feat", "[", 
             RowBox[{"[", 
              RowBox[{"#2", "[", 
               RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], "-", 
            RowBox[{"Min", "[", "feat", "]"}]}], ")"}], "/", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{"Quantile", "[", 
             RowBox[{"feat", ",", "0.99"}], "]"}], "-", 
            RowBox[{"Min", "[", "feat", "]"}]}], ")"}]}], "]"}], ",", 
        RowBox[{"Point", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{
            RowBox[{"-", "10"}], 
            RowBox[{"#1", "[", 
             RowBox[{"[", "3", "]"}], "]"}]}], ",", 
           RowBox[{"#1", "[", 
            RowBox[{"[", "2", "]"}], "]"}]}], "}"}], "]"}]}], "}"}], "&"}], 
     ",", "ptsCylinder"}], "]"}], ",", 
   RowBox[{"Axes", "\[Rule]", "True"}]}], "]"}]}], "Input",ExpressionUUID->\
"a2e76565-883b-4000-83dd-fdac724eeabf"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"feat", "=", "mspeedsSim"}], ";"}], "\[IndentingNewLine]", 
 RowBox[{"Quantile", "[", 
  RowBox[{"feat", ",", "0.95"}], "]"}], "\[IndentingNewLine]", 
 RowBox[{"Graphics", "[", 
  RowBox[{
   RowBox[{"MapIndexed", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{"AbsolutePointSize", "[", "8", "]"}], ",", 
        RowBox[{"brewerDiv", "[", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{
            RowBox[{"feat", "[", 
             RowBox[{"[", 
              RowBox[{"#2", "[", 
               RowBox[{"[", "1", "]"}], "]"}], "]"}], "]"}], "-", 
            RowBox[{"Min", "[", "feat", "]"}]}], ")"}], "/", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{"Max", "[", "feat", "]"}], "-", 
            RowBox[{"Min", "[", "feat", "]"}]}], ")"}]}], "]"}], ",", 
        RowBox[{"Point", "[", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{
            RowBox[{"-", "10"}], 
            RowBox[{"#1", "[", 
             RowBox[{"[", "3", "]"}], "]"}]}], ",", 
           RowBox[{"#1", "[", 
            RowBox[{"[", "2", "]"}], "]"}]}], "}"}], "]"}]}], "}"}], "&"}], 
     ",", "ptsCylinder"}], "]"}], ",", 
   RowBox[{"Axes", "\[Rule]", "True"}]}], "]"}]}], "Input",ExpressionUUID->\
"21e5e51c-d0e0-4dfa-871a-3ae17378932e"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{1573, 1084},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
PrintingCopies->1,
PrintingPageRange->{1, Automatic},
ShowCellBracket->Automatic,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"11.1 for Mac OS X x86 (32-bit, 64-bit Kernel) (April 27, \
2017)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1486, 35, 144, 2, 92, "Title", "ExpressionUUID" -> \
"265e1ae8-b6c4-4318-9c7f-330aeae00951"],
Cell[1633, 39, 258, 4, 30, "Text", "ExpressionUUID" -> \
"85778b1f-2ffc-485a-bf7d-37c801009af2"],
Cell[1894, 45, 196, 4, 32, "Input", "ExpressionUUID" -> \
"8fcce809-2c09-487c-adb7-a628ca59c731"],
Cell[2093, 51, 264, 6, 32, "Input", "ExpressionUUID" -> \
"a91c74ba-3492-4f58-a8d4-688f8c8c52f1"],
Cell[CellGroupData[{
Cell[2382, 61, 102, 0, 63, "Subchapter", "ExpressionUUID" -> \
"450d5e3a-636f-462d-bd7b-c754640511af"],
Cell[2487, 63, 298, 4, 30, "Text", "ExpressionUUID" -> \
"64a56c60-d3dd-4d1c-96f4-9f4b72913b22"],
Cell[2788, 69, 357, 8, 54, "Input", "ExpressionUUID" -> \
"7bb4cd30-45c1-49d4-89e9-aa35a8fba92a"],
Cell[3148, 79, 175, 3, 30, "Text", "ExpressionUUID" -> \
"f0567b58-db90-4320-8e39-b91a157309a0"],
Cell[3326, 84, 310, 8, 54, "Input", "ExpressionUUID" -> \
"03b06680-1abb-47d2-8e4e-a2470599b620"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3673, 97, 107, 0, 63, "Subchapter", "ExpressionUUID" -> \
"5d0fea98-d224-4ac4-bbbb-6575f8574972"],
Cell[CellGroupData[{
Cell[3805, 101, 102, 0, 64, "Section", "ExpressionUUID" -> \
"26e93bb1-bb90-40ec-b7d2-459898f65a46"],
Cell[3910, 103, 928, 28, 117, "Input", "ExpressionUUID" -> \
"7c90d0f6-89ea-4e18-b3a8-09ca8452d43f"]
}, Open  ]],
Cell[CellGroupData[{
Cell[4875, 136, 104, 0, 64, "Section", "ExpressionUUID" -> \
"f1f6bee0-1d65-4d93-8d6c-91061c3d7540"],
Cell[4982, 138, 1427, 38, 180, "Input", "ExpressionUUID" -> \
"f07438aa-5c17-4055-976d-8a38bd55e71d"]
}, Open  ]],
Cell[CellGroupData[{
Cell[6446, 181, 92, 0, 64, "Section", "ExpressionUUID" -> \
"52af9ff1-e475-4056-af10-bad0d2641181"],
Cell[6541, 183, 1372, 36, 264, "Input", "ExpressionUUID" -> \
"50e61ea8-0177-44aa-9ae8-78a56f2d34ce"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[7962, 225, 108, 0, 63, "Subchapter", "ExpressionUUID" -> \
"d0db934c-da87-4e51-8f29-ea4d592f5436"],
Cell[CellGroupData[{
Cell[8095, 229, 118, 0, 64, "Section", "ExpressionUUID" -> \
"b1f03652-a172-4473-8944-54e563d9bb7c"],
Cell[8216, 231, 3410, 108, 306, "Input", "ExpressionUUID" -> \
"108765ff-96c4-4278-9cba-42d75ec3b654"]
}, Open  ]],
Cell[CellGroupData[{
Cell[11663, 344, 101, 0, 64, "Section", "ExpressionUUID" -> \
"7a810d62-b5ca-49b0-b67b-bd36f145ecc8"],
Cell[11767, 346, 322, 5, 30, "Text", "ExpressionUUID" -> \
"37ff9078-f7e6-4d41-b9bb-08be3c87f3c8"],
Cell[12092, 353, 1425, 44, 159, "Input", "ExpressionUUID" -> \
"ad85bc9b-03ad-4fd4-b013-d56b31a1ef05"],
Cell[13520, 399, 1012, 32, 117, "Input", "ExpressionUUID" -> \
"5d0cb75c-945c-481d-8065-36b3d0335614"]
}, Open  ]],
Cell[CellGroupData[{
Cell[14569, 436, 124, 0, 64, "Section", "ExpressionUUID" -> \
"d1e74493-6db6-44fc-966e-6909021974e5"],
Cell[14696, 438, 182, 3, 30, "Text", "ExpressionUUID" -> \
"c41fb71b-9cc9-4047-85d7-ff3ffcf104ca"],
Cell[14881, 443, 1728, 51, 117, "Input", "ExpressionUUID" -> \
"b2b9f154-040a-41cc-aada-6ccd144e6a78"],
Cell[16612, 496, 218, 3, 30, "Text", "ExpressionUUID" -> \
"a40586c3-f012-492d-9001-8765b29f1dfb"],
Cell[16833, 501, 1594, 50, 54, "Input", "ExpressionUUID" -> \
"3be82bea-e379-438b-9927-2bd77870a936"],
Cell[18430, 553, 141, 3, 32, "Input", "ExpressionUUID" -> \
"0733cccd-8054-473f-9f24-44e6dc35e529"],
Cell[18574, 558, 181, 3, 30, "Text", "ExpressionUUID" -> \
"416bdfd9-9c0c-45d9-a3ec-2c26d1d6f746"],
Cell[18758, 563, 360, 9, 54, "Input", "ExpressionUUID" -> \
"380638bf-c757-4fb9-a0b5-f533e0f465b9"]
}, Open  ]],
Cell[CellGroupData[{
Cell[19155, 577, 118, 0, 64, "Section", "ExpressionUUID" -> \
"89036fef-7914-4f5e-8188-6b7a8f95f352"],
Cell[19276, 579, 569, 18, 32, "Input", "ExpressionUUID" -> \
"972cce38-8efa-4f58-9a1a-9081a6203f8a"],
Cell[19848, 599, 122, 0, 30, "Text", "ExpressionUUID" -> \
"8b6386eb-c05d-457d-aec2-740ae3331370"],
Cell[19973, 601, 168, 4, 32, "Input", "ExpressionUUID" -> \
"87f85632-d317-4c9d-90c4-cd4327da454e"],
Cell[20144, 607, 326, 5, 49, "Text", "ExpressionUUID" -> \
"ab83705e-43b4-4c03-bbce-9be6505af92e"],
Cell[20473, 614, 392, 11, 32, "Input", "ExpressionUUID" -> \
"2cd0f545-1f90-4335-afca-a856a000826f"],
Cell[20868, 627, 110, 0, 30, "Text", "ExpressionUUID" -> \
"bd76d4e9-00ab-4f4c-afd0-0e44c71efabb"],
Cell[20981, 629, 759, 24, 54, "Input", "ExpressionUUID" -> \
"3d67db05-cb24-40da-b299-3209478311e5"],
Cell[21743, 655, 298, 8, 54, "Input", "ExpressionUUID" -> \
"84b13af9-977f-4b34-87f2-e7606ef44631"],
Cell[22044, 665, 182, 3, 30, "Text", "ExpressionUUID" -> \
"5a881446-0259-4168-995a-c78f6026fc5d"],
Cell[22229, 670, 433, 13, 32, "Input", "ExpressionUUID" -> \
"335e9f18-6571-4612-8a82-70985b0ceaff"],
Cell[22665, 685, 129, 0, 30, "Text", "ExpressionUUID" -> \
"b26999aa-3aee-4a18-aec3-a746638cb8e2"],
Cell[22797, 687, 271, 6, 54, "Input", "ExpressionUUID" -> \
"fb731fad-ef64-4f53-8dbf-1cb8cb531e27"],
Cell[23071, 695, 206, 3, 30, "Text", "ExpressionUUID" -> \
"ebb497bb-fabd-455a-bddb-0b90510df441"],
Cell[23280, 700, 853, 22, 138, "Input", "ExpressionUUID" -> \
"e4fa0bef-1317-47b8-b997-1b6c695accac"],
Cell[24136, 724, 1147, 33, 75, "Input", "ExpressionUUID" -> \
"081a229d-1bf6-447e-b5ba-1990d8380109"],
Cell[25286, 759, 1475, 40, 54, "Input", "ExpressionUUID" -> \
"02b56f67-641e-4938-957d-8b786ceb874e"],
Cell[26764, 801, 155, 2, 30, "Text", "ExpressionUUID" -> \
"b5948897-8c6f-4c0d-8cca-bb8e2cd731d2"],
Cell[26922, 805, 555, 16, 32, "Input", "ExpressionUUID" -> \
"3bc2305b-43d7-44f9-bf23-ea21270ec043"],
Cell[27480, 823, 512, 14, 32, "Input", "ExpressionUUID" -> \
"69241621-8c0c-488a-a96e-1dccc0b9844f"],
Cell[27995, 839, 466, 14, 54, "Input", "ExpressionUUID" -> \
"2780ad10-a179-46a4-8aec-616041fd4503"],
Cell[28464, 855, 244, 6, 32, "Input", "ExpressionUUID" -> \
"c6719178-1bb3-4b06-bc66-630233678b54"],
Cell[28711, 863, 201, 3, 30, "Text", "ExpressionUUID" -> \
"93feffdb-cfb6-4541-ba13-56630595f59f"],
Cell[28915, 868, 638, 20, 32, "Input", "ExpressionUUID" -> \
"028d40ed-8900-47dd-bac6-70c70c120dce"],
Cell[29556, 890, 392, 12, 32, "Input", "ExpressionUUID" -> \
"458052b4-7663-4430-a31a-1d477afa4fd8"]
}, Open  ]],
Cell[CellGroupData[{
Cell[29985, 907, 132, 0, 64, "Section", "ExpressionUUID" -> \
"18249000-c0ca-4f30-9668-fdf0efe87d09"],
Cell[30120, 909, 2794, 72, 138, "Input", "ExpressionUUID" -> \
"bd494991-abee-4f87-8f34-af54fc20cc8b"]
}, Open  ]],
Cell[CellGroupData[{
Cell[32951, 986, 111, 0, 64, "Section", "ExpressionUUID" -> \
"4a72e71b-0249-412a-8bfc-6268a3ce3e66"],
Cell[33065, 988, 450, 6, 49, "Text", "ExpressionUUID" -> \
"8bb9f377-aef0-4b65-9424-b9e78d807fc0"],
Cell[33518, 996, 693, 19, 54, "Input", "ExpressionUUID" -> \
"2f01d061-831d-48f8-ad57-06194c6b1a20"],
Cell[34214, 1017, 345, 5, 49, "Text", "ExpressionUUID" -> \
"ee8398e6-a2f1-4ad9-a9b1-1586ebaedd8f"],
Cell[34562, 1024, 1039, 27, 32, "Input", "ExpressionUUID" -> \
"c527f355-41cd-4925-816b-7dd677854345"],
Cell[35604, 1053, 352, 10, 32, "Input", "ExpressionUUID" -> \
"23d045aa-d691-462b-8b40-20bb497f2924"],
Cell[35959, 1065, 187, 3, 30, "Text", "ExpressionUUID" -> \
"fc52dcd1-65df-43a9-a6b0-a144d9b25926"],
Cell[36149, 1070, 1040, 26, 32, "Input", "ExpressionUUID" -> \
"5fd7acbe-6d0f-409e-b4db-afbaf7211030"],
Cell[37192, 1098, 386, 11, 32, "Input", "ExpressionUUID" -> \
"a93cefe6-59bc-42fd-99da-6996e4fd5e97"]
}, Open  ]],
Cell[CellGroupData[{
Cell[37615, 1114, 100, 0, 64, "Section", "ExpressionUUID" -> \
"3bc30f13-0192-4302-941f-7844803ae40b"],
Cell[37718, 1116, 426, 8, 32, "Input", "ExpressionUUID" -> \
"34227bd6-f40b-4f44-8744-9f3f92ffad1e"]
}, Open  ]],
Cell[CellGroupData[{
Cell[38181, 1129, 96, 0, 64, "Section", "ExpressionUUID" -> \
"d5b1b50a-66cd-4ad8-b429-c4f216edab84"],
Cell[38280, 1131, 216, 5, 32, "Input", "ExpressionUUID" -> \
"5daa5736-0efa-4f3f-a01c-a6bdef425d3f"],
Cell[38499, 1138, 305, 7, 32, "Input", "ExpressionUUID" -> \
"3b682c3f-061f-40d8-a075-16a32232b5cf"],
Cell[38807, 1147, 81, 0, 32, "Input", "ExpressionUUID" -> \
"91ca2436-005e-4694-affc-04a57fee2db4"],
Cell[38891, 1149, 439, 9, 32, "Input", "ExpressionUUID" -> \
"f318fb08-6d57-4493-9c63-1fae44d915ff"]
}, Open  ]],
Cell[CellGroupData[{
Cell[39367, 1163, 89, 0, 64, "Section", "ExpressionUUID" -> \
"41e447d2-d8a4-4f57-9a38-0ba217f22645"],
Cell[39459, 1165, 274, 4, 30, "Text", "ExpressionUUID" -> \
"c2d42973-79bb-4cb2-ab87-a66625abecf1"],
Cell[39736, 1171, 392, 10, 32, "Input", "ExpressionUUID" -> \
"6d05a400-9ef8-45a1-95ca-9f4d2eccf077"],
Cell[40131, 1183, 204, 5, 32, "Input", "ExpressionUUID" -> \
"5b2f7349-1665-4aef-8f88-42e658ba1da5"],
Cell[40338, 1190, 214, 5, 32, "Input", "ExpressionUUID" -> \
"6f7257f4-f662-4c0f-9501-1e48234cfa76"],
Cell[40555, 1197, 211, 5, 32, "Input", "ExpressionUUID" -> \
"64926589-d39d-4f74-bee1-96d7e2b01b43"],
Cell[40769, 1204, 303, 7, 32, "Input", "ExpressionUUID" -> \
"91367d96-f273-4954-ae51-f89d9cfca15a"],
Cell[41075, 1213, 305, 7, 32, "Input", "ExpressionUUID" -> \
"f9636821-837e-452c-a56a-965d039ccd26"],
Cell[41383, 1222, 216, 4, 32, "Input", "ExpressionUUID" -> \
"c385ecc9-6784-4eb4-b1e7-e67dc9eb2fe3"],
Cell[41602, 1228, 370, 10, 32, "Input", "ExpressionUUID" -> \
"b66cad27-a44c-4259-82fc-0db4f0850de3"],
Cell[41975, 1240, 1658, 42, 75, "Input", "ExpressionUUID" -> \
"ed95a541-46d5-48b1-8de0-8e42527e9871"],
Cell[43636, 1284, 388, 12, 32, "Input", "ExpressionUUID" -> \
"4079fa37-1685-443e-a090-cac824b9def3"],
Cell[44027, 1298, 337, 10, 32, "Input", "ExpressionUUID" -> \
"8505bb61-fbca-44ce-8e93-e3222cb0bd79"],
Cell[44367, 1310, 803, 20, 32, "Input", "ExpressionUUID" -> \
"af4596e6-9ca2-4481-a446-19a08f737d8d"]
}, Open  ]],
Cell[CellGroupData[{
Cell[45207, 1335, 110, 0, 64, "Section", "ExpressionUUID" -> \
"8fbb0df6-68e1-4f8a-bfc5-c8516096f041"],
Cell[45320, 1337, 735, 20, 54, "Input", "ExpressionUUID" -> \
"02b6cac7-3b1d-4682-9258-e6131464499b"],
Cell[46058, 1359, 570, 13, 32, "Input", "ExpressionUUID" -> \
"a03928db-c672-4776-bfce-f66639ff19cd"],
Cell[46631, 1374, 1277, 37, 54, "Input", "ExpressionUUID" -> \
"712bc132-b18a-4310-8e3d-83e39425163d"],
Cell[47911, 1413, 569, 13, 32, "Input", "ExpressionUUID" -> \
"87f7c7ed-3c60-4932-9db2-68507b3b34ab"],
Cell[48483, 1428, 1139, 33, 54, "Input", "ExpressionUUID" -> \
"65415cbb-2243-4a59-8804-35049a932385"],
Cell[49625, 1463, 1424, 37, 75, "Input", "ExpressionUUID" -> \
"62080309-7411-431f-a4ed-f777a0264819"]
}, Open  ]],
Cell[CellGroupData[{
Cell[51086, 1505, 111, 0, 64, "Section", "ExpressionUUID" -> \
"2b674b6b-2759-454b-b439-35a9afe8d0f0"],
Cell[51200, 1507, 747, 20, 32, "Input", "ExpressionUUID" -> \
"92d89501-d7be-41d0-9c10-0b3a56340643"],
Cell[51950, 1529, 1123, 29, 54, "Input", "ExpressionUUID" -> \
"d7f657b2-d17a-4595-b316-cb0eafcff63c"],
Cell[53076, 1560, 365, 10, 32, "Input", "ExpressionUUID" -> \
"0c9b76c8-2da4-4afe-91ab-a55aecf7df1f"],
Cell[53444, 1572, 363, 10, 32, "Input", "ExpressionUUID" -> \
"ddb371a9-48a3-4803-b268-3e19e1a7e8ff"],
Cell[53810, 1584, 221, 3, 30, "Text", "ExpressionUUID" -> \
"797ee6e3-93f4-49d5-9218-c488832676cd"],
Cell[54034, 1589, 472, 13, 32, "Input", "ExpressionUUID" -> \
"1e2dce69-932a-4e11-bdea-f96b5501d6ca"],
Cell[54509, 1604, 239, 4, 30, "Text", "ExpressionUUID" -> \
"bf0c3983-5c40-4bb5-8207-184f4bdec318"],
Cell[54751, 1610, 311, 9, 35, "Input", "ExpressionUUID" -> \
"72c48416-ac56-4903-8b1c-ddce0d4ac97a"],
Cell[55065, 1621, 1715, 44, 96, "Input", "ExpressionUUID" -> \
"1a0c8147-ac04-4f5a-9840-ac02ab8147b6"]
}, Open  ]],
Cell[CellGroupData[{
Cell[56817, 1670, 97, 0, 64, "Section", "ExpressionUUID" -> \
"5d58b44f-f503-448b-8410-13796f9f67ee"],
Cell[56917, 1672, 740, 18, 32, "Input", "ExpressionUUID" -> \
"116be407-945d-4f64-932b-7b9576d3be51"],
Cell[57660, 1692, 787, 19, 32, "Input", "ExpressionUUID" -> \
"d96c92e5-e446-40bd-b483-56021f28b7f6"]
}, Open  ]],
Cell[CellGroupData[{
Cell[58484, 1716, 153, 2, 64, "Section", "ExpressionUUID" -> \
"a44d478e-8132-47b2-bedf-e576f26c8646"],
Cell[58640, 1720, 1936, 50, 222, "Input", "ExpressionUUID" -> \
"d73a3857-bd5a-4947-94a7-2c7639ec9e11"],
Cell[60579, 1772, 118, 1, 32, "Input", "ExpressionUUID" -> \
"5d716f38-8493-4b26-a9e7-32c32a0b47ea"],
Cell[60700, 1775, 467, 13, 75, "Input", "ExpressionUUID" -> \
"fc8c5dd0-9de9-4950-b3b4-361601a525c7"],
Cell[61170, 1790, 415, 11, 32, "Input", "ExpressionUUID" -> \
"ee6322b8-42f4-48d1-b480-2b58dbdf4851"],
Cell[61588, 1803, 457, 13, 32, "Input", "ExpressionUUID" -> \
"4a199713-4e66-4478-93e0-5b45f901953f"],
Cell[62048, 1818, 175, 3, 30, "Text", "ExpressionUUID" -> \
"cb9cd468-0d6a-46ef-8545-cd28a6ca3a5d"],
Cell[62226, 1823, 398, 7, 32, "Input", "ExpressionUUID" -> \
"f361cc5b-01b6-41a8-893a-d5d6dc2493e3"],
Cell[62627, 1832, 1401, 38, 96, "Input", "ExpressionUUID" -> \
"5cf9e979-ffc9-42be-bef2-a843a8247069"],
Cell[64031, 1872, 223, 3, 30, "Text", "ExpressionUUID" -> \
"ba0716b7-8f91-4c6e-bea9-43daec667351"],
Cell[64257, 1877, 412, 10, 32, "Input", "ExpressionUUID" -> \
"8930781b-08d6-4e1a-b0d3-31d1f4ea2ce3"],
Cell[64672, 1889, 415, 8, 32, "Input", "ExpressionUUID" -> \
"c8705382-16d3-418c-9bff-ad28682e9b79"],
Cell[65090, 1899, 410, 10, 32, "Input", "ExpressionUUID" -> \
"44ab4bd1-56f7-47e9-a129-00476cc159d6"],
Cell[65503, 1911, 416, 8, 32, "Input", "ExpressionUUID" -> \
"73573994-72b7-4972-99b9-ab2e1c8abb59"],
Cell[65922, 1921, 1385, 38, 96, "Input", "ExpressionUUID" -> \
"a2e76565-883b-4000-83dd-fdac724eeabf"],
Cell[67310, 1961, 1343, 37, 96, "Input", "ExpressionUUID" -> \
"21e5e51c-d0e0-4dfa-871a-3ae17378932e"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature Yw0u7w3WjmaMwCKUa6COpmIn *)
