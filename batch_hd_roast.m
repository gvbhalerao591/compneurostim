
function batch_hd_roast(roastdir,indir) 
cd(indir) 
a=dir('*'); 
cd(roastdir); 
for i=3:length(a)     
    subj_folder=fullfile(indir,a(i).name);     
    subj_name=dir(fullfile(subj_folder,[a(i).name,'.nii']));    
    subj=fullfile(subj_folder,subj_name.name);    
    roast(subj,{'CP5',-2.0,'FT7',0.5,'FC3',0.5,'P1',0.5,'PO7',0.5},'elecType','disc'); 
end
end