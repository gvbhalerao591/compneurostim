% Pipeline: abq, rst, smc_simnibs, smf_simnibs, spm_simnibs
% main dir: parent dir
% masks_dir: wfu masks dir
% piepline: pipeline name (must match with folder name)
% matfilename: matfile containing names of subjects
% n=no. of subjects
function T2=gm_wm_mean_efs(main_dir,gm_masks_dir,wm_masks_dir,pipeline,matfilename,n)
% total subjects
    subjects=n;
    tissue='brain';
    % pipeline directories
    parent_dir=fullfile(main_dir,pipeline);
    %abq_efs=dir(fullfile(parent_dir,tissue,'*.nii'));
    abq_efs=dir(fullfile(parent_dir,'normalized',tissue,'*.nii'));
    % mask directory and load masks
    gm_tissue_masks=dir(fullfile(gm_masks_dir,'*.nii'));
    wm_tissue_masks=dir(fullfile(wm_masks_dir,'*.nii'));

    abq_gm_mean=zeros(subjects,1);
    abq_wm_mean=zeros(subjects,1);

    for subj=1:length(abq_efs)
            abq_gm_mean(subj,1)=spm_summarise(spm_vol(fullfile(abq_efs(subj).folder,abq_efs(subj).name)),fullfile(gm_tissue_masks(subj).folder,gm_tissue_masks(subj).name),@mean);
            abq_wm_mean(subj,1)=spm_summarise(spm_vol(fullfile(abq_efs(subj).folder,abq_efs(subj).name)),fullfile(wm_tissue_masks(subj).folder,wm_tissue_masks(subj).name),@mean);
    end
    load(matfilename);
    gm_wm_means=[abq_gm_mean,abq_wm_mean];
    T2=array2table(gm_wm_means);
    T2.Properties.VariableNames={'GMtissue_mean','WMtissue_mean'};
    T22=addvars(T2,names,'Before',1);
    writetable(T22,sprintf('%s_%s_GMWMpercdiff_GlobalTissuemeaures.xlsx',pipeline,tissue));
end

