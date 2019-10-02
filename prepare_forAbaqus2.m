function prepare_forAbaqus2(indir,currden)
cd(indir);
list_subj=dir('*');
for subj=3:length(list_subj)
   dirname=fullfile(list_subj(subj).folder,list_subj(subj).name);
   fname=[list_subj(subj).name,'_scanip'];
   %movefile(fullfile(dirname,[list_subj(subj).name,'_rnge_elec.mat']),fullfile(dirname,list_subj(subj).name,'rnge_elec.mat'));
   %movefile(fullfile(dirname,[list_subj(subj).name,'_rnge_gel.mat']),fullfile(dirname,list_subj(subj).name,'rnge_gel.mat'));
   tpysch_bipolar_tDCS(dirname,fname,currden);
end
end
   