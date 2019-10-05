% Pipeline: abq, rst, smc_simnibs, smf_simnibs, spm_simnibs
% main dir: parent dir
% masks_dir: wfu masks dir
% piepline: pipeline name (must match with folder name)
% matfilename: matfile containing names of subjects
% n=no. of subjects
function T2=ba_mean_efs(main_dir,masks_dir,pipeline,matfilename,n)
% total subjects
    subjects=n;
    tissue='brain';
    % pipeline directories
    parent_dir=fullfile(main_dir,pipeline);
    abq_efs=dir(fullfile(parent_dir,tissue,'*.nii'));
%     abq_efs=dir(fullfile(parent_dir,'normalized',tissue,'*.nii'));
    % mask directory and load masks
    ba_masks=dir(fullfile(masks_dir,'*.nii'));

    abq_mean_roi=zeros(subjects,length(ba_masks));
    abq_std_roi=zeros(subjects,length(ba_masks));

    for ba=1:length(ba_masks)
        for subj=1:length(abq_efs)
            abq_mean_roi(subj,ba)=spm_summarise(spm_vol(fullfile(abq_efs(subj).folder,abq_efs(subj).name)),fullfile(ba_masks(ba).folder,ba_masks(ba).name),@mean);
            %abq_std_roi(subj,ba)=spm_summarise(spm_vol(fullfile(abq_efs(subj).folder,abq_efs(subj).name)),fullfile(ba_masks(ba).folder,ba_masks(ba).name),@std);
        end
    end
    %load('Z:\age_matched_sim\Volumetric_analysis\01_overall_perc_diff_efields\subnames.mat')
    load(matfilename);
    T2=array2table(abq_mean_roi);
    T2.Properties.VariableNames={'BA22_left' 'BA22_right' 'BA39_left' 'BA39_right' 'BA40_left' 'BA40_right' 'BA41_left' 'BA41_right' 'BA42_left' 'BA42_right' 'BA46_left' 'BA46_right' 'BA8_left' 'BA8_right' 'BA9_left' 'BA9_right'};
    T22=addvars(T2,names,'Before',1);
    writetable(T22,sprintf('%s_%s_percdiff_roimeaures.xlsx',pipeline,tissue));
end

