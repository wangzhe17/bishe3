function [allArrowImages,allArrowSkeletonImages]=findAllArrowImages(allArrowPoints,linesgraphic,linewidth,AllSkeletonLines)
allArrowImages=[];
allArrowSkeletonImages=[];
for i=1:length(allArrowPoints)
    arrowPoint=allArrowPoints{i};
    if isempty(arrowPoint)
        continue;
    end
    x=arrowPoint(1,1);
    y=arrowPoint(1,2);
    arrow=linesgraphic(x-2.5*linewidth:x+2.5*linewidth,y-2.5*linewidth:y+2.5*linewidth);
    arrowSkeleton=AllSkeletonLines(x-2.5*linewidth:x+2.5*linewidth,y-2.5*linewidth:y+2.5*linewidth);
    allArrowImages{i}=arrow;
    allArrowSkeletonImages{i}=arrowSkeleton;
end
