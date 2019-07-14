function points=findSkletonPoints(s,endpoint)
[m,n]=size(s);
tmp=zeros(m,n);
label=1;
queue_tail=1;
queue_head=1;
neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %�͵�ǰ����������ӵõ��˸���������
i=endpoint(1,2);
j=endpoint(1,1);
q=[];
if s(i,j)==1 && tmp(i,j) ==0           
    tmp(i,j)=label;
    q{queue_tail}=[i j];        %��Ԫ��ģ����У���ǰ��������
    queue_tail=queue_tail+1;
    while queue_head~=queue_tail
        pix=q{queue_head};                
        for k=1:8               %8��������
            pix1=pix+neighbour(k,:);
               if pix1(1)>=2 && pix1(1)<=m-1 && pix1(2) >=2 &&pix1(2)<=n-1
                  if s(pix1(1),pix1(2)) == 1 && tmp(pix1(1),pix1(2)) ==0  %�����ǰ������������Ϊ1���ұ��ͼ��������������û�б���ǣ���ô���
                        tmp(pix1(1),pix1(2))=label;
                        q{queue_tail}=[pix1(1) pix1(2)];
                        queue_tail=queue_tail+1;
                  end  
              end              
        end
        queue_head=queue_head+1;
    end         
end
points=q;