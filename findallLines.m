function lines = findallLines(graphic,realcontours)
[h,w]=size(graphic);
C=zeros(h,w);
for i=1:length(realcontours)
    B=imfill(realcontours{i},'holes');
    [r,c]=find(B==1);
    for x=1:size(r)
        C(r(x,1),c(x,1))=1;
    end
end
se=strel('disk',5);
C=imdilate(C,se);
[r,c]=find(C==1);
t=graphic;
for x=1:size(r)
    t(r(x,1),c(x,1))=0;
end
t = bwareaopen(t,50,8);
lines=t;