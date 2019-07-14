function [seperateLinesGraphics,ids,allJointpoints,linewidth]=LinesFromJointpointLines(everylines)
d=1;
ids=[];
allJointpoints=[];
seperateLinesGraphic=[];
ll=1;
for k=1:length(everylines)
    A=everylines{k};
    B=A;
    se1=strel('disk',10);
    se2=strel('disk',5);
    A1=imdilate(A,se1);
    [aa,AM]=zhang(~A1);
    AM=imerode(AM,se2);
    [aa,AM]=zhang(AM);
    AM=~AM;
    AA=thinner(AM);
%     figure,imshow(AA);
    [m,n]=size(AA);
    linewidth=caluLinewidth(A,AA);     %计算线宽
    jointpoints=findjointpoints(AA);   %找交叉点函数，找当前线的交叉点
    maskwidth=round(0.95*linewidth);   %设置掩膜，将连接线断开
    M=zeros(m,n);
    if ~isempty(jointpoints)
        for i=1:length(jointpoints)
            jointpoint=jointpoints{i};
            allJointpoints{ll}=jointpoint;
            ll=ll+1;
            j1=jointpoint(1,1);
            i1=jointpoint(1,2);
            M(i1-maskwidth:i1+maskwidth,j1-maskwidth:j1+maskwidth)=1;
        end
        [r,c]=find(M==1);
        for a=1:size(r)
            B(r(a,1),c(a,1))=0;
        end
        B = bwareaopen(B,20,8);
        seperateLinesGraphics{d}=B;
        ids{d}=k;
        d=d+1;
    end
end
ids=cell2mat(ids);
