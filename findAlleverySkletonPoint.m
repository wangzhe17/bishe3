function [everySkeletonPoints,everySkeletonSumAll,everySkeletonLines]=findAlleverySkletonPoint(everySeperateLines,linewidth)

everySkeletonPoints=[];
everySkeletonSumAll=[];
everySkeletonLines=[];
for l=1:length(everySeperateLines)
    points=[];
    sumAll=[];
    A=everySeperateLines{l};
%     figure,imshow(A);
%     hold on;
    se1=strel('disk',10);
    se2=strel('disk',5);
    A1=imdilate(A,se1);
    [aa,AM]=zhang(~A1);
    AM=imerode(AM,se2);
    [aa,AM]=zhang(AM);
    AM=~AM;
    AA=thinner(AM);
    everySkeletonLines{l}=AA;
    [m,n]=size(AM);
    k=1;
    for i=2:m-1
        for j=2:n-1
            if sum(sum(AA(i-1:i+1,j-1:j+1)))==2 && AA(i,j)==1        %检测端点
                endpoints{k}=[j,i];
                k=k+1;
            end
        end
    end
    endpoint=endpoints{1};
    tpoints=findSkletonPoints(AA,endpoint);    %沿8邻域进行遍历，生成骨架线序列
%     everySkeletonPoints{l}=tpoints;
    for i=1:length(tpoints)
        pp=tpoints{i};
        points(i,1)=pp(1,1);
        points(i,2)=pp(1,2);
    end
    everySkeletonPoints{l}=tpoints;
    yi=points(:,1);
    xi=points(:,2);
    se1=strel('disk',1);
%     A=imerode(A,se1);
    radius=round(1.1*linewidth);   %设置扫描的矩形宽度阈值
    [w,h]=size(AM);
    for k=1:length(xi)
    x1=xi(k,1);
    y1=yi(k,1);
    [xx,yy] = ndgrid((1:w)-y1,(1:h)-x1);
    mask = (xx.^2 + yy.^2)<radius^2;
    [a,b]=find(mask);
    B=A;
        for i = 1:length(a)
            for j = 1:length(b)
                x=a(i,1);
                y=b(j,1);
                B(x,y)=0;
            end
        end
    roiC=xor(B,A);
    sumTmp=sum(sum(roiC));
    sumAll(k,1)=sumTmp;  %取得骨架线序列所有的
    end
    temp=sumAll;
    
    everySkeletonSumAll{l}=sumAll;
%     figure,plot(temp);
%     hold on;
end