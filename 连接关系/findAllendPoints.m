function allEndPoints=findAllendPoints(thinGraphic)
allEndPoints=[];
[m,n]=size(thinGraphic);
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