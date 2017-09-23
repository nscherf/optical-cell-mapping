module CellAnalyzerOld
using ImageView
using Images
using ColorTypes
using FixedPointNumbers
using HDF5

export myImgConvert, myDoG, myNormalize, myInvert, myShow, myNaiveMaxDetect, myMaxProject, myMeanImageFromFiles, mySegmentation, mySizeFilter, processFrame, extractMeanSignal, exportSignal, extractSignal, myStack2HDF5


function myImgConvert(img::Images.Image{ColorTypes.Gray{FixedPointNumbers.UfixedBase{UInt16,16}},3,Array{ColorTypes.Gray{FixedPointNumbers.UfixedBase{UInt16,16}},3}})

    nx, ny, nz = size(img)
    dat = data(img)
    mydat = zeros(Float64, (nx,ny,nz))
    for x in 1:nx
        for y in 1:ny
            for z in 1:nz
                mydat[x,y,z] = Float64(dat[x,y,z])
            end
        end
    end
    mydat
end

function myLabelConvert(img::Images.Image{ColorTypes.Gray{FixedPointNumbers.UfixedBase{UInt16,16}},3,Array{ColorTypes.Gray{FixedPointNumbers.UfixedBase{UInt16,16}},3}})

    nx, ny, nz = size(img)
    dat = raw(img)
    mydat = zeros(Float64, (nx,ny,nz))
    for x in 1:nx
        for y in 1:ny
            for z in 1:nz
                mydat[x,y,z] = Float64(dat[x,y,z])
            end
        end
    end
    mydat
end


function myDoG(img::Array{Float64,3};dx=0.46, dy=0.46, dz = 1., rmin = 5,rmax = 10)
    println("compute scale-normalized DoG")
    scaling = dx / dz
    large = imfilter_gaussian(img, [rmax, rmax, rmax * scaling])
    small = imfilter_gaussian(img, [rmin, rmin, rmin * scaling])

    (rmin/(rmax-rmin))*(large - small)
end

function myNormalize(img::Array{Float64,3})
    minval = minimum(img)
    maxval = maximum(img)
    valrange = maxval - minval
    map(x-> (x-minval)/valrange, img)
end

function myInvert(img::Array{Float64,3})
    map(x->1-x, img)
end


function myShow(img::Array{Float64,3})
    view(grayim(img))
end

function myNaiveMaxDetect(img::Array{Float64,3})
    nx,ny,nz = size(img)
    maximg = Array(Float64, size(img))

    for x in 2:nx-1
        for y in 2:ny-1
            for z in 2:nz-1
                if img[x,y,z] >= maximum(
                                        [img[x+1,y,z],img[x-1,y,z],
                                         img[x,y+1,z],img[x,y-1,z],
                                         img[x+1,y+1,z],img[x+1,y-1,z],img[x-1,y-1,z],img[x-1,y+1,z],
                                         img[x,y,z+1],img[x+1,y,z+1],img[x-1,y,z+1],
                                         img[x,y+1,z+1],img[x,y-1,z+1],
                                         img[x+1,y+1,z+1],img[x+1,y-1,z+1],img[x-1,y-1,z+1],img[x-1,y+1,z+1],
                                         img[x,y,z-1],img[x+1,y,z-1],img[x-1,y,z-1],
                                         img[x,y+1,z-1],img[x,y-1,z-1],
                                         img[x+1,y+1,z-1],img[x+1,y-1,z-1],img[x-1,y-1,z-1],img[x-1,y+1,z-1],
                                         ])
                    maximg[x,y,z] = 1.
                else
                    maximg[x,y,z] = 0.
                end
            end
        end
    end
    maximg
end

function myBinarize(img::Array{Float64,3}, t::Float64)
    map(x-> x < t ? 0. : 1., img)
end


function myBlobDetect(img::Array{Float64,3},mask::Array{Float64,3})

    nx, ny, nz = size(img)
    maximg = Array(Float64, size(img))

    pixlist = Array(Float64, (Int64(sum(mask[2:nx-1,2:ny-1,2:nz-1])),4))

    i = 1

    for x in 2:nx-1
        for y in 2:ny-1
            for z in 2:nz-1
                if mask[x,y,z] == 1.
                    pixlist[i,:] = [x,y,z,img[x,y,z]]
                    i = i + 1
                end

            end
        end
    end

    pixlist = sortrows(pixlist, by = x->(x[4]), rev = true)
    maxlabel = 0

    for k in 1:size(pixlist,1)
        x,y,z = Int64(pixlist[k,1]),Int64(pixlist[k,2]),Int64(pixlist[k,3])
        println((x,y,z))
        val = pixlist[k,4]
        localmaxlabel = -1

        for xx in -1:1
            for yy in -1:1
                for zz in -1:1
                    if xx == yy == zz == 0
                        continue
                    else
                        if img[x+xx,y+yy,z+zz] < val
                            continue
                        elseif img[x+xx,y+yy,z+zz] > val && localmaxlabel == -1
                            localmaxlabel = maximg[x+xx,y+yy,z+zz]
                        elseif img[x+xx, y+yy, z+zz] > val && maximg[x+xx, y+yy, z+zz] == 0
                            localmaxlabel = 0
                            break
                        elseif img[x+xx,y+yy,z+zz] > val && localmaxlabel >0 && localmaxlabel == maximg[x+xx,y+yy,z+zz]
                            continue
                        elseif img[x+xx,y+yy,z+zz] > val && localmaxlabel >0 && localmaxlabel != maximg[x+xx,y+yy,z+zz]
                            localmaxlabel = 0
                            break
                        elseif img[x+xx,y+yy,z+zz] == val
                            localmaxlabel = -2
                        end
                    end
                end
            end
        end

        if localmaxlabel == -1
            maximg[x,y,z] = maxlabel + 1
            maxlabel = maxlabel + 1
        elseif localmaxlabel == -2
            maximg[x,y,z] = 0
        else
            maximg[x,y,z] = localmaxlabel
        end
    end
    maximg
