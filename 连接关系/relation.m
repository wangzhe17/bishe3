clc;
clear;
load 191.mat;
relation1=relations{2};
for i=1:length(allNodeInfo)
    idA=relation1.idA;
    if i~=idA
        continue;
    end
    if i==idA
        node1=allNodeInfo{idA};
    end
    node1Image=node1.image;
end
for i=1:length(allNodeInfo)
    idB=relation1.idB;
    if i~=idB
        continue;
    end
    if i==idB
        node2=allNodeInfo{idB};
    end
    node2Image=node2.image;
end
for i=1:length(allLineInfo)
    idline=relation1.idline;
    if i~=idline
        continue;
    end
    if idline==i
        line=allLineInfo{i};
        lineImage=line.lineImage;
    end
end

skeletonLine=line.SkeletonLine;

se1=strel('disk',6);                  %先膨胀后，细化可去毛刺
node1Image=imdilate(node1Image,se1);
node2Image=imdilate(node2Image,se1);
lineImage=imdilate(lineImage,se1);
all=or(node1Image,lineImage);         %node1和line相连，看交叉点
[A,node1Image]=zhang(~node1Image);    %分别细化
[A,node2Image]=zhang(~node2Image);
% [A,lineImage]=zhang(~lineImage);
[A,all]=zhang(~all);    %拼接后的细化
node1Image=~node1Image;
node2Image=~node2Image;
% lineImage=~lineImage;
all=~all;
% figure,imshow(line);
jointpoints1=findjointpoints(all); %搜索node1和line的交叉点
endpoints=findAllendPoints(skeletonLine);  %搜索line的两个端点

point1=endpoints{1};  %连接线的1个端点point1
point2=endpoints{2};  %连接线的另一个端点point2
point3=jointpoints1{1};%连接线与node1的交点
dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);
dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);

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