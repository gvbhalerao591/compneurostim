xlsdir='Z:\Comp_neurostim_work_GVB\HC_20_JULY_2019\All_simulations_niis\zz_All_mean_EF_measures';
abq_means=xlsread(fullfile(xlsdir,'abq_sims_brain_roimeaures.xlsx'),'A1:S19');
rst_means=xlsread(fullfile(xlsdir,'roast_sims_brain_roimeaures.xlsx'),'A1:S19');
smc_means=xlsread(fullfile(xlsdir,'cat_sims_brain_roimeaures.xlsx'),'A1:S19');
smf_means=xlsread(fullfile(xlsdir,'freesurfer_sims_brain_roimeaures.xlsx'),'A1:S19');
spms_means=xlsread(fullfile(xlsdir,'spms_sims_brain_roimeaures.xlsx'),'A1:S19');

ba_tests_left=cell(11,9);
pipe1={'abq-rst','abq-smc','abq-smf','abq-spms','rst-smc','rst-smf','rst-spms','smc-smf','smc-spms','spms-smf'};
rois={'22L','39L','40L','41L','42L','46L','8L','9L','GM','WM'};
ba_tests_left(2:11,1)=pipe1;
ba_tests_left(1,2:9)=rois;

BA22L=[abq_means(:,1),rst_means(:,1),smc_means(:,1),smf_means(:,1),spms_means(:,1)];
[~,~,stats]=kruskalwallis(BA22L);
p_vals_ba22=multcompare(stats);
ba_tests_left(2:11,2)=num2cell(p_vals_ba22(:,6));

BA39L=[abq_means(:,3),rst_means(:,3),smc_means(:,3),smf_means(:,3),spms_means(:,3)];
[~,~,stats]=kruskalwallis(BA39L);
p_vals_ba39=multcompare(stats);
ba_tests_left(2:11,3)=num2cell(p_vals_ba39(:,6));

BA40L=[abq_means(:,5),rst_means(:,5),smc_means(:,5),smf_means(:,5),spms_means(:,5)];
[~,~,stats]=kruskalwallis(BA40L);
p_vals_ba40=multcompare(stats);
ba_tests_left(2:11,4)=num2cell(p_vals_ba40(:,6));

BA41L=[abq_means(:,7),rst_means(:,7),smc_means(:,7),smf_means(:,7),spms_means(:,7)];
[~,~,stats]=kruskalwallis(BA41L);
p_vals_ba41=multcompare(stats);
ba_tests_left(2:11,5)=num2cell(p_vals_ba41(:,6));

BA42L=[abq_means(:,9),rst_means(:,9),smc_means(:,9),smf_means(:,9),spms_means(:,9)];
[~,~,stats]=kruskalwallis(BA42L);
p_vals_ba42=multcompare(stats);
ba_tests_left(2:11,6)=num2cell(p_vals_ba42(:,6));

BA46L=[abq_means(:,11),rst_means(:,11),smc_means(:,11),smf_means(:,11),spms_means(:,11)];
[~,~,stats]=kruskalwallis(BA46L);
p_vals_ba46=multcompare(stats);
ba_tests_left(2:11,7)=num2cell(p_vals_ba46(:,6));

BA8L=[abq_means(:,13),rst_means(:,13),smc_means(:,13),smf_means(:,13),spms_means(:,13)];
[~,~,stats]=kruskalwallis(BA8L);
p_vals_ba8=multcompare(stats);
ba_tests_left(2:11,8)=num2cell(p_vals_ba8(:,6));

BA9L=[abq_means(:,15),rst_means(:,15),smc_means(:,15),smf_means(:,15),spms_means(:,15)];
[~,~,stats]=kruskalwallis(BA9L);
p_vals_ba9=multcompare(stats);
ba_tests_left(2:11,9)=num2cell(p_vals_ba9(:,6));

BA_gm=[abq_means(:,17),rst_means(:,17),smc_means(:,16),smf_means(:,15),spms_means(:,15)];
[~,~,stats]=kruskalwallis(BA9L);
p_vals_ba9=multcompare(stats);
ba_tests_left(2:11,9)=num2cell(p_vals_ba9(:,6));

T=cell2table(ba_tests_left);
outdir=fullfile(xlsdir);
writetable(T,fullfile(outdir,'ba_left_EFmeans_kruskal_multcomp.xlsx'));

% heatplot

h=heatmap(T,'tt1','tt2','ColorVariable','tt3');
h.Colormap=jet;
h.XLabel='Pipeline Comparison';
h.YLabel='BA ROIs (Left)';
h.Title='Kruskal Wallis test for mean EFs in BA ROIs';
saveas(gcf,fullfile(outdir,'nonpara_pvals_meanEF_BA_left.png'),'png');
print(gcf,'-dpng',fullfile(outdir,'nonpara_pvals_meanEF_BA_left.png'),'-r600');
saveas(gcf,fullfile(outdir,'nonpara_pvals_meanEF_BA_left.fig'));








