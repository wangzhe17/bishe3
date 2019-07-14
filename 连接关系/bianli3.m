clc;
clear;
load 191.mat;
line=allLineInfo{5};
[tt,skeletonLineEndpoint,startPoint,LineEndpointA,LineEndpointB,endPoint,msg]=genPointDirect(line,linewidth);