mydir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native';
a1=dir(fullfile(mydir,'bone','*.nii'));
a2=dir(fullfile(mydir,'csf','*.nii'));
a3=dir(fullfile(mydir,'gm','*.nii'));
a4=dir(fullfile(mydir,'skin','*.nii'));
a5=dir(fullfile(mydir,'wm','*.nii'));
a6=dir(fullfile(mydir,'T1fs_conform','*.nii'));
for files=1:length(a1)
    bone=spm_vol(fullfile(a1(files).folder,a1(files).name));
    [~,name,~]=fileparts(bone.fname);
    filename=strsplit(name,'_');
    filename1=filename{1};
    csf=spm_vol(fullfile(a2(files).folder,a2(files).name));
    gm=spm_vol(fullfile(a3(files).folder,a3(files).name));
    skin=spm_vol(fullfile(a4(files).folder,a4(files).name));
    wm=spm_vol(fullfile(a5(files).folder,a5(files).name)); 
    b1=spm_read_vols(bone);
    b2=spm_read_vols(csf);
    b3=spm_read_vols(gm);
    b4=spm_read_vols(skin);
    b5=spm_read_vols(wm);
    maskfile=b1+b2+b3+b4+b5;
    hdrfile=spm_vol(fullfile(a6(files).folder,a6(files).name));
    msk=hdrfile;
    msk.fname=sprintf('%s_fullmask.nii',filename1);
    spm_write_vol(msk,maskfile);
end