end


function myStackExport(img::Array{Float64,3},dir::AbstractString)

    nx, ny, nz = size(img)

    for z in 1:nz
        ImageView.imwrite(ImageView.grayim(convert(Array{UInt16,2},img[:,:,z])),string(dir,lpad(string(z),4,"0"),".tif"))
    end
end

function myStack2HDF5(img::Array{Float64,3},fname::AbstractString)
    fid = HDF5.h5open(fname, "w")
    write(fid, "img", convert(Array{UInt16,3},img))
    close(fid)
end




function myMaxProject(img::Array{Float64,3})
    nx,ny,nz = size(img)
    mmax = zeros(Float64,(nx,ny))
    for x in 1:nx
        for y in 1:ny
            mmax[x,y] = maximum(img[x,y,:])
        end
    end
    mmax
end

function myMeanImageFromFiles(fileNames::Array{ASCIIString,1})
    img0 = ImageView.imread(fileNames[1]);
    img0dat = myImgConvert(img0);
    nx,ny,nz = size(img0dat);
    meanimg = img0dat * 1/length(fileNames)

    for f in fileNames[2,:]
            img = ImageView.imread(f);
            imgdat = myImgConvert(img);
            meanimg = meanimg + imgdat * 1/length(fileNames)
    end
    meanimg
 end


function myImagePreprocess(dir)
    #fnames = map(x->string(dir, x), readdir(dir)[2:end])
    fnames = map(x->string(dir,x), filter(x->contains(x,".tif"), readdir(dir)));
    println(fnames)
    mimg = myMeanImageFromFiles(fnames);
    nimg = myNormalize(mimg);
    bg = Images.imfilter_gaussian(nimg, [50,50,20])
    fg = Images.imfilter_gaussian(nimg, [2, 2, 1])
    img = fg - bg;
    myNormalize(img)
end

function mySegmentation(dir::AbstractString; t = 0.2)
    img = myImagePreprocess(dir)
    dog = myNormalize(myInvert(myDoG(img)))
    bin = myBinarize(dog, t)
    res = myBlobDetect(dog, bin)
end

function mySizeFilter(limg::Array{Float64,3}; minSize = 100, maxSize = 50000)
    #labels = unqiue(limg)
    sizes  = Dict{Float64,Int64}()
    #nx, ny, nz = size(limg)
    for lab in limg
        sizes[lab] = get(sizes, lab, 0) + 1
    end
    sizes

    map(x -> sizes[x] > minSize && sizes[x] < maxSize ? x : 0., limg)
end

function extractMeanSignal(img::Array{Float64,3}, label::Array{Float64,3})

    signal = Dict{Float64,Float64}()
    nlab = Dict{Float64,Int64}()

    nx,ny,nz = size(img)

    for x in 1:nx
        for y in 1:ny
            for z in 1:nz
                if label[x,y,z] == 0.
                    continue
                else
                    signal[label[x,y,z]] = get(signal, label[x,y,z], 0) + img[x,y,z]
                    nlab[label[x,y,z]] = get(nlab, label[x,y,z],0) + 1
                end
            end
        end
    end

    for k in keys(signal)
        signal[k] = signal[k] / nlab[k]
    end

    signal
end

function processFrame(fname::AbstractString, label::Array{Float64,3})
    sig = Images.imread(fname);
    sig = myImgConvert(sig);
    res = extractMeanSignal(sig, label);
end

function extractSignals(dir::AbstractString, label::Array{Float64,3})

    fnames = filter(x->contains(x,".tif"), readdir(dir));

    signalDict = [id => zeros(length(fnames),1) for id in unique(label)]

    for (t, f) in enumerate(fnames)
        print(string(t), " ")
        signalsAtT = processFrame(string(dir,f), label)
        for lab in keys(signalsAtT)
            signalDict[lab][t] = signalsAtT[lab]
        end

    end

    signalDict
end

function exportSignal(fname::AbstractString, signalDict::Dict)
    fid = h5open(fname, "w")
    for id in keys(signalDict)
        if id == 0.0
            continue
        else
            write(fid, string("l_",Int64(id)), signalDict[id][:])
        end
    end

    close(fid)
end

end
