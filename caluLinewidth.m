function linewidth=caluLinewidth(A,AM)
se=strel('disk',1);
A=imdilate(A,se);
contour = bwperim(A);
[rAM,cAM]=find(AM==1);
[rContour,cContour]=find(contour==1);
xAM=cAM(1,1);
yAM=rAM(1,1);
xCountour=cContour(1,1);
yCountour=rContour(1,1);
dis=sqrt((xAM-xCountour)^2+(yAM-yCountour)^2);
for i=1:length(rAM)
    xAM=cAM(i,1);
    yAM=rAM(i,1);
    for j=1:length(rContour)
        xCountour=cContour(j,1);
        yCountour=rContour(j,1);
        dis(j,1)=sqrt((xAM-xCountour)^2+(yAM-yCountour)^2);
    end
    mindis=min(min(dis));
    mindisAll(i,1)=mindis;
end
linewidth=2*mean2(mindisAll);