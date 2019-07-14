function allEndPoints=findAllendPoints(thinGraphic) %找到所有端点
allEndPoints=[];
[m,n]=size(thinGraphic);                     %以8邻域为中心只有2个像素
k=1;
for i=2:m-2
    for j=2:n-2
        if thinGraphic(i,j)==1&&sum(sum(thinGraphic(i-1:i+1,j-1:j+1)))==2
            endpoint(1,1)=j;
            endpoint(1,2)=i;
            allEndPoints{k}=endpoint;
            k=k+1;
        end
    end
end