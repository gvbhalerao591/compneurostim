%% Directories
% Freesurfer
fullmaskdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\compare_segs_with_smcspm\fullmask\resliced_fullmask_smcspm';
smf_bonedir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\bone\resliced_bone_for_smcspm';
smf_csfdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\csf\resliced_csf_for_smcspm';
smf_gmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\gm\gm_with_cerebllum_for_roast\resliced_gm_cerebellum_for_smcspm';
smf_skindir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\skin\resliced_skin_for_smcspm';
smf_wmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\Again\native\wm\resliced_wm_for_smcspm';

% Spms
spms_bonedir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\tissues\bone';
spms_csfdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\tissues\csf';
spms_gmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\tissues\gm';
spms_skindir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\tissues\skin';
spms_wmdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\native\tissues\wm';

% read fullmask files which are FoVs
fullmask_smf=dir(fullfile(fullmaskdir,'*.nii'));

% read spm tissue masks
spms_bone=dir(fullfile(spms_bonedir,'*.nii'));
spms_csf=dir(fullfile(spms_csfdir,'*.nii'));
spms_gm=dir(fullfile(spms_gmdir,'*.nii'));
spms_skin=dir(fullfile(spms_skindir,'*.nii'));
spms_wm=dir(fullfile(spms_wmdir,'*.nii'));


% read freesurfer tissue masks
smf_bone=dir(fullfile(smf_bonedir,'*.nii'));
smf_csf=dir(fullfile(smf_csfdir,'*.nii'));
smf_gm=dir(fullfile(smf_gmdir,'*.nii'));
smf_skin=dir(fullfile(smf_skindir,'*.nii'));
smf_wm=dir(fullfile(smf_wmdir,'*.nii'));

% Initialize output variables for output volumes
absvol_spmsbone=zeros(18,1);
absvol_spmscsf=zeros(18,1);
absvol_spmsgm=zeros(18,1);
absvol_spmsskin=zeros(18,1);
absvol_spmswm=zeros(18,1);

absvol_smfbone=zeros(18,1);
absvol_smfcsf=zeros(18,1);
absvol_smfgm=zeros(18,1);
absvol_smfskin=zeros(18,1);
absvol_smfwm=zeros(18,1);

%% Loop through all subjects

for subj=1:length(fullmask_smf)
    
    % spm_vol all
    fullmask_smf_vol=spm_vol(fullfile(fullmask_smf(subj).folder,fullmask_smf(subj).name));
    
    spms_bone_vol=spm_vol(fullfile(spms_bone(subj).folder,spms_bone(subj).name));
    spms_csf_vol=spm_vol(fullfile(spms_csf(subj).folder,spms_csf(subj).name));
    spms_gm_vol=spm_vol(fullfile(spms_gm(subj).folder,spms_gm(subj).name));
    spms_skin_vol=spm_vol(fullfile(spms_skin(subj).folder,spms_skin(subj).name));
    spms_wm_vol=spm_vol(fullfile(spms_wm(subj).folder,spms_wm(subj).name));
    
    smf_bone_vol=spm_vol(fullfile(smf_bone(subj).folder,smf_bone(subj).name));
    smf_csf_vol=spm_vol(fullfile(smf_csf(subj).folder,smf_csf(subj).name));
    smf_gm_vol=spm_vol(fullfile(smf_gm(subj).folder,smf_gm(subj).name));
    smf_skin_vol=spm_vol(fullfile(smf_skin(subj).folder,smf_skin(subj).name));
    smf_wm_vol=spm_vol(fullfile(smf_wm(subj).folder,smf_wm(subj).name));
     
    % spm_read_vols all
    fullmask_smf_img=spm_read_vols(fullmask_smf_vol);
    spms_bone_img=spm_read_vols(spms_bone_vol);
    spms_csf_img=spm_read_vols(spms_csf_vol);
    spms_gm_img=spm_read_vols(spms_gm_vol);
    spms_skin_img=spm_read_vols(spms_skin_vol);
    spms_wm_img=spm_read_vols(spms_wm_vol);
    
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

    
    all_vals=[fullmask_smf_img(:),spms_bone_img(:),spms_csf_img(:),spms_gm_img(:),spms_skin_img(:)...
        spms_wm_img(:)];
    
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
    absvol_spmsbone(subj,1)=sum(count_bone(:,1));
    absvol_spmscsf(subj,1)=sum(count_csf(:,1));
    absvol_spmsgm(subj,1)=sum(count_gm(:,1));
    absvol_spmsskin(subj,1)=sum(count_skin(:,1));
    absvol_spmswm(subj,1)=sum(count_wm(:,1));
end

%% Collate results into table
all_absvol_spms=[absvol_spmsbone,absvol_spmscsf,absvol_spmsgm,absvol_spmsskin,absvol_spmswm];
T=array2table(all_absvol_spms);
load('Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\names.mat');
T.Properties.VariableNames={'absvol_bone','absvol_csf','absvol_gm','absvol_skin','absvol_wm'};
T2=addvars(T,names,'Before',1);
writetable(T2,'spm_absvols_compare_with_smf.xlsx');

all_absvol_smf=[absvol_smfbone,absvol_smfcsf,absvol_smfgm,absvol_smfskin,absvol_smfwm];
T1=array2table(all_absvol_smf);
T1.Properties.VariableNames={'absvol_bone','absvol_csf','absvol_gm','absvol_skin','absvol_wm'};
T3=addvars(T1,names,'Before',1);
writetable(T3,'smf_absvols_compare_with_spms_smc.xlsx');




