% This code will process excel files created from
% create_excel_from_efield.m
% This code will output an excel sheet with electric field values along
% with glasser region names

%% Only applicable to left hemisphere efield values in glasser parcels

npgsr_mat=xlsread('/home/tpsych7/Gaurav_Simnibs_tDCS/age_matched_sims/Run_simScript/cat_sims/02_Glasser_application/03_excel_processing/hc20_smc_glasser.xlsx');
load('/home/tpsych7/Workbench/Pipelines_Wholeefields/glasser_info_matlab.mat')

left_vals=npgsr_mat(181:360,:);
left_pos=zeros(180,22);

for i=1:22
    for j=1:180
        if left_vals(j,i)>0.2
            left_pos(j,i)=find(left_vals(j,i)>0.2);    
        else
            left_pos(j,i)=0;
        end
    end
end

left_supra_vals=npgsr_mat(181:360,:).*left_pos; % only supra threshold values (>0.2 v/m)

% handle right hemispheres vals

right_vals=npgsr_mat(1:180,:);
right_pos=zeros(180,22);

for i=1:22
    for j=1:180
        if right_vals(j,i)>0.2
            right_pos(j,i)=find(right_vals(j,i)>0.2);    
        else
            right_pos(j,i)=0;
        end
    end
end

right_supra_vals=npgsr_mat(1:180,:).*right_pos; 

% mean right and left values if both are present
final_supra_vals=zeros(180,22);
for j=1:22
    for i=1:180
        if (left_supra_vals(i,j)~=0) && (right_supra_vals(i,j)~=0)
            final_supra_vals(i,j)=(left_supra_vals(i,j)+right_supra_vals(i,j))/2;
        elseif (left_supra_vals(i,j)~=0) && (right_supra_vals(i,j)==0)
            final_supra_vals(i,j)=left_supra_vals(i,j);
        elseif (left_supra_vals(i,j)==0) && (right_supra_vals(i,j)~=0)
            final_supra_vals(i,j)=right_supra_vals(i,j);
        else
            final_supra_vals(i,j)=0;
        end
    end
end

% match the values with original glasser and take out section, parcel
% index
matched_supra_vals=zeros(180,22);

for j=1:22
    for i=1:180
        if (final_supra_vals(i,j)~=0)
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
            reg(i,j)=mean(final_supra_vals(pos(:,1),j));
        else
            reg(i,j)=0;
        end        
    end
end

% create output table and save it
T=array2table(reg);
T.Properties.VariableNames={'anand' 'anitha' 'bhuvaneshwari' 'ganesh' 'jyothi' 'manjunath' 'manjunathtn' 'manjunathv' 'manohar' 'narathna' 'naresh' 'nareshv' 'pradeepthi' 'raghu' 'rajeev' 'rajesh' 'rekha' 'rilna' 'sagira' 'satish' 'srivalli' 'suguna'};
T2=addvars(T,glasser_regions,'Before',1);
writetable(T2,fullfile(npgsr_mat,'hc20_glasser_output.xlsx'));