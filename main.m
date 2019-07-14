clc;
clear;
tic;
I=imread('201.png');
%%预处理
BW=preprocessing(I);  
%%图文分离
graphic=textseparate(BW);  
%%细化
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);                   %对整个框图进行细化
thinGraphic=~thinGraphic;
% figure,imshow(thinGraphic);
%%端点检测
allEndPoints=findAllendPoints(thinGraphic);   %端点检测函数
%%框图整体线宽估计
Graphiclinewidth=calculateGraphiclinewidth(graphic,thinGraphic);
%%利用掩膜端点节点层
endPointNodesGraphic=genEndPointNodes(thinGraphic,allEndPoints,Graphiclinewidth);
%%获得内轮廓
innercontour = inner_Contour(graphic);
%%找到所有候选图元
[candidateContours,num]=findallcontours(innercontour); 
%%找到所有图元
realcontours=findallrealcontours(candidateContours);
%%生成连接线层
linesgraphic = findallLines(graphic,realcontours);  
% figure,imshow(linesgraphic);
%%生成图元节点层
primitives=xor(graphic,linesgraphic);
%%所有图元节点标记
allprimitives=findAllprimitives(primitives);
%%单个连接线
everylines=seperateLines(linesgraphic);
%%找到含有分支点的连接线以及对应编号id，将分支点断开
[seperateLinesGraphics,ids,allJointpoints,linewidth]=LinesFromJointpointLines(everylines);
%%生产成断开分支点后的连接线层
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids); 
% figure,imshow(allSeperateLinesGraphics);
%%分支点作为节点处理，生成分支点层
jointpointsNodes=genJointpointsNodes(thinGraphic,allJointpoints,linewidth);
%%对分支点分别进行标记
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
%%对端点分别进行标记
allEndpointsNodes=findAllEndpointsNodes(endPointNodesGraphic);
%%对新的连接线层进行标记，提取单个连接线
everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);
%%组和分支点以及端点与基本图元构成节点
nodes=or(primitives,jointpointsNodes);
%%组和分支点以及端点与基本图元构成节点
allNodes1=or(nodes,endPointNodesGraphic);
%%对所有节点进行标记
allNodes=findAllNodes(allNodes1);
%%对所有节点进行结构生成
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes,allEndpointsNodes);
%%找到每一条连接线的骨架点，并沿骨架点扫描得到每一ROI内像素点的和,保存所有的骨架线
[everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth);
%%估计箭头所在坐标
[allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll); 
%%所有骨架分支的组合
AllSkeletonLines=combineAllSkeletonLines(everySkeletonLines);   
%%提取所有箭头与箭头骨架线
[allArrowImages,allArrowSkeletonImages]=findAllArrowImages(allArrowPoints,linesgraphic,linewidth,AllSkeletonLines); 
%所有连接线的结构生成
allLineInfo=genAllLineInfo(everySeperateLines,allArrowPoints,allArrowImages,everySkeletonLines);
%%无向图模型
relations=genRelations1(allNodeInfo,allLineInfo);
%%无向图模型
% relations=genRelations(allNodeInfo,everySeperateLines);
toc;
alll=or(allNodes1,allSeperateLinesGraphics);
figure,imshow(alll);
% filename='191.mat';
% save(['C:\Users\dell\Desktop\毕设系统框图\连接关系\',filename]);