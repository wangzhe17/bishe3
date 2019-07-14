clc;
clear;
load 191.mat;
line=allLineInfo{3};
lineImage=line.lineImage;

skeletonLine=everySkeletonLines{3}; %�Ǽ���
ArrowPoint=line.arrowZuobiao;  %��ͷλ������
x=ArrowPoint(1,2)-2*linewidth; 
y=ArrowPoint(1,1)-2*linewidth;
xx=ArrowPoint(1,1);
yy=ArrowPoint(1,2);
skeletonLine1=skeletonLine;
skeletonLine1(xx-linewidth:xx+linewidth,yy-linewidth:yy+linewidth)=0;
A=xor(skeletonLine,skeletonLine1);%��ȡ���߶Σ������ж�����
figure,imshow(skeletonLine);
endpoints=findAllendPoints(A); %��ȡ�߶εĶ˵�
pointA=endpoints{1};           %�˵�A
x1=pointA(1,1);
y1=pointA(1,2);
pointB=endpoints{2};%�˵�B
x2=pointB(1,1);
y2=pointB(1,2);
direct=line.arrowDirect;
if direct=='up'   
    d=y1-y2;
    if d>0  %d>0˵��y1��y2���棬�����y1ָ��y2��
        startPoint=pointA;
        endPoint=pointB;
    end
    if d<0 %d<0˵��y1��y2���棬�����y2ָ��y1��
        startPoint=pointB;
        endPoint=pointA;
    end
end
figure,imshow(skeletonLine);
hold on;
%%tt���������ĵ�һ����ֹ�˵㣬skeletonLineEndpoint�ǸùǼ��ߵ�ĳһ�˵�
[tt,skeletonLineEndpoint]=findStartOrEndPoint(skeletonLine,pointA,pointB);

% [m,n]=size(skeletonLine);
% tmp=zeros(m,n);
% label=1;
% queue_tail=1;
% queue_head=1;
% neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %�͵�ǰ����������ӵõ��˸���������
% endpointsT=findAllendPoints(skeletonLine);
% endpoint=endpointsT{1};
% i=endpoint(1,2);
% j=endpoint(1,1);
% q=[];
% if skeletonLine(i,j)==1 && tmp(i,j) ==0
%     tmp(i,j)=label;
%     q{queue_tail}=[i j];
%     queue_tail=queue_tail+1;
%     while queue_head~=queue_tail
%         pix=q{queue_head};
%         aa=pix(1,2);
%         bb=pix(1,1);
%         pixT=[aa,bb];
%         plot(aa,bb,'+');
%         if isequal(pixT,pointA)||isequal(pixT,pointB)
%             tt=pixT;
%             break;
%         end
%         for k=1:8               %8��������
%             pix1=pix+neighbour(k,:);
%             if pix1(1)>=2 && pix1(1)<=m-1 && pix1(2) >=2 &&pix1(2)<=n-1
%                 if skeletonLine(pix1(1),pix1(2)) == 1 && tmp(pix1(1),pix1(2)) ==0  %�����ǰ������������Ϊ1���ұ��ͼ��������������û�б���ǣ���ô���
%                     tmp(pix1(1),pix1(2))=label;
%                     q{queue_tail}=[pix1(1) pix1(2)];
%                     queue_tail=queue_tail+1;
%                 end
%             end
%         end
%         queue_head=queue_head+1;
%     end
% end
% rectangle('Position',[x,y,4.5*linewidth,4.5*linewidth],'EdgeColor','r','LineWidth',3);
