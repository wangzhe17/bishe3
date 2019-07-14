function relations=genRelations1(allNodeInfo,allLineInfo)
cc=1;
relations=[];
allNodeInfoT=allNodeInfo;
allLineInfoT=allLineInfo;
for i=1:length(allNodeInfoT)
    A=allNodeInfo{i};
    a=A.image;
    for j=1:length(allNodeInfoT)
        if i==j
            continue;
        end
        B=allNodeInfo{j};
        b=B.image;
        t=or(a,b);
        for k=1:length(allLineInfoT)
            line=allLineInfoT{k};
            if isempty(line)
                continue;
            end
            lineImage=line.lineImage;
            T=or(t,lineImage);
            [~,num]=bwlabel(T);
            if num==1
                field1='idA';value1=A.nodeId;
                field2='idB';value2=B.nodeId;
                field3='idline';value3=line.lineId;
                s=struct(field1,value1,field2,value2,field3,value3);
                relations{cc}=s;
                cc=cc+1;
                allLineInfoT{k}=[];
            end
        end
    end
end
