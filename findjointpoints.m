function jointpoints=findjointpoints(AM)
jointpoints=[];
[m,n]=size(AM);
k=1;
for i=2:m-2
    for j=2:n-2
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==4
            BB=AM(i-1:i+1,j-1:j+1);
            if BB(1,2)==1&&BB(2,1)==1&&BB(2,2)==1&&BB(2,3)==1 || ...
               BB(1,2)==1&&BB(2,2)==1&&BB(2,3)==1&&BB(3,2)==1 || ...
               BB(2,1)==1&&BB(2,2)==1&&BB(2,3)==1&&BB(3,2)==1 || ...
               BB(1,2)==1&&BB(2,1)==1&&BB(2,2)==1&&BB(3,2)==1 
               
                    jointpoint(1,1)=j;
                    jointpoint(1,2)=i;
                    jointpoints{k}=jointpoint;
                    k=k+1;
            end
        end
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==4
            BB=AM(i-1:i+1,j-1:j+1);
            if BB(1,1)==1&&BB(1,3)==1&&BB(2,2)==1&&BB(3,2)==1
                jointpoint(1,1)=j;
                jointpoint(1,2)=i;
                jointpoints{k}=jointpoint;
                k=k+1;
            end
        end
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==4
            BB=AM(i-1:i+1,j-1:j+1);
            if BB(1,3)==1&&BB(2,1)==1&&BB(2,2)==1&&BB(3,2)==1
                jointpoint(1,1)=j;
                jointpoint(1,2)=i;
                jointpoints{k}=jointpoint;
                k=k+1;
            end
        end
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==4
            BB=AM(i-1:i+1,j-1:j+1);
            if BB(1,2)==1&&BB(2,2)==1&&BB(2,3)==1&&BB(3,1)==1
                jointpoint(1,1)=j;
                jointpoint(1,2)=i;
                jointpoints{k}=jointpoint;
                k=k+1;
            end
        end
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==4
            BB=AM(i-1:i+1,j-1:j+1);
            if BB(1,1)==1&&BB(2,2)==1&&BB(2,3)==1&&BB(3,2)==1
                jointpoint(1,1)=j;
                jointpoint(1,2)=i;
                jointpoints{k}=jointpoint;
                k=k+1;
            end
        end
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==4
            BB=AM(i-1:i+1,j-1:j+1);
            if BB(1,2)==1&&BB(2,2)==1&&BB(3,1)==1&&BB(3,3)==1
                jointpoint(1,1)=j;
                jointpoint(1,2)=i;
                jointpoints{k}=jointpoint;
                k=k+1;
            end
        end
        if AM(i,j)==1&&sum(sum(AM(i-1:i+1,j-1:j+1)))==5
            CC=AM(i-1:i+1,j-1:j+1);
            if CC(1,2)==1&&CC(2,1)==1&&CC(2,2)==1&&CC(2,3)==1&&CC(3,2)==1
                    jointpoint(1,1)=j;
                    jointpoint(1,2)=i;
                    jointpoints{k}=jointpoint;
                    k=k+1;
            end
        end
    end
end