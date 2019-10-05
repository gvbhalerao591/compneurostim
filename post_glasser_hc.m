% This code will process excel files created from
% create_excel_from_efield.m
% This code will output an excel sheet with mean electric field values in each parcel along
% with glasser region names

npgsr_mat=xlsread(fullfile(pwd,'spms_glasser.xlsx'));
load('/media/tpsych7/Seagate_Backup_Plus_Drive/Gaurav_HC_simulation_20-7-2019/scripts/glasser_info_matlab.mat')
N=18; %number of subjects

left_vals=npgsr_mat(181:360,:);
left_pos=zeros(180,N);

for i=1:N
    for j=1:180
        if left_vals(j,i)>0
            left_pos(j,i)=find(left_vals(j,i)>0);    
        else
            left_pos(j,i)=0;
        end
    end
end

left_supra_vals=npgsr_mat(181:360,:).*left_pos; % only supra threshold values (>0.2 v/m)

% handle right hemispheres vals

right_vals=npgsr_mat(1:180,:);
right_pos=zeros(180,N);

for i=1:N
    for j=1:180
        if right_vals(j,i)>0
            right_pos(j,i)=find(right_vals(j,i)>0);    
        else
            right_pos(j,i)=0;
        end
    end
end

right_supra_vals=npgsr_mat(1:180,:).*right_pos; 

% mean right and left values if both are present
final_supra_vals=zeros(180,N);
for j=1:N
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
matched_supra_vals=zeros(180,N);

for j=1:N
    for i=1:180
        if (final_supra_vals(i,j)~=0)
            matched_supra_vals(i,j)=glass_std_secs(i,2);
        else 
            matched_supra_vals(i,j)=0;
        end
    end
end

% avaerage values in each section of the parcels
reg=zeros(22,N);
for j=1:N
    for i=1:22
        pos=find(matched_supra_vals(:,j)==i);
        em=isempty(pos);
        if em~=1
            reg(i,j)=std(final_supra_vals(pos(:,1),j));
        else
            reg(i,j)=0;
        end        
    end
end

% create output table and save it
T=array2table(reg);
%T.Properties.VariableNames={'C0019','C0020','C0054','C0085','C0091','C0097','C0102','C0110','C0113','C0137','C0155','C0159','C0167','C0185','C0201','C0218'};
%T.Properties.VariableNames={'anand','anitha','bhuvaneshwari','ganesh','jyothi','manjunath','manjunathtn','manjunathv','manohar','narathna','naresh','nareshv','pradeepthi','raghu','rajeev','rajesh','rekha','rilna','sagira','satish','srivalli','suguna'};
T.Properties.VariableNames={'C0002' 'C0004' 'C0005' 'C0034' 'C0056' 'C0075' 'C0081' 'C0082' 'C0089' 'C0090' 'C0095' 'C0096' 'C0097' 'C0114' 'C0149' 'C0171' 'C0211' 'C0217'};
T2=addvars(T,glasser_regions,'Before',1);
%writetable(T2,fullfile(pwd,'mean_values_in_each_parcel','abaq_mean_in_parcels.xlsx'));
writetable(T2,fullfile(pwd,'spms_std_in_parcels.xlsx'));