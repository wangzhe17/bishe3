function [everylines]=seperateLines(linesgraphic)
[L,num]=bwlabel(linesgraphic);
[w,h]=size(linesgraphic);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    everylines{i}=A;
end
