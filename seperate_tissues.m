P=spm_get(Inf,'*.nii','Select images');
P1=cellstr(P);
for i=1:length(P1)
    [dirname,n,~]=fileparts(P1{i});
    vol=load_untouch_nii(P1{i});
    data=vol.img;
    data_backup=data;
    for v=1:6
        data(data~=v)=0;
        data(data==v)=1;
        vol.img=data;
        %save_untouch_nii(vol,sprintf('class_%d_%s',v,n));
        %save_untouch_nii(vol,fullfile(dirname,sprintf('class_%d_%s',v,'tissue')));
        save_untouch_nii(vol,sprintf('%s_%d_%s',n,v,'tissue'));
        data=data_backup;
    end
end

