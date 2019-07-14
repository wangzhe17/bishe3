function relations=genRelations(allNodeInfo,everySeperateLines)
cc=1;
relations=[];
allNodeInfoT=allNodeInfo;
everySeperateLinesT=everySeperateLines;
for i=1:length(allNodeInfoT)
    A=allNodeInfo{i};
    if isempty(A)
        continue;
    end
    a=A.image;
    for j=1:length(allNodeInfoT)
        if i==j
            continue;
        end
        B=allNodeInfo{j};
        if isempty(B)
            continue;
        end
        b=B.image;
        t=or(a,b);
        for k=1:length(everySeperateLinesT)
            line=everySeperateLinesT{k};
            if isempty(line)
                continue;
            end
            T=or(t,line);
            [~,num]=bwlabel(T);
            if num==1
                field1='idA';value1=A.nodeId;
                field2='idB';value2=B.nodeId;
                field3='idline';value3=k;
                s=struct(field1,value1,field2,value2,field3,value3);
                relations{cc}=s;
                cc=cc+1;
            end
        end
    end
    allNodeInfo{i}=[];
end
