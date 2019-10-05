% total subjects
subjects=18;
tissue='brain';
% % % % pipeline directories for age matched
% % % abq_dir='Z:\age_matched_sim\00_explore\TissueSpecific_efields\abq';
% % % rst_dir='Z:\age_matched_sim\00_explore\TissueSpecific_efields\rst';
% % % smc_dir='Z:\age_matched_sim\00_explore\TissueSpecific_efields\smc_simnibs';
% % % smf_dir='Z:\age_matched_sim\00_explore\TissueSpecific_efields\smf_simnibs';
% % % spms_dir='Z:\age_matched_sim\00_explore\TissueSpecific_efields\spm_simnibs';

% pipeline directories for HC 18
abq_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\abq_sims\normalised';
rst_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\roast_sims\normalised';
smc_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\cat_sims\normalised';
smf_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\freesurfer_sims\native_for_normalisation\normalised';
spms_dir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\spms_sims\normalised';

% tissue files
abq_tissue=dir(fullfile(abq_dir,tissue,'*.nii'));
rst_tissue=dir(fullfile(rst_dir,tissue,'*.nii'));
smc_tissue=dir(fullfile(smc_dir,tissue,'*.nii'));
smf_tissue=dir(fullfile(smf_dir,tissue,'*.nii'));
spms_tissue=dir(fullfile(spms_dir,tissue,'*.nii'));


% initialize outputs: absolute difference
count_abq_rst_absdiff=zeros(subjects,1);
count_abq_rst_perdiff=zeros(subjects,1);
count_abq_smc_absdiff=zeros(subjects,1);
count_abq_smc_perdiff=zeros(subjects,1);
count_abq_smf_absdiff=zeros(subjects,1);
count_abq_smf_perdiff=zeros(subjects,1);
count_abq_spms_absdiff=zeros(subjects,1);
count_abq_spms_perdiff=zeros(subjects,1);
count_rst_spms_absdiff=zeros(subjects,1);
count_rst_spms_perdiff=zeros(subjects,1);
count_rst_smc_absdiff=zeros(subjects,1);
count_rst_smc_perdiff=zeros(subjects,1);
count_rst_smf_absdiff=zeros(subjects,1);
count_rst_smf_perdiff=zeros(subjects,1);
count_smc_smf_absdiff=zeros(subjects,1);
count_smc_smf_perdiff=zeros(subjects,1);
count_smc_spms_absdiff=zeros(subjects,1);
count_smc_spms_perdiff=zeros(subjects,1);
count_spms_smf_absdiff=zeros(subjects,1);
count_spms_smf_perdiff=zeros(subjects,1);


