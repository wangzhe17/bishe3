function allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes)
allJointpointsNodes=[];
[L,num] = bwlabel(jointpointsNodes,8);
[w,h]=size(jointpointsNodes);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    allJointpointsNodes{i}=A;
end
num=num;
allJointpointsNodes=allJointpointsNodes;