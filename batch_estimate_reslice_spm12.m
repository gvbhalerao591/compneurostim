P=spm_get(Inf,'*.nii','Select reference images'); 
P=cellstr(P);
Q=spm_get(Inf,'*.nii','Select source images');
Q=cellstr(Q);

global Defaults;
Defaults = spm_get_defaults;
spm_jobman('initcfg');

for j=1:length(Q)
    matlabbatch{1}.spm.spatial.coreg.estwrite.ref = P(j);
    matlabbatch{1}.spm.spatial.coreg.estwrite.source = Q(j);
    matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 0;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
    spm_jobman('run',matlabbatch);
end