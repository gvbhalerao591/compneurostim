% Create all_epg.mat for further processing in part 2 script
dirname='E:\Gaurav\tDCS_data_for_scanIP\Abaqus_work_tDCS\00_interplote_efield\Remaining';
cd(dirname)
%%
subj=dir('*');
b=9:16; %dlelete duplicate files
for subjs=3:length(subj)
    subjdir=fullfile(subj(subjs).folder,subj(subjs).name);
    subjfile=[subj(subjs).name,'_efield_abaqus.rpt'];
    getEPG(subjdir,subjfile);
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(1)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(2)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(3)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(4)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(5)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(6)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(7)))); 
    delete(fullfile(subj(subjs).folder,subj(subjs).name,sprintf('Field_Output_%d.mat',b(8)))); 
    matfiles=dir(fullfile(subj(subjs).folder,subj(subjs).name,'Field_Output_*.mat'));
    epg=0;
    epg=cell(epg);
        for files=1:length(matfiles)
            load(fullfile(matfiles(files).folder,matfiles(files).name));
            epg{files}=EPGData;
        end
    epg_all=vertcat(epg{1,1},epg{1,2},epg{1,2},epg{1,3},epg{1,5},epg{1,6},epg{1,7},epg{1,8});
    save(fullfile(subj(subjs).folder,subj(subjs).name,'all_epg.mat'),'epg_all');
end
%%
