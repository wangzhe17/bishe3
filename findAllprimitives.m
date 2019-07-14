function allprimitives=findAllprimitives(primitives)
allprimitives=[];
[L,num] = bwlabel(primitives,8);
[w,h]=size(primitives);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    allprimitives{i}=A;
end
num=num;
allprimitives=allprimitives;