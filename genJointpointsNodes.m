function jointpointsNodesGraphic=genJointpointsNodes(thinGraphic,allJointpoints,linewidth)
[w,h]=size(thinGraphic);
C=zeros(w,h);
for k=1:length(allJointpoints)
    jointpoint=allJointpoints{k};
    y=jointpoint(1,1);
    x=jointpoint(1,2);
    radius=round(1.5*linewidth);   %����ɨ��ľ��ο����ֵ
    C(x-radius:x+radius,y-radius:y+radius)=1;
end
jointpointsNodesGraphic=C;