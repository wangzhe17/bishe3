clc;
clear;
tic;
I=imread('201.png');
%%Ԥ����
BW=preprocessing(I);  
%%ͼ�ķ���
graphic=textseparate(BW);  
%%ϸ��
thinGraphic1=thin(graphic);
thinGraphic=thinner(thinGraphic1);                   %��������ͼ����ϸ��
thinGraphic=~thinGraphic;
% figure,imshow(thinGraphic);
%%�˵���
allEndPoints=findAllendPoints(thinGraphic);   %�˵��⺯��
%%��ͼ�����߿����
Graphiclinewidth=calculateGraphiclinewidth(graphic,thinGraphic);
%%������Ĥ�˵�ڵ��
endPointNodesGraphic=genEndPointNodes(thinGraphic,allEndPoints,Graphiclinewidth);
%%���������
innercontour = inner_Contour(graphic);
%%�ҵ����к�ѡͼԪ
[candidateContours,num]=findallcontours(innercontour); 
%%�ҵ�����ͼԪ
realcontours=findallrealcontours(candidateContours);
%%���������߲�
linesgraphic = findallLines(graphic,realcontours);  
% figure,imshow(linesgraphic);
%%����ͼԪ�ڵ��
primitives=xor(graphic,linesgraphic);
%%����ͼԪ�ڵ���
allprimitives=findAllprimitives(primitives);
%%����������
everylines=seperateLines(linesgraphic);
%%�ҵ����з�֧����������Լ���Ӧ���id������֧��Ͽ�
[seperateLinesGraphics,ids,allJointpoints,linewidth]=LinesFromJointpointLines(everylines);
%%�����ɶϿ���֧���������߲�
allSeperateLinesGraphics=findAllSeperateLines(everylines,seperateLinesGraphics,ids); 
% figure,imshow(allSeperateLinesGraphics);
%%��֧����Ϊ�ڵ㴦�����ɷ�֧���
jointpointsNodes=genJointpointsNodes(thinGraphic,allJointpoints,linewidth);
%%�Է�֧��ֱ���б��
allJointpointsNodes=findAllJointpointsNodes(jointpointsNodes);
%%�Զ˵�ֱ���б��
allEndpointsNodes=findAllEndpointsNodes(endPointNodesGraphic);
%%���µ������߲���б�ǣ���ȡ����������
everySeperateLines=seperateAllEveryLines(allSeperateLinesGraphics);
%%��ͷ�֧���Լ��˵������ͼԪ���ɽڵ�
nodes=or(primitives,jointpointsNodes);
%%��ͷ�֧���Լ��˵������ͼԪ���ɽڵ�
allNodes1=or(nodes,endPointNodesGraphic);
%%�����нڵ���б��
allNodes=findAllNodes(allNodes1);
%%�����нڵ���нṹ����
allNodeInfo=genAllNodeInfo(allNodes,allprimitives,allJointpointsNodes,allEndpointsNodes);
%%�ҵ�ÿһ�������ߵĹǼܵ㣬���عǼܵ�ɨ��õ�ÿһROI�����ص�ĺ�,�������еĹǼ���
[everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth);
%%���Ƽ�ͷ��������
[allArrowPoints]=findAllArrowPoints(everySkeletonPoints,everySkeletonSumAll); 
%%���йǼܷ�֧�����
AllSkeletonLines=combineAllSkeletonLines(everySkeletonLines);   
%%��ȡ���м�ͷ���ͷ�Ǽ���
[allArrowImages,allArrowSkeletonImages]=findAllArrowImages(allArrowPoints,linesgraphic,linewidth,AllSkeletonLines); 
%���������ߵĽṹ����
allLineInfo=genAllLineInfo(everySeperateLines,allArrowPoints,allArrowImages,everySkeletonLines);
%%����ͼģ��
relations=genRelations1(allNodeInfo,allLineInfo);
%%����ͼģ��
% relations=genRelations(allNodeInfo,everySeperateLines);
toc;
alll=or(allNodes1,allSeperateLinesGraphics);
figure,imshow(alll);
% filename='191.mat';
% save(['C:\Users\dell\Desktop\����ϵͳ��ͼ\���ӹ�ϵ\',filename]);