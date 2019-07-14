function realcontours=findallrealcontours(candidateContours)
for i=1:length(candidateContours)
    pic1=candidateContours{i};
    [y,x]=find(pic1==1);
    dt = delaunayTriangulation(x,y);
    k = convexHull(dt);
    [r,c]=size(pic1);
    pic11=zeros(r,c);
    lkt = roipoly(pic11,x(k),y(k));%ÇóÍ¼°ü
    convexhulls{i}=lkt;
end
k=1;
for i=1:length(candidateContours)
    origin=imfill(candidateContours{i},'holes');
    a1=sum(origin(:));
    c=convexhulls{i};
    a2=sum(c(:));
    r=a1./a2;
    if r < 0.97
        continue;
    end
    realcontours{k}=candidateContours{i};
    k=k+1;
end