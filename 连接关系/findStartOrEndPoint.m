function [tt,endpoint]=findStartOrEndPoint(skeletonLine,pointA,pointB)

[m,n]=size(skeletonLine);
tmp=zeros(m,n);
label=1;
queue_tail=1;
queue_head=1;
neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %和当前像素坐标相加得到八个邻域坐标
endpointsT=findAllendPoints(skeletonLine);
endpoint=endpointsT{1};
i=endpoint(1,2);
j=endpoint(1,1);
q=[];
if skeletonLine(i,j)==1 && tmp(i,j) ==0
    tmp(i,j)=label;
    q{queue_tail}=[i j];
    queue_tail=queue_tail+1;
    while queue_head~=queue_tail
        pix=q{queue_head};
        aa=pix(1,2);
        bb=pix(1,1);
        pixT=[aa,bb];
%         plot(aa,bb,'+');    %画出搜索的路径
        if isequal(pixT,pointA)||isequal(pixT,pointB)
            tt=pixT;
            break;
        end
        for k=1:8               %8邻域搜索
            pix1=pix+neighbour(k,:);
            if pix1(1)>=2 && pix1(1)<=m-1 && pix1(2) >=2 &&pix1(2)<=n-1
                if skeletonLine(pix1(1),pix1(2)) == 1 && tmp(pix1(1),pix1(2)) ==0  %如果当前像素邻域像素为1并且标记图像的这个邻域像素没有被标记，那么标记
                    tmp(pix1(1),pix1(2))=label;
                    q{queue_tail}=[pix1(1) pix1(2)];
                    queue_tail=queue_tail+1;
                end
            end
        end
        queue_head=queue_head+1;
    end
end