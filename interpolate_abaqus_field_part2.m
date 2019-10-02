clc
dirname='E:\Gaurav\tDCS_data_for_scanIP\Abaqus_work_tDCS\00_interplote_efield';
cd(dirname)
%%
subj=dir('*');
for subjs=3:length(subj)
    subjdir=fullfile(subj(subjs).folder,subj(subjs).name);
    P1=load_untouch_nii(fullfile(subjdir,[subj(subjs).name,'.nii']));
    load(fullfile(subjdir,'all_epg.mat'));
    EPGdata=epg_all;
    [xi,yi,zi] = ndgrid(1:192,1:256,1:256);
    ef_all = zeros([192 256 256 3]);
    F = scatteredInterpolant(EPGdata(:,2:4), EPGdata(:,5));
    ef_all(:,:,:,1) = F(xi,yi,zi);
    F = scatteredInterpolant(EPGdata(:,2:4), EPGdata(:,6));
    ef_all(:,:,:,2) = F(xi,yi,zi);
    F = scatteredInterpolant(EPGdata(:,2:4), EPGdata(:,7));
    ef_all(:,:,:,3) = F(xi,yi,zi);
    ef_mag = sqrt(sum(ef_all.^2,4));
    img=spm_vol(fullfile(subjdir,[subj(subjs).name,'_T1orT2_masks_allmask.nii']));
    img1=spm_read_vols(img);
    ef_mag1=ef_mag.*img1; 
    template = load_untouch_nii(fullfile(subjdir,[subj(subjs).name,'_T1orT2_masks.nii']));
    template.hdr.dime.datatype = 16;
    template.hdr.dime.bitpix = 32;
    template.hdr.dime.scl_slope = 1; % so that display of NIFTI will not alter the data
    template.hdr.dime.cal_max = 0;
    template.hdr.dime.cal_min = 0;
    template.img = single(ef_mag1);
    template.hdr.dime.glmax = max(ef_mag1(:));
    template.hdr.dime.glmin = min(ef_mag1(:));
    template.hdr.hist.descrip = 'EF mag';
    save_untouch_nii(template,fullfile(subjdir,[subj(subjs).name,'_interpolatedEfield.nii']));
end