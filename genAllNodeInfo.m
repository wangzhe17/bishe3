function allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes,allEndpointsNodes)
allNodeInfo=[];
k=1;
allNodesT=allNodes;
for i=1:length(allNodesT)
    node=allNodesT{i};
    if isempty(node)
        continue;
    end
    centroidNode = regionprops(node, 'Centroid');
    centroidN=centroidNode.Centroid;
    for j=1:length(allprimitives)
        primitive=allprimitives{j};
        centroidPrimitive = regionprops(primitive, 'Centroid');
        centroidP=centroidPrimitive.Centroid;
        if centroidN==centroidP
            field1='nodeId';value1=k;
            field2='type';value2='primitive';
            field3='centroid';value3=centroidN;
            field4='image';value4=node;
            sPrimitive=struct(field1,value1,field2,value2,field3,value3,field4,value4);
            allNodeInfo{k}=sPrimitive;
            k=k+1;
            allNodesT{i}=[];
        end
    end
end

for i=1:length(allNodesT)
    node=allNodesT{i};
    if isempty(node)
        continue;
    end
    centroidNode = regionprops(node, 'Centroid');
    centroidN=centroidNode.Centroid;
    for j=1:length(allJointpointsNodes)
        JointpointsNode=allJointpointsNodes{j};
        centroidJointpointsNode = regionprops(JointpointsNode, 'Centroid');
        centroidJ=centroidJointpointsNode.Centroid;
        if centroidN==centroidJ
            field1='nodeId';value1=k;
            field2='type';value2='jointpoint';
            field3='centroid';value3=centroidN;
            field4='image';value4=node;
            sJointpointsNode=struct(field1,value1,field2,value2,field3,value3,field4,value4);
            allNodeInfo{k}=sJointpointsNode;
            k=k+1;
            allNodesT{i}=[];
        end
    end
end

for i=1:length(allNodesT)
    node=allNodesT{i};
    if isempty(node)
        continue;
    end
    centroidNode = regionprops(node, 'Centroid');
    centroidN=centroidNode.Centroid;
    for j=1:length(allEndpointsNodes)
        EndpointsNode=allEndpointsNodes{j};
        centroidEndpointsNode = regionprops(EndpointsNode, 'Centroid');
        centroidJ=centroidEndpointsNode.Centroid;
        if centroidN==centroidJ
            field1='nodeId';value1=k;
            field2='type';value2='endpoint';
            field3='centroid';value3=centroidN;
            field4='image';value4=node;
            sEndpointsNode=struct(field1,value1,field2,value2,field3,value3,field4,value4);
            allNodeInfo{k}=sEndpointsNode;
            k=k+1;
            allNodesT{i}=[];
        end
    end
end