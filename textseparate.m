function graphic = textseparate(BW)
[L,num]=bwlabel(BW,8); %对所有连通域进行标记
for i=1:num
    [r,c]=find(L==i);  %找到每一个连通域
    for x=1:size(r)
        COPY(r(x,1),c(x,1))=1; %单独提取每一个连通域
    end
    sumi=sum(COPY(:));  %每一个连通域的面积
    sums(i,1)=sumi;    %每一个连通域的面积
end
maxs=max(sums);  %计算连通域面积最大值
u=round(0.05*maxs);  %系数取0.05,小于最大值0.05删除
graphic=bwareaopen(BW,u,8);  %消去字符