function graphic = textseparate(BW)
[L,num]=bwlabel(BW,8); %��������ͨ����б��
for i=1:num
    [r,c]=find(L==i);  %�ҵ�ÿһ����ͨ��
    for x=1:size(r)
        COPY(r(x,1),c(x,1))=1; %������ȡÿһ����ͨ��
    end
    sumi=sum(COPY(:));  %ÿһ����ͨ������
    sums(i,1)=sumi;    %ÿһ����ͨ������
end
maxs=max(sums);  %������ͨ��������ֵ
u=round(0.05*maxs);  %ϵ��ȡ0.05,С�����ֵ0.05ɾ��
graphic=bwareaopen(BW,u,8);  %��ȥ�ַ