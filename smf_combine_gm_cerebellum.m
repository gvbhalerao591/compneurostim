gm_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\gm';
cerebellum_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\compare_segs_with_roast\cerebellum_for_gm';

gm_images=dir(fullfile(gm_dir,'*.nii'));
cerebellum_images=dir(fullfile(cerebellum_dir,'*.nii'));

for i=1:length(cerebellum_images)
    gm_vol=spm_vol(fullfile(gm_images(i).folder,gm_images(i).name));
    cerebellum_vol=spm_vol(fullfile(cerebellum_images(i).folder,cerebellum_images(i).name));
    gm_img=spm_read_vols(gm_vol);
    cerebellum_img=spm_read_vols(cerebellum_vol);
    combined_gm_cerebellum=gm_img+cerebellum_img;
    newimg=gm_vol;
    newname=strsplit(gm_images(i).name,'_');
    newname=[newname{1},'_gm_cerebellum','.nii'];
    newimg.fname=newname;
    spm_write_vol(newimg,combined_gm_cerebellum);
end
    
