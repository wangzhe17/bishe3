clc;
clear;
load 191.mat;
relation1=relations{2};
for i=1:length(allNodeInfo)
    idA=relation1.idA;                %A节点
    if i~=idA
        continue;
    end
    if i==idA
        node1=allNodeInfo{idA};
    end
    node1Image=node1.image;
end
for i=1:length(allNodeInfo)
    idB=relation1.idB;                %B节点
    if i~=idB
        continue;
    end
    if i==idB
        node2=allNodeInfo{idB};
    end
    node2Image=node2.image;
end
for i=1:length(allLineInfo)
    idline=relation1.idline;           %连接线
    if i~=idline
        continue;
    end
    if idline==i
        line=allLineInfo{i};
        lineImage=line.lineImage;
    end
end

skeletonLine=line.SkeletonLine;


if strcmp(node1.type,'primitive')&strcmp(node2.type,'primitive')  %两个节点都是图元的情况
    se1=strel('disk',6);                  %先膨胀后，细化可去毛刺
    node1Image=imdilate(node1Image,se1);
    node2Image=imdilate(node2Image,se1);
    lineImage=imdilate(lineImage,se1);
    all=or(node1Image,lineImage);       %node1和line相连，看交叉点
    [A,node1Image]=zhang(~node1Image);
    [A,node2Image]=zhang(~node2Image);
%     [A,line]=zhang(~line);
    [A,all]=zhang(~all);
%     line=~line;
    all=~all;
    jointpoints1=findjointpoints(all);  %搜索node1和line的交叉点
    endpoints=findAllendPoints(skeletonLine);   %搜索line的两个端点
    point1=endpoints{1};            %连接线的1个端点point1
    point2=endpoints{2};             %连接线的另一个端点point2
    point3=jointpoints1{1};         %连接线与node1的交点
    dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);  
    dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);  %图元连接点与两个端点的距离
    [tt,skeletonLineEndpoint,startPoint,LineEndpointA,LineEndpointB,endPoint,msg]=genPointDirect(line,linewidth);%产生链接信息
    if dis1<dis2 %若dis1比dis2小 则point1离交点point3更近，即端点point1与分支点更近，端点point1与图元node1相连
        %加入信息，即图元node1与端点point1其相连
        %msg='图元node1与端点point1其相连';
        if isequal(msg,'fromBtoA')
            if isequal(point1,LineEndpointB)
                msg1='fromNodeAtoNodeB';
            elseif isequal(point1,LineEndpointA)
                msg1='fromNodeBtoNodeA';
            end
        elseif isequal(msg,'fromAtoB')
            if isequal(point1,LineEndpointB)
                msg1='fromNodeBtoNodeA';
            elseif isequal(point1,LineEndpointA)
                msg1='fromNodeAtoNodeB';
            end
        end
    elseif dis1>dis2
        %加入信息，即图元node2与端点point1其相连
        %msg='图元node2与端点point1其相连';
        if isequal(msg,'fromBtoA')
            if isequal(point2,LineEndpointB)
                msg1='fromNodeBtoNodeA';
            elseif isequal(point2,LineEndpointA)
                msg1='fromNodeAtoNodeB';
            end
        elseif isequal(msg,'fromAtoB')
            if isequal(point2,LineEndpointB)
                msg1='fromNodeAtoNodeB';
            elseif isequal(point2,LineEndpointA)
                msg1='fromNodeBtoNodeA';
            end
        end
    end
end


if (strcmp(node1.type,'primitive')&strcmp(node2.type,'jointpoint')) | (strcmp(node1.type,'jointpoint')&strcmp(node2.type,'primitive')) %两个节点中一个是图元，一个是分支点
    if strcmp(node1.type,'primitive')         %node1是
        se1=strel('disk',6);                  %先膨胀后，细化可去毛刺
        node1Image=imdilate(node1Image,se1);
        lineImage=imdilate(lineImage,se1);
        all=or(node1Image,line);
        [A,node1Image]=zhang(~node1Image);
        [A,line]=zhang(~line);
        [A,all]=zhang(~all);
        line=~line;
        all=~all;
        jointpoints1=findjointpoints(all);
        endpoints=findAllendPoints(line);
        point1=endpoints{1};
        point2=endpoints{2};
        point3=jointpoints1{1};
        dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);  
        dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);  %图元连接点与两个端点的距离
    else
        se1=strel('disk',6);                  %先膨胀后，细化可去毛刺
        node2Image=imdilate(node2Image,se1);
        lineImage=imdilate(lineImage,se1);
        all=or(node2Image,line);
        [A,node2Image]=zhang(~node2Image);
        [A,line]=zhang(~line);
        [A,all]=zhang(~all);
        line=~line;
        all=~all;
        jointpoints1=findjointpoints(all);
        endpoints=findAllendPoints(line);
        point1=endpoints{1};
        point2=endpoints{2};
        point3=jointpoints1{1};
        dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);  
        dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);  %图元连接点与两个端点的距离
    end
end

if isequal(node1.type,'jointpoint')&isequal(node2.type,'jointpoint')  %两个节点都是虚拟节点的情况
    se1=strel('disk',6);                  %先膨胀后，细化可去毛刺
    node1centroid=node1.centroid;
    lineImage=imdilate(lineImage,se1);
    [A,line]=zhang(~line);
    line=~line;
    endpoints=findAllendPoints(line);
    point1=endpoints{1};
    point2=endpoints{2};
    dis1=sqrt((point1(1,1)-node1centroid(1,1))^2+(point1(1,2)-node1centroid(1,2))^2);  
    dis2=sqrt((point2(1,1)-node1centroid(1,1))^2+(point2(1,2)-node1centroid(1,2))^2);  %图元连接点与两个端点的距离
end
