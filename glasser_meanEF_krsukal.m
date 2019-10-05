xlsdir='Z:\Comp_neurostim_work_GVB\SCZ_25_JUNE_2019\02_for_correlation_with_clinicalscores\Glasser_ROIs\Mean_EF_correlation_with_clinicalScores\03_glasser_rois_means';
abq_means=xlsread(fullfile(xlsdir,'scz_abq_mean_in_parcels.xlsx'));
rst_means=xlsread(fullfile(xlsdir,'scz_np_mean_in_parcels.xlsx'));
smc_means=xlsread(fullfile(xlsdir,'scz_rst_mean_in_parcels.xlsx'));
smf_means=xlsread(fullfile(xlsdir,'scz_smc_mean_in_parcels.xlsx'));
spms_means=xlsread(fullfile(xlsdir,'scz_smf_mean_in_parcels.xlsx'));

abq_means1=abq_means';
rst_means1=rst_means';
smc_means1=smc_means';
smf_means1=smf_means';
spms_means1=spms_means';

pipe1={'abq-rst','abq-smc','abq-smf','abq-spms','rst-smc','rst-smf','rst-spms','smc-smf','smc-spms','spms-smf'};
rois={'PVC','EVC','DSVC','VSVC','MCNVC','SMC','PLMCC','PMC','POC','EAC','AAC','IFOC','MTC','LTC','TPOJ','SPC','IPC','PCC','ACMPfC','OBFC','IFC','DLPFC'};

glas_roi=zeros(22,5);
all_pvals=cell(11,23);
all_pvals(2:11,1)=pipe1;
all_pvals(1,2:23)=rois;

for i=1:22
    glas_roi(:,:)=[abq_means1(:,i),rst_means1(:,i),smc_means1(:,i),smf_means1(:,i),spms_means1(:,i)];
    [~,~,stats]=kruskalwallis(glas_roi);
    p_vals=multcompare(stats);
    all_pvals(2:11,i+1)=num2cell(p_vals(:,6));
end

T=cell2table(all_pvals);
outdir='Z:\Comp_neurostim_work_GVB\SCZ_25_JUNE_2019\02_for_correlation_with_clinicalscores\Glasser_ROIs\Mean_EF_correlation_with_clinicalScores\03_glasser_rois_means\kruskal_wallis';
writetable(T,fullfile(outdir,'glasser_EFmeans_kruskal_pvals.xlsx'));

% heatplot
tt=cell(220,3);
T_name=cell2table(tt);
h=heatmap(T_name,'tt1','tt2','ColorVariable','tt3');
h.Colormap=jet;
h.XLabel='Pipeline Comparison';
h.YLabel='Glasser ROIs';
h.Title='Kruskal Wallis test for mean EFs in Glasser ROIs';
saveas(gcf,fullfile(outdir,'nonpara_pvals_meanEF_glasser.png'),'png');
print(gcf,'-dpng',fullfile(outdir,'nonpara_pvals_meanEF_glasser.png'),'-r600');
saveas(gcf,fullfile(outdir,'nonpara_pvals_meanEF_glasser.fig'));








