# Single Cell Optical Mapping of Cardiac Activation

This repository contains the scripts to compute the data analysis presented in *Cell-accurate optical mapping across the entire developing heart*.

## Structure of the repository

- **data/** contains the unprocessed (but synchronised) images
- **results/** holds everything that has been computed from the raw image data. It contains the following data for an experiment:
	- **extracted-midline/**: the extracted midline as a polyline stored as a Mathematica list in a Wolfram *.m* file.
	- **myl7-H2A-labels/**: the labeled cells from the blob detection (see *src/cell-detection-and-signal-extraction.jl*).
	- **myl7-H2A-processed-labels/**: the labelling computed from manually corrected cell centroids. 
	- **myl7-GCaMP5G-from-processed-labels/**: the extracted GCaMP signal readout at each detected cell position.
	- **standard-view-transforms/**: the geometric transformation needed to project the cell positions from the microscopy reference frame to a standard view.
- **src/** contains the actual function definitions and notebooks (in Julia and Mathematica). 
	- *analyse-conduction-pattern.nb*: This Mathematica notebook was used to analyse the cellular activation patterns.
	- *analyse-conduction-pattern.cdf*: A computable document format version that can be used without a Mathematica license using the [Wolfram CDF Player](https://www.wolfram.com/cdf-player/)
	- *cell-detection-and-signal-extraction.jl*: An experimental Julia implementation of the grayscale blob detection. This file also contains the functions needed to extract the GCaMP signal from the detected cell regions.
	- 