function AllSkeletonLines=combineAllSkeletonLines(everySkeletonLines)
A=zeros(size(everySkeletonLines{1}));
for i=1:length(everySkeletonLines)
    SkeletonLine=everySkeletonLines{i};
    A=or(A,SkeletonLine);
end
AllSkeletonLines=A;