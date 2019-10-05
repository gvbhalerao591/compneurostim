global Defaults;
Defaults = spm_get_defaults;
spm_jobman('initcfg');
P=spm_get(Inf,'*.nii','Select source files'); 
P=cellstr(P);
Q=spm_get(Inf,'*.nii','Select electric field files to write');
Q=cellstr(Q);
R=spm_get(Inf,'*.nii','Select wm mask files to write');
R=cellstr(R);
S=spm_get(Inf,'*.nii','Select gm mask files to write');
S=cellstr(S);
T=spm_get(Inf,'*.nii','Select csf mask files to write');
T=cellstr(T);
U=spm_get(Inf,'*.nii','Select skin mask files to write');
U=cellstr(U);
V=spm_get(Inf,'*.nii','Select bone mask files to write');
V=cellstr(V);
% W=spm_get(Inf,'*.nii','Select air mask files to write');
% W=cellstr(W);
% R=spm_get(Inf,'*.nii','SelectEFIELD');
% R=cellstr(R);

for i=1:length(P)
    matlabbatch{1}.spm.tools.oldnorm.estwrite.subj.source = P(i);
    matlabbatch{1}.spm.tools.oldnorm.estwrite.subj.wtsrc = '';
    matlabbatch{1}.spm.tools.oldnorm.estwrite.subj.resample = {Q{i} R{i} S{i} T{i} U{i} V{i}}';
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.template = {'E:\spm12\toolbox\OldNorm\T1.nii,1'};
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.weight = '';
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.smosrc = 8;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.smoref = 0;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.regtype = 'mni';
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.cutoff = 25;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.nits = 16;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.eoptions.reg = 1;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.roptions.preserve = 0;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.roptions.bb = [NaN NaN NaN
                                                             NaN NaN NaN];
    matlabbatch{1}.spm.tools.oldnorm.estwrite.roptions.vox = [2 2 2];
    matlabbatch{1}.spm.tools.oldnorm.estwrite.roptions.interp = 1;
    matlabbatch{1}.spm.tools.oldnorm.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.tools.oldnorm.estwrite.roptions.prefix = 'w';
    spm_jobman('run',matlabbatch);
end