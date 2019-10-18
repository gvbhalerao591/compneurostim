%% Import all left hemisphere values (from text files, from workbench script)
a=dir('*.txt');
for i=1:length(a)
    vals(:,i)=load(a(i).name);
end
realvals=vals(181:360,:);
load('Z:\Comp_neurostim_work_GVB\simnibs_snf_schiz_hd\Glasser_normalised_usethis\glasser_info_matlab.mat')

%% maxs for all parcels and sections
matched_supra_vals=zeros(180,22);

for j=1:22
    for i=1:180
        if (realvals(i,j)~=0)
            matched_supra_vals(i,j)=glass_std_secs(i,2);
        else 
            matched_supra_vals(i,j)=0;
        end
    end
end

% avaerage values in each section of the parcels
reg=zeros(22,22);
for j=1:22
    for i=1:22
        pos=find(matched_supra_vals(:,j)==i);
        em=isempty(pos);
        if em~=1
            reg(i,j)=max(realvals(pos(:,1),j));
        else
            reg(i,j)=0;
        end        
    end
end

% create output table and save it
T=array2table(reg);
T.Properties.VariableNames={'anand' 'anitha' 'bhuvaneshwari' 'ganesh' 'jyothi' 'manjunath' 'manjunathtn' 'manjunathv' 'manohar' 'narathna' 'naresh' 'nareshv' 'pradeepthi' 'raghu' 'rajeev' 'rajesh' 'rekha' 'rilna' 'sagira' 'satish' 'srivalli' 'suguna'};
T2=addvars(T,glasser_regions,'Before',1);
writetable(T2,'smc_scz_22_allsections_glasser_peak.xlsx');

%% Only ROIs: EAC, AAC, DLPFC, considering including sections
load('Z:\Comp_neurostim_work_GVB\simnibs_snf_schiz_hd\Glasser_normalised_usethis\EAC_AAC_DLPFC_include_surround_glasserSecs.mat')

EAC_invals=realvals(EAC_includes(:,1),:);
AAC_invals=realvals(AAC_includes(:,1),:);
DLPFC_invals=realvals(DLPFC_includes(:,1),:);

EAC_includes_max=max(EAC_invals(:,:));
AAC_includes_max=max(AAC_invals(:,:));
DLPFC_includes_max=max(DLPFC_invals(:,:));

ROIs_includes_max=[EAC_includes_max',AAC_includes_max',DLPFC_includes_max'];
subj_names={'anand' 'anitha' 'bhuvaneshwari' 'ganesh' 'jyothi' 'manjunath' 'manjunathtn' 'manjunathv' 'manohar' 'narathna' 'naresh' 'nareshv' 'pradeepthi' 'raghu' 'rajeev' 'rajesh' 'rekha' 'rilna' 'sagira' 'satish' 'srivalli' 'suguna'};
T=array2table(ROIs_includes_max);
T2=addvars(T,subj_names','Before',1);
T2.Properties.VariableNames={'SubjectName','Early_auditory_cortex','Auditory_association_cortex','DorsoLateral_prefrontal_cortex'};
writetable(T2,'smc_scz_22_ROIsecsIncludes_glasser_peak.xlsx');

%% Only ROIs: EAC, AAC, DLPFC, considering surrounding sections (have not included AAVC_fconnection)

EAC_surroundvals=realvals(EAC_surrounds(:,1),:);
AAC_surroundvals=realvals(AAC_surrounds(:,1),:);
DLPFC_surroundvals=realvals(DLPFC_surrounds(:,1),:);

EAC_surrounds_max=max(EAC_surroundvals(:,:));
AAC_surrounds_max=max(AAC_surroundvals(:,:));
DLPFC_surrounds_max=max(DLPFC_surroundvals(:,:));

ROIs_surrounds_max=[EAC_surrounds_max',AAC_surrounds_max',DLPFC_surrounds_max'];
subj_names={'anand' 'anitha' 'bhuvaneshwari' 'ganesh' 'jyothi' 'manjunath' 'manjunathtn' 'manjunathv' 'manohar' 'narathna' 'naresh' 'nareshv' 'pradeepthi' 'raghu' 'rajeev' 'rajesh' 'rekha' 'rilna' 'sagira' 'satish' 'srivalli' 'suguna'};
T=array2table(ROIs_surrounds_max);
T2=addvars(T,subj_names','Before',1);
T2.Properties.VariableNames={'SubjectName','Early_auditory_cortex','Auditory_association_cortex','DorsoLateral_prefrontal_cortex'};
writetable(T2,'smc_scz_22_ROIsecsSurrounds_glasser_peak.xlsx');

%%
