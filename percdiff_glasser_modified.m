% This function is used to compare electric field across two pipelines.
% It requires glasser output excel files and a variable with comp_pipe to write the results 
% in excel sheet. Several other paths needs to be adjusted for custromization
% batch version of this function is available with script_perdiff_all.m

function percdiff_glasser_modified(pipe1,pipe2,comp_pipe)
    %% Variable initialization
    parcels=360;
    subjects=18;
    parcels_onehem=360/2;
    load('/media/tpsych7/Seagate_Backup_Plus_Drive/Gaurav_HC_simulation_20-7-2019/scripts/glasser_info_matlab.mat','glass_std_secs','glasser_regions')
    perc_diff=zeros(parcels,subjects);
    rd_pipe1=round(pipe1,3);
    rd_pipe2=round(pipe2,3);
    for i=1:subjects
        perc_diff(:,i)=((abs(rd_pipe1(:,i)-rd_pipe2(:,i)))./(max(rd_pipe1(:,1),rd_pipe2(:,i)))).*100;
    end

    % Seperate left and right hemisphere
    left_glasser=perc_diff(181:360,:);
    right_glasser=perc_diff(1:180,:);
    avg_percdiff=zeros(parcels_onehem,subjects);
    % Average left and right values
    for j=1:subjects
        for i=1:parcels_onehem
            if isfinite(left_glasser(i,j))==1 && isfinite(right_glasser(i,j))==1
                avg_percdiff(i,j)=(left_glasser(i,j)+right_glasser(i,j))./2;
            elseif isfinite(left_glasser(i,j))==0 && isfinite(right_glasser(i,j))==1
                avg_percdiff(i,j)=right_glasser(i,j);
            elseif isfinite(left_glasser(i,j))==1 && isfinite(right_glasser(i,j))==0
                avg_percdiff(i,j)=right_glasser(i,j);
            else 
                avg_percdiff(i,j)=NaN;
            end
        end
    end
       
                
    perc_glasser=zeros(subjects,subjects);

    for i=1:subjects
        for j=1:22
            pos=find(glass_std_secs(:,2)==j);
            perc_glasser(j,i)=mean(avg_percdiff(pos(:,1),i),'omitnan');
        end
    end

    T=array2table(perc_glasser);
    %T.Properties.VariableNames={'C0019','C0020','C0054','C0085','C0091','C0097','C0102','C0110','C0113','C0137','C0155','C0159','C0167','C0185','C0201','C0218'};
    T.Properties.VariableNames={'C0002' 'C0004' 'C0005' 'C0034' 'C0056' 'C0075' 'C0081' 'C0082' 'C0089' 'C0090' 'C0095' 'C0096' 'C0097' 'C0114' 'C0149' 'C0171' 'C0211' 'C0217'};
    T2=addvars(T,glasser_regions,'Before',1);
    writetable(T2,fullfile(pwd,sprintf('%s_percdiff.xlsx',comp_pipe)));
end