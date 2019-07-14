function everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics)
[L,num]=bwlabel(allSeperateLinesGraphics);
[w,h]=size(allSeperateLinesGraphics);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    everySeperateLines{i}=A;
end
