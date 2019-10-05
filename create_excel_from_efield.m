a=dir('*.txt');
for i=1:length(a)
    e(:,i)=load(a(i).name);
end
j=1:1:18;
k=19:1:36;
f(:,j)=e(:,j)+e(:,k); 
temp=1:1:360;
temp=temp';
g=horzcat(f,temp);
T=array2table(f);
writetable(T,'spms_glasser.xlsx');    

