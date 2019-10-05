# compneurostim
These are the scripts developed in MATLAB for end-to-end processing of computational neuromodeling using Abaqus-ScanIP pipeline
Use segmentation masks from SPM12 and create a head mesh in ScanIP.
Export the head model to abaqus and prepare it to be simulated for bipolar electrode configuration using prepareForAbaqus and prepare_forAbaqus2 
Run the simulation in abaqus and export rpt files containing coords and electric fields
Use interpolate_abaqus_field_part1 amd part2 for creating voxel wise mapping of electric field
The other functions required within the above mentioned scripts are also provided.
Several other MATLAB functions to compare segmentation from different simulation pipelines.
Also functions are provided to post-process the electric field output from these pipelines.

