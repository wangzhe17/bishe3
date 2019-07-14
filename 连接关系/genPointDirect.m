function [tt,skeletonLineEndpoint,startPoint,LineEndpointA,LineEndpointB,endPoint,msg]=genPointDirect(line,linewidth)
lineImage=line.lineImage;
skeletonLine=line.SkeletonLine;
ArrowPoint=line.arrowZuobiao;       %箭头位置坐标
x=ArrowPoint(1,2)-2*linewidth; 
y=ArrowPoint(1,1)-2*linewidth;
xx=ArrowPoint(1,1);
yy=ArrowPoint(1,2);
skeletonLine1=skeletonLine;
skeletonLine1(xx-linewidth:xx+linewidth,yy-linewidth:yy+linewidth)=0;
A=xor(skeletonLine,skeletonLine1);%A是截取的线段，用来判定方向
endpoints=findAllendPoints(A); %截取线段的端点
pointA=endpoints{1};           %端点A
xA=pointA(1,1);
yA=pointA(1,2);
pointB=endpoints{2};%端点B
xB=pointB(1,1);
yB=pointB(1,2);
direct=line.arrowDirect;
if isequal(direct,'up')
    d=yA-yB;
    if d>0  %d>0说明y1在y2下面，方向从y1指向y2；
        startPoint=pointA;
        endPoint=pointB;
    end
    if d<0 %d<0说明y1在y2上面，方向从y2指向y1；
        startPoint=pointB;
        endPoint=pointA;
    end
elseif isequal(direct,'down')
    d=yA-yB;
    if d>0  %d>0说明y1在y2下面，方向从y2指向y1；
        startPoint=pointB;
        endPoint=pointA;
    end
    if d<0 %d<0说明y1在y2上面，方向从y1指向y2；
        startPoint=pointA;
        endPoint=pointB;
    end
elseif isequal(direct,'right')
    d=xA-xB;
    if d>0  %d>0说明A在B右面，方向从B指向A；
        startPoint=pointB;
        endPoint=pointA;
    end
    if d<0 %d<0说明A在B左面，方向从A指向B；
        startPoint=pointA;
        endPoint=pointB;
    end
elseif isequal(direct,'left')
    d=xA-xB;
    if d>0  %d>0说明A在B右面，方向从A指向B；
        startPoint=pointA;
        endPoint=pointB;
    end
    if d<0 %d<0说明A在B左面，方向从B指向A；
        startPoint=pointB;
        endPoint=pointA;
    end
end
LineEndpoints=findAllendPoints(skeletonLine);
LineEndpointA=LineEndpoints{1};
LineEndpointB=LineEndpoints{2};
[tt,skeletonLineEndpoint]=findStartOrEndPoint(skeletonLine,pointA,pointB); %tt为遍历到的第一个起止节点
if isequal(skeletonLineEndpoint,LineEndpointA)&&isequal(tt,startPoint)
    msg='fromAtoB';
elseif isequal(skeletonLineEndpoint,LineEndpointB)&&isequal(tt,startPoint)
    msg='fromBtoA';
elseif isequal(skeletonLineEndpoint,LineEndpointA)&&isequal(tt,endPoint)
    msg='fromBtoA';
elseif isequal(skeletonLineEndpoint,LineEndpointB)&&isequal(tt,endPoint)
    msg='fromAtoB';
end
