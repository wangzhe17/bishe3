function allNodes=findAllNodes(nodes)
allNodes=[];
[L,num] = bwlabel(nodes,8);
[w,h]=size(nodes);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    allNodes{i}=A;
end
num=num;
allNodes=allNodes;