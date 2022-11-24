function image1=findMaxWindow( imageSimilarityArray,image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
max1 = max(cell2mat(imageSimilarityArray(:)));
[row column]=find(cell2mat(imageSimilarityArray)==max1);

image1 = insertShape(image,'Rectangle',[(column*5)-4 (row*5)-4 100 40],'Color',{'red'},'Opacity',0.7);

end