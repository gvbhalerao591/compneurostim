tissues=dir(fullfile(pwd,'*'));
bone_dir=dir(fullfile(tissues(3).folder,tissues(3).name,'*.nii'));
% for smc and spms
csf_dir=dir(fullfile(tissues(4).folder,tissues(4).name,'old','*.nii'));

% for roast
%csf_dir=dir(fullfile(tissues(4).folder,tissues(4).name,'*.nii'));

gm_dir=dir(fullfile(tissues(5).folder,tissues(5).name,'*.nii'));
skin_dir=dir(fullfile(tissues(6).folder,tissues(6).name,'*.nii'));
wm_dir=dir(fullfile(tissues(7).folder,tissues(7).name,'*.nii'));
count_bone=zeros(length(bone_dir),1);
count_csf=zeros(length(csf_dir),1);
count_gm=zeros(length(gm_dir),1);
count_skin=zeros(length(skin_dir),1);
count_wm=zeros(length(wm_dir),1);

for subs=1:length(bone_dir)
    bone_vol=spm_vol(fullfile(bone_dir(subs).folder,bone_dir(subs).name));
    bone_img=spm_read_vols(bone_vol);
    count_bone(subs,1)=sum(bone_img(:)>0);
end
for subs=1:length(csf_dir)
    csf_vol=spm_vol(fullfile(csf_dir(subs).folder,csf_dir(subs).name));
    csf_img=spm_read_vols(csf_vol);
    count_csf(subs,1)=sum(csf_img(:)>0);
end    
for subs=1:length(gm_dir)
    gm_vol=spm_vol(fullfile(gm_dir(subs).folder,gm_dir(subs).name));
    gm_img=spm_read_vols(gm_vol);
    count_gm(subs,1)=sum(gm_img(:)>0);
end    
for subs=1:length(skin_dir)
    skin_vol=spm_vol(fullfile(skin_dir(subs).folder,skin_dir(subs).name));
    skin_img=spm_read_vols(skin_vol);
    count_skin(subs,1)=sum(skin_img(:)>0);
end    
for subs=1:length(wm_dir)
    wm_vol=spm_vol(fullfile(wm_dir(subs).folder,wm_dir(subs).name));
    wm_img=spm_read_vols(wm_vol);
    count_wm(subs,1)=sum(wm_img(:)>0);
end    
all_absvol=[count_bone,count_csf,count_gm,count_skin,count_wm];
T=array2table(all_absvol);
%load('Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\names.mat')
%for HC 18
load('Z:\Comp_neurostim_work_GVB\HC_agematched_analysis\All_masks_seg_comparison\native_tissue_masks\names.mat')
T.Properties.VariableNames={'bone','csf','gm','skin','wm'};
T2=addvars(T,names,'Before',1);
writetable(T2,sprintf('%s_absvol.xlsx','spm_with_smc_roast'));

