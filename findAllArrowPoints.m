function [allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll)
allArrowPoints=[];
totalSum=0;
allMaxIndex=[];
for i=1:length(everySkeletonSumAll)
    eachSumAll=everySkeletonSumAll{i};
    [maxSumAll,maxIndex]=max(eachSumAll);
    allMaxIndex{i}=maxIndex;
    totalSum=totalSum+maxSumAll;
end

averageSum=totalSum./length(everySkeletonSumAll);
for i=1:length(everySkeletonSumAll)
    eachSumAll=everySkeletonSumAll{i};
    maxSumAll=max(eachSumAll);
    if maxSumAll < 0.85*averageSum
        continue;
    end
    ArrowPointIndex=allMaxIndex{i};
    everySkeletonPoint=everySkeletonPoints{i};
    ArrowPoint=everySkeletonPoint{ArrowPointIndex};
    allArrowPoints{i}=ArrowPoint;
end