for t=1:subjects
    % read tissue vols
    abq_vol=spm_vol(fullfile(abq_tissue(t).folder,abq_tissue(t).name));
    rst_vol=spm_vol(fullfile(rst_tissue(t).folder,rst_tissue(t).name));
    smc_vol=spm_vol(fullfile(smc_tissue(t).folder,smc_tissue(t).name));
    smf_vol=spm_vol(fullfile(smf_tissue(t).folder,smf_tissue(t).name));
    spms_vol=spm_vol(fullfile(spms_tissue(t).folder,spms_tissue(t).name));
    
    % read tissue images
    abq_img=spm_read_vols(abq_vol);
    rst_img=spm_read_vols(rst_vol);
    smc_img=spm_read_vols(smc_vol);
    smf_img=spm_read_vols(smf_vol);
    spms_img=spm_read_vols(spms_vol);
  
    
    msk_size=length(abq_img(:));
    
    % compare fields: absolute difference, for that concatenate the masks
    % and fields
    
    % abq-rst
    abq_rst_ef=[abq_img(:),rst_img(:)]; % abq rst fields
    abq_rst_absdiff=zeros(msk_size,1); % absolute difference
    abq_rst_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size
            abq_rst_absdiff(i,1)=abs(abq_rst_ef(i,1)-abq_rst_ef(i,2));            
            abq_rst_perdiff(i,1)=(abs(abq_rst_ef(i,1)-abq_rst_ef(i,2))/abs(max(abq_rst_ef(i,1),abq_rst_ef(i,2))))*100;   
    end
    count_abq_rst_absdiff(t,1)=(sum(abq_rst_absdiff(isfinite(abq_rst_absdiff))))/(length(abq_rst_absdiff));
    count_abq_rst_perdiff(t,1)=(sum(abq_rst_perdiff(isfinite(abq_rst_perdiff))))/(length(abq_rst_perdiff));
    
    % abq-smc
    abq_smc_ef=[abq_img(:),smc_img(:)]; % abq smc fields
    abq_smc_absdiff=zeros(msk_size,1); % absolute difference
    abq_smc_perdiff=zeros(msk_size,1); % percentage difference
    
   for i=1:msk_size       
            abq_smc_absdiff(i,1)=abs(abq_smc_ef(i,1)-abq_smc_ef(i,2));
            abq_smc_perdiff(i,1)=(abs(abq_smc_ef(i,1)-abq_smc_ef(i,2))/abs(max(abq_smc_ef(i,1),abq_smc_ef(i,2))))*100;            
   end
    count_abq_smc_absdiff(t,1)=(sum(abq_smc_absdiff(isfinite(abq_smc_absdiff))))/(length(abq_smc_absdiff));
    count_abq_smc_perdiff(t,1)=(sum(abq_smc_perdiff(isfinite(abq_smc_perdiff))))/(length(abq_smc_perdiff));
    
    % abq-smf
    abq_smf_ef=[abq_img(:),smf_img(:)]; % abq smf fields
    abq_smf_absdiff=zeros(msk_size,1); % absolute difference
    abq_smf_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size        
            abq_smf_absdiff(i,1)=abs(abq_smf_ef(i,1)-abq_smf_ef(i,2));
            abq_smf_perdiff(i,1)=(abs(abq_smf_ef(i,1)-abq_smf_ef(i,2))/abs(max(abq_smf_ef(i,1),abq_smf_ef(i,2))))*100;           
    end
    count_abq_smf_absdiff(t,1)=(sum(abq_smf_absdiff(isfinite(abq_smf_absdiff))))/(length(abq_smf_absdiff));
    count_abq_smf_perdiff(t,1)=(sum(abq_smf_perdiff(isfinite(abq_smf_perdiff))))/(length(abq_smf_perdiff));
    
    % abq-spms
    abq_spms_ef=[abq_img(:),spms_img(:)]; % abq spms fields
    abq_spms_absdiff=zeros(msk_size,1); % absolute difference
    abq_spms_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size
            abq_spms_absdiff(i,1)=abs(abq_spms_ef(i,1)-abq_spms_ef(i,2));
            abq_spms_perdiff(i,1)=(abs(abq_spms_ef(i,1)-abq_spms_ef(i,2))/abs(max(abq_spms_ef(i,1),abq_spms_ef(i,2))))*100;    
    end
    count_abq_spms_absdiff(t,1)= (sum(abq_spms_absdiff(isfinite(abq_spms_absdiff))))/(length(abq_spms_absdiff));
    count_abq_spms_perdiff(t,1)=(sum(abq_spms_perdiff(isfinite(abq_spms_perdiff))))/(length(abq_spms_perdiff));
    
    % rst-spm
    rst_spms_ef=[rst_img(:),spms_img(:)]; % rst spms fields
    rst_spms_absdiff=zeros(msk_size,1); % absolute difference
    rst_spms_perdiff=zeros(msk_size,1); % percentage difference
    
   for i=1:msk_size       
            rst_spms_absdiff(i,1)=abs(rst_spms_ef(i,1)-rst_spms_ef(i,2));
            rst_spms_perdiff(i,1)=(abs(rst_spms_ef(i,1)-rst_spms_ef(i,2))/abs(max(rst_spms_ef(i,1),rst_spms_ef(i,2))))*100;    
    end
    count_rst_spms_absdiff(t,1)=(sum(rst_spms_absdiff(isfinite(rst_spms_absdiff))))/(length(rst_spms_absdiff));
    count_rst_spms_perdiff(t,1)= (sum(rst_spms_perdiff(isfinite(rst_spms_perdiff))))/(length(rst_spms_perdiff));
    
    % rst-smc   
    rst_smc_ef=[rst_img(:),smc_img(:)]; % rst smc fields
    rst_smc_absdiff=zeros(msk_size,1); % absolute difference
    rst_smc_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size        
            rst_smc_absdiff(i,1)=abs(rst_smc_ef(i,1)-rst_smc_ef(i,2));
            rst_smc_perdiff(i,1)=(abs(rst_smc_ef(i,1)-rst_smc_ef(i,2))/abs(max(rst_smc_ef(i,1),rst_smc_ef(i,2))))*100;    end
    count_rst_smc_absdiff(t,1)= (sum(rst_smc_absdiff(isfinite(rst_smc_absdiff))))/(length(rst_smc_absdiff));
    count_rst_smc_perdiff(t,1)= (sum(rst_smc_perdiff(isfinite(rst_smc_perdiff))))/(length(rst_smc_perdiff));
    
    % rst-smf
    rst_smf_ef=[rst_img(:),smf_img(:)]; % rst smf fields
    rst_smf_absdiff=zeros(msk_size,1); % absolute difference
    rst_smf_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size
            rst_smf_absdiff(i,1)=abs(rst_smf_ef(i,1)-rst_smf_ef(i,2));
            rst_smf_perdiff(i,1)=(abs(rst_smf_ef(i,1)-rst_smf_ef(i,2))/abs(max(rst_smf_ef(i,1),rst_smf_ef(i,2))))*100;  
    end
    count_rst_smf_absdiff(t,1)=(sum(rst_smf_absdiff(isfinite(rst_smf_absdiff))))/(length(rst_smf_absdiff));
    count_rst_smf_perdiff(t,1)=(sum(rst_smf_perdiff(isfinite(rst_smf_perdiff))))/(length(rst_smf_perdiff));
    
    % smc-smf
    smc_smf_ef=[smc_img(:),smf_img(:)]; % smc smf fields
    smc_smf_absdiff=zeros(msk_size,1); % absolute difference
    smc_smf_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size       
            smc_smf_absdiff(i,1)=abs(smc_smf_ef(i,1)-smc_smf_ef(i,2));
            smc_smf_perdiff(i,1)=(abs(smc_smf_ef(i,1)-smc_smf_ef(i,2))/abs(max(smc_smf_ef(i,1),smc_smf_ef(i,2))))*100;  
    end
    count_smc_smf_absdiff(t,1)=(sum(smc_smf_absdiff(isfinite(smc_smf_absdiff))))/(length(smc_smf_absdiff));
    count_smc_smf_perdiff(t,1)=(sum(smc_smf_perdiff(isfinite(smc_smf_perdiff))))/(length(smc_smf_perdiff));
    
    % smc-spms
    smc_spms_ef=[smc_img(:),spms_img(:)]; % smc spms fields
    smc_spms_absdiff=zeros(msk_size,1); % absolute difference
    smc_spms_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size        
            smc_spms_absdiff(i,1)=abs(smc_spms_ef(i,1)-smc_spms_ef(i,2));
            smc_spms_perdiff(i,1)=(abs(smc_spms_ef(i,1)-smc_spms_ef(i,2))/abs(max(smc_spms_ef(i,1),smc_spms_ef(i,2))))*100;           
    end
    count_smc_spms_absdiff(t,1)=(sum(smc_spms_absdiff(isfinite(smc_spms_absdiff))))/(length(smc_spms_absdiff));
    count_smc_spms_perdiff(t,1)=(sum(smc_spms_perdiff(isfinite(smc_spms_perdiff))))/(length(smc_spms_perdiff));
    
    % spms-smf
    spms_smf_ef=[spms_img(:),smf_img(:)]; % spms smf fields
    spms_smf_absdiff=zeros(msk_size,1); % absolute difference
    spms_smf_perdiff=zeros(msk_size,1); % percentage difference
    
    for i=1:msk_size       
            spms_smf_absdiff(i,1)=abs(spms_smf_ef(i,1)-spms_smf_ef(i,2));
            spms_smf_perdiff(i,1)=(abs(spms_smf_ef(i,1)-spms_smf_ef(i,2))/abs(max(spms_smf_ef(i,1),spms_smf_ef(i,2))))*100;        
    end
    count_spms_smf_absdiff(t,1)=(sum(spms_smf_absdiff(isfinite(spms_smf_absdiff))))/(length(spms_smf_absdiff));
    count_spms_smf_perdiff(t,1)=(sum(spms_smf_perdiff(isfinite(spms_smf_perdiff))))/(length(spms_smf_perdiff));
