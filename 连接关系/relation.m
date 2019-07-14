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

se1=strel('disk',6);                  %�����ͺ�ϸ����ȥë��
node1Image=imdilate(node1Image,se1);
node2Image=imdilate(node2Image,se1);
lineImage=imdilate(lineImage,se1);
all=or(node1Image,lineImage);         %node1��line�������������
[A,node1Image]=zhang(~node1Image);    %�ֱ�ϸ��
[A,node2Image]=zhang(~node2Image);
% [A,lineImage]=zhang(~lineImage);
[A,all]=zhang(~all);    %ƴ�Ӻ��ϸ��
node1Image=~node1Image;
node2Image=~node2Image;
% lineImage=~lineImage;
all=~all;
% figure,imshow(line);
jointpoints1=findjointpoints(all); %����node1��line�Ľ����
endpoints=findAllendPoints(skeletonLine);  %����line�������˵�

point1=endpoints{1};  %�����ߵ�1���˵�point1
point2=endpoints{2};  %�����ߵ���һ���˵�point2
point3=jointpoints1{1};%��������node1�Ľ���
dis1=sqrt((point1(1,1)-point3(1,1))^2+(point1(1,2)-point3(1,2))^2);
dis2=sqrt((point2(1,1)-point3(1,1))^2+(point2(1,2)-point3(1,2))^2);

[tt,skeletonLineEndpoint,startPoint,LineEndpointA,LineEndpointB,endPoint,msg]=genPointDirect(line,linewidth);%����������Ϣ

if dis1<dis2 %��dis1��dis2С ��point1�뽻��point3���������˵�point1���֧��������˵�point1��ͼԪnode1����
    %������Ϣ����ͼԪnode1��˵�point1������
    %msg='ͼԪnode1��˵�point1������';
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
    %������Ϣ����ͼԪnode2��˵�point1������
    %msg='ͼԪnode2��˵�point1������';
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