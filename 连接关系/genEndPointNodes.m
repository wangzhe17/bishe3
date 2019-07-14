function endPointNodesGraphic=genEndPointNodes(thinGraphic,allEndPoints,Graphiclinewidth)
[w,h]=size(thinGraphic);
C=zeros(w,h);
for k=1:length(allEndPoints)
    endpoint=allEndPoints{k};
    y=endpoint(1,1);
    x=endpoint(1,2);
    radius=round(1.5*Graphiclinewidth);   %设置扫描的矩形宽度阈值
    C(x-radius:x+radius,y-radius:y+radius)=1;
end
endPointNodesGraphic=C;