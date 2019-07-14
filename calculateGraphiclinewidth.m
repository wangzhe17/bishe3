function flowchartGraphiclinewidth=calculateGraphiclinewidth(graphic,flowchartThin)

contour=bwperim(graphic);
se=strel('disk',1);
[rflowchartThin,cflowchartThin]=find(flowchartThin==1);
[rContour,cContour]=find(contour==1);
xflowchartThin=cflowchartThin(1,1);
yflowchartThin=rflowchartThin(1,1);
xCountour=cContour(1,1);
yCountour=rContour(1,1);
dis=sqrt((xflowchartThin-xCountour)^2+(yflowchartThin-yCountour)^2);
for i=1:length(rflowchartThin)
    xflowchartThin=cflowchartThin(i,1);
    yflowchartThin=rflowchartThin(i,1);
    for j=1:length(rContour)
        xCountour=cContour(j,1);
        yCountour=rContour(j,1);
        dis(j,1)=sqrt((xflowchartThin-xCountour)^2+(yflowchartThin-yCountour)^2);
    end
    mindis=min(min(dis));                             %求得每一个骨架线到边缘的最短距离mindis
    mindisAll(i,1)=mindis;
end
linewidth=2*mean2(mindisAll);                         %线宽估计值为2*linewidth
flowchartGraphiclinewidth=linewidth;