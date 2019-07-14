function [tt,skeletonLineEndpoint,startPoint,LineEndpointA,LineEndpointB,endPoint,msg]=genPointDirect(line,linewidth)
lineImage=line.lineImage;
skeletonLine=line.SkeletonLine;
ArrowPoint=line.arrowZuobiao;       %��ͷλ������
x=ArrowPoint(1,2)-2*linewidth; 
y=ArrowPoint(1,1)-2*linewidth;
xx=ArrowPoint(1,1);
yy=ArrowPoint(1,2);
skeletonLine1=skeletonLine;
skeletonLine1(xx-linewidth:xx+linewidth,yy-linewidth:yy+linewidth)=0;
A=xor(skeletonLine,skeletonLine1);%A�ǽ�ȡ���߶Σ������ж�����
endpoints=findAllendPoints(A); %��ȡ�߶εĶ˵�
pointA=endpoints{1};           %�˵�A
xA=pointA(1,1);
yA=pointA(1,2);
pointB=endpoints{2};%�˵�B
xB=pointB(1,1);
yB=pointB(1,2);
direct=line.arrowDirect;
if isequal(direct,'up')
    d=yA-yB;
    if d>0  %d>0˵��y1��y2���棬�����y1ָ��y2��
        startPoint=pointA;
        endPoint=pointB;
    end
    if d<0 %d<0˵��y1��y2���棬�����y2ָ��y1��
        startPoint=pointB;
        endPoint=pointA;
    end
elseif isequal(direct,'down')
    d=yA-yB;
    if d>0  %d>0˵��y1��y2���棬�����y2ָ��y1��
        startPoint=pointB;
        endPoint=pointA;
    end
    if d<0 %d<0˵��y1��y2���棬�����y1ָ��y2��
        startPoint=pointA;
        endPoint=pointB;
    end
elseif isequal(direct,'right')
    d=xA-xB;
    if d>0  %d>0˵��A��B���棬�����Bָ��A��
        startPoint=pointB;
        endPoint=pointA;
    end
    if d<0 %d<0˵��A��B���棬�����Aָ��B��
        startPoint=pointA;
        endPoint=pointB;
    end
elseif isequal(direct,'left')
    d=xA-xB;
    if d>0  %d>0˵��A��B���棬�����Aָ��B��
        startPoint=pointA;
        endPoint=pointB;
    end
    if d<0 %d<0˵��A��B���棬�����Bָ��A��
        startPoint=pointB;
        endPoint=pointA;
    end
end
LineEndpoints=findAllendPoints(skeletonLine);
LineEndpointA=LineEndpoints{1};
LineEndpointB=LineEndpoints{2};
[tt,skeletonLineEndpoint]=findStartOrEndPoint(skeletonLine,pointA,pointB); %ttΪ�������ĵ�һ����ֹ�ڵ�
if isequal(skeletonLineEndpoint,LineEndpointA)&&isequal(tt,startPoint)
    msg='fromAtoB';
elseif isequal(skeletonLineEndpoint,LineEndpointB)&&isequal(tt,startPoint)
    msg='fromBtoA';
elseif isequal(skeletonLineEndpoint,LineEndpointA)&&isequal(tt,endPoint)
    msg='fromBtoA';
elseif isequal(skeletonLineEndpoint,LineEndpointB)&&isequal(tt,endPoint)
    msg='fromAtoB';
end
