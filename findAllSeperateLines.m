function allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids)
if ~isempty(ids)    %ids是所有包含分支点的线id
    A=everylines{1};
    [m,n]=size(A);
    AA=zeros(m,n);
    for i=1:length(everylines)
        if ismember(i,ids)
            continue;
        end
        E=everylines{i};
        [r,c]=find(E==1);
        for a=1:size(r)
            AA(r(a,1),c(a,1))=1;
        end
    end
    for i=1:length(seperateLinesGraphics)
        E=seperateLinesGraphics{i};
        [r,c]=find(E==1);
        for a=1:size(r)
            AA(r(a,1),c(a,1))=1;
        end
    end
end
allSeperateLinesGraphics=AA;