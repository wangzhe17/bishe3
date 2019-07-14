function allEndpointsNodes=findAllEndpointsNodes(endPointNodesGraphic)
allEndpointsNodes=[];
[L,num] = bwlabel(endPointNodesGraphic,8);
[w,h]=size(endPointNodesGraphic);
for i=1:num
    [r,c]=find(L==i);
    A=zeros(w,h);
    for j=1:size(r)
        A(r(j,1),c(j,1))=1;
    end
    allEndpointsNodes{i}=A;
end
num=num;
allEndpointsNodes=allEndpointsNodes;