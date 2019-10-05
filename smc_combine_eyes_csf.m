eyes_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\masks\eyes';
csf_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\masks\csf';

eye_images=dir(fullfile(eyes_dir,'*.nii'));
csf_images=dir(fullfile(csf_dir,'*.nii'));

for i=1:length(csf_images)
    eye_vol=spm_vol(fullfile(eye_images(i).folder,eye_images(i).name));
    csf_vol=spm_vol(fullfile(csf_images(i).folder,csf_images(i).name));
    eye_img=spm_read_vols(eye_vol);
    csf_img=spm_read_vols(csf_vol);
    combined_eye_csf=eye_img+csf_img;
    newimg=eye_vol;
    newname=strsplit(eye_images(i).name,'_');
    newname=[newname{1},'_eyes_csf','.nii'];
    newimg.fname=newname;
    spm_write_vol(newimg,combined_eye_csf);
end
    
