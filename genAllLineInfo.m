function allLineInfo=genAllLineInfo(everySeperateLines,allArrowPoints,allArrowImages,everySkeletonLines)
allLineInfo=[];
load arrowmodel.mat;
k=1;
for i=1:length(everySeperateLines)
    line=everySeperateLines{i};
    SkeletonLine=everySkeletonLines{i};
    field1='lineId';value1=k;
    field2='lineImage';value2=line;
    field3='isArrow';
    arrowI=allArrowImages{i};
    if isempty(arrowI)
        value3='no';
    else
        value3='yes';
    end
    field4='arrowDirect';
    if isempty(arrowI)
        value4='';
    end
    if ~isempty(arrowI)
        arrow=imresize(arrowI,[35,35]);
        arrow=uint8(arrow);
        D=classify(net,arrow);
        if D=='U'
            value4='up';
        elseif D=='D'
            value4='down';
        elseif D=='L'
            value4='left';
        elseif D=='R'
            value4='right';
        end
    end
    field5='arrowZuobiao';
    if isempty(allArrowPoints{i})
        value5=[];
    elseif ~isempty(allArrowPoints{i})
        value5=allArrowPoints{i};
    end
    field6='SkeletonLine';value6=SkeletonLine;
    sLine=struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6);
    allLineInfo{k}=sLine;
    k=k+1;
end