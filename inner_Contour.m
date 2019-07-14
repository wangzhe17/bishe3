function innerCountour=inner_Contour(graphic)

se=strel('disk',1); 
graphic=imdilate(graphic,se);
graphic=imerode(graphic,se);
graphic=imdilate(graphic,se);
im=graphic;
im2=imfill(im,'holes');
outerCountour = bwperim(im2); 
Countour = bwperim(graphic); 
innerCountour=xor(outerCountour,Countour);
innerCountour = bwareaopen(innerCountour,20,8);