%% Directories
% Freesurfer
fullmaskdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native\tissues\with_roast\z_other\for_seg_comparisons\resliced_conform_fullmask';
smf_bonedir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native\tissues\with_roast\bone\resliced';
smf_csfdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native\tissues\with_roast\csf\resliced';
smf_gmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native\tissues\with_roast\gm\reslice_gm_cerebellum';
smf_skindir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native\tissues\with_roast\skin\resliced';
smf_wmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native\tissues\with_roast\wm\resliced';

% Roast
rst_bonedir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\roast_sims\native\tissues\bone';
rst_csfdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\roast_sims\native\tissues\csf';
rst_gmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\roast_sims\native\tissues\gm';
rst_skindir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\roast_sims\native\tissues\skin';
rst_wmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\roast_sims\native\tissues\wm';

% read fullmask files which are FoVs
fullmask_smf=dir(fullfile(fullmaskdir,'*.nii'));

% read roast tissue masks
rst_bone=dir(fullfile(rst_bonedir,'*.nii'));
rst_csf=dir(fullfile(rst_csfdir,'*.nii'));
rst_gm=dir(fullfile(rst_gmdir,'*.nii'));
rst_skin=dir(fullfile(rst_skindir,'*.nii'));
rst_wm=dir(fullfile(rst_wmdir,'*.nii'));


% read freesurfer tissue masks
smf_bone=dir(fullfile(smf_bonedir,'*.nii'));
smf_csf=dir(fullfile(smf_csfdir,'*.nii'));
smf_gm=dir(fullfile(smf_gmdir,'*.nii'));
smf_skin=dir(fullfile(smf_skindir,'*.nii'));
smf_wm=dir(fullfile(smf_wmdir,'*.nii'));

% Initialize output variables for output volumes
absvol_rstbone=zeros(18,1);
absvol_rstcsf=zeros(18,1);
absvol_rstgm=zeros(18,1);
absvol_rstskin=zeros(18,1);
absvol_rstwm=zeros(18,1);

absvol_smfbone=zeros(18,1);
absvol_smfcsf=zeros(18,1);
absvol_smfgm=zeros(18,1);
absvol_smfskin=zeros(18,1);
absvol_smfwm=zeros(18,1);

%% Loop through all subjects

for subj=1:length(fullmask_smf)
    
    % spm_vol all
    fullmask_smf_vol=spm_vol(fullfile(fullmask_smf(subj).folder,fullmask_smf(subj).name));
    
    rst_bone_vol=spm_vol(fullfile(rst_bone(subj).folder,rst_bone(subj).name));
    rst_csf_vol=spm_vol(fullfile(rst_csf(subj).folder,rst_csf(subj).name));
    rst_gm_vol=spm_vol(fullfile(rst_gm(subj).folder,rst_gm(subj).name));
    rst_skin_vol=spm_vol(fullfile(rst_skin(subj).folder,rst_skin(subj).name));
    rst_wm_vol=spm_vol(fullfile(rst_wm(subj).folder,rst_wm(subj).name));
    
    smf_bone_vol=spm_vol(fullfile(smf_bone(subj).folder,smf_bone(subj).name));
    smf_csf_vol=spm_vol(fullfile(smf_csf(subj).folder,smf_csf(subj).name));
    smf_gm_vol=spm_vol(fullfile(smf_gm(subj).folder,smf_gm(subj).name));
    smf_skin_vol=spm_vol(fullfile(smf_skin(subj).folder,smf_skin(subj).name));
    smf_wm_vol=spm_vol(fullfile(smf_wm(subj).folder,smf_wm(subj).name));
     
    % spm_read_vols all
    fullmask_smf_img=spm_read_vols(fullmask_smf_vol);
    rst_bone_img=spm_read_vols(rst_bone_vol);
    rst_csf_img=spm_read_vols(rst_csf_vol);
    rst_gm_img=spm_read_vols(rst_gm_vol);
    rst_skin_img=spm_read_vols(rst_skin_vol);
    rst_wm_img=spm_read_vols(rst_wm_vol);
    
    smf_bone_img=spm_read_vols(smf_bone_vol);
    absvol_smfbone(subj,1)=sum(smf_bone_img(:)>0);
    
    smf_csf_img=spm_read_vols(smf_csf_vol);
    absvol_smfcsf(subj,1)=sum(smf_csf_img(:)>0);

    smf_gm_img=spm_read_vols(smf_gm_vol);
    absvol_smfgm(subj,1)=sum(smf_gm_img(:)>0);

    smf_skin_img=spm_read_vols(smf_skin_vol);
    absvol_smfskin(subj,1)=sum(smf_skin_img(:)>0);

    smf_wm_img=spm_read_vols(smf_wm_vol);
    absvol_smfwm(subj,1)=sum(smf_wm_img(:)>0);

    
    all_vals=[fullmask_smf_img(:),rst_bone_img(:),rst_csf_img(:),rst_gm_img(:),rst_skin_img(:)...
        rst_wm_img(:)];
    
    count_bone=zeros(length(all_vals),1);
    count_csf=zeros(length(all_vals),1);
    count_gm=zeros(length(all_vals),1);
    count_skin=zeros(length(all_vals),1);
    count_wm=zeros(length(all_vals),1);

    for i=1:length(all_vals(:,1))
        if all_vals(i,1)==1 && all_vals(i,2)==1
            count_bone(i,1)=1;
        else
            count_bone(i,1)=0;
        end
    end
    
    for i=1:length(all_vals(:,1))
        if all_vals(i,1)==1 && all_vals(i,3)==1
            count_csf(i,1)=1;
        else
            count_csf(i,1)=0;
        end
    end
    for i=1:length(all_vals(:,1))
        if all_vals(i,1)==1 && all_vals(i,4)==1
            count_gm(i,1)=1;
        else
            count_gm(i,1)=0;
        end
    end
    for i=1:length(all_vals(:,1))
        if all_vals(i,1)==1 && all_vals(i,5)==1
            count_skin(i,1)=1;
        else
            count_skin(i,1)=0;
        end
    end
    for i=1:length(all_vals(:,1))
        if all_vals(i,1)==1 && all_vals(i,6)==1
            count_wm(i,1)=1;
        else
            count_wm(i,1)=0;
        end
    end
    absvol_rstbone(subj,1)=sum(count_bone(:,1));
    absvol_rstcsf(subj,1)=sum(count_csf(:,1));
    absvol_rstgm(subj,1)=sum(count_gm(:,1));
    absvol_rstskin(subj,1)=sum(count_skin(:,1));
    absvol_rstwm(subj,1)=sum(count_wm(:,1));
end

%% Collate results into table
all_absvol_rst=[absvol_rstbone,absvol_rstcsf,absvol_rstgm,absvol_rstskin,absvol_rstwm];
T=array2table(all_absvol_rst);
load('Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\names.mat');
T.Properties.VariableNames={'absvol_bone','absvol_csf','absvol_gm','absvol_skin','absvol_wm'};
T2=addvars(T,names,'Before',1);
writetable(T2,'roast_absvols_compare_with_smf.xlsx');

all_absvol_smf=[absvol_smfbone,absvol_smfcsf,absvol_smfgm,absvol_smfskin,absvol_smfwm];
T1=array2table(all_absvol_smf);
T1.Properties.VariableNames={'absvol_bone','absvol_csf','absvol_gm','absvol_skin','absvol_wm'};
T3=addvars(T1,names,'Before',1);
writetable(T3,'smf_absvols_compare_with_roast.xlsx');