end
% concatenate and write the results to excel files
all_counts_absdiff=[count_abq_rst_absdiff,count_abq_smc_absdiff,count_abq_smf_absdiff,count_abq_spms_absdiff,count_rst_smc_absdiff,count_rst_smf_absdiff,count_rst_spms_absdiff,count_smc_smf_absdiff,count_smc_spms_absdiff,count_spms_smf_absdiff];    
all_counts_perdiff=[count_abq_rst_perdiff,count_abq_smc_perdiff,count_abq_smf_perdiff,count_abq_spms_perdiff,count_rst_smc_perdiff,count_rst_smf_perdiff,count_rst_spms_perdiff,count_smc_smf_perdiff,count_smc_spms_perdiff,count_spms_smf_perdiff];   
T1_absdiff=array2table(all_counts_absdiff);
T1_perdiff=array2table(all_counts_perdiff);
% % %load('Z:\age_matched_sim\Volumetric_analysis\01_overall_perc_diff_efields\subnames.mat')%
% % %names for age matched 
load('Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\names.mat'); % names for HC 18
T1_absdiff.Properties.VariableNames={'abq_rst','abq_smc','abq_smf','abq_spm','rst_smc','rst_smf','rst_spms','smc_smf','smc_spm','spm_smf'};
T1_perdiff.Properties.VariableNames={'abq_rst','abq_smc','abq_smf','abq_spm','rst_smc','rst_smf','rst_spm','smc_smf','smc_spm','spm_smf'};
T2_absdiff=addvars(T1_absdiff,names,'Before',1);
T2_perdiff=addvars(T1_perdiff,names,'Before',1);
writetable(T2_absdiff,sprintf('%s_absdiff.xlsx',tissue));
writetable(T2_perdiff,sprintf('%s_perdiff.xlsx',tissue));
    
