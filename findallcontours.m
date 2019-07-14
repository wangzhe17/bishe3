function [candidateContours,num] = findallcontours(innercontour)

[L,num] = bwlabel(innercontour,8);
[w,h]=size(innercontour);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    candidateContours{i}=A;
end
num=num;
candidateContours=candidateContours;