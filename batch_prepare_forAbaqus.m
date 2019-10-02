% Use this batch script to create rnge_elec and rnge_gel mat files for
% multiple subjects at the same time
function batch_prepare_forAbaqus(indir)
cd(indir)
a=dir('*');
%cd(roastdir);
for i=3:length(a)
    Image=fullfile(a(i).folder,a(i).name,[a(i).name,'_T1orT2_masks.nii']);
    elecgellabelsMat=fullfile(a(i).folder,a(i).name,[a(i).name, '_T1orT2_ElecGelLabels.mat']);
    optMat_name=dir(fullfile(a(i).folder,a(i).name,'*_options.mat'));
    optMat=fullfile(a(i).folder,a(i).name,optMat_name(1).name);
    prepareForAbaqus(Image,elecgellabelsMat,optMat);
end
end