function program()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
Gabor_Mean();
testImages = dir(fullfile('C:\Users\mahtab\Desktop\Subject\Binayi\CarData\TestImages','*.pgm'));
for i=1:size(testImages)
    image = imread(fullfile(testImages(i).folder,testImages(i).name));
    imageSimilarityArray2{i} = {similarityCalculator(image)};
    imwrite(imageSimilarityArray2{1,i}{1,1},sprintf('FinalImages/%d.jpg',i));
end
end