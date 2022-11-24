function finalImage =similarityCalculator (image)

[rows, columns] = size(image);
for j=40:5:rows
    for k=100:5:columns
        currentWindow = image(j-39:j,k-99:k);
        windowDescriptor = testGabor_mean(currentWindow);
        % carDissimilarity=compare(windowDescriptor,negImageDescriptor);
        posImageMean = dlmread('CarData\posImageMean.txt');
        negImageMean = dlmread('CarData\negImageMean.txt');
        
        similarity = ( sum(((posImageMean) -cell2mat(windowDescriptor)).^2).^0.5);
        disSimilarity = ( sum(((negImageMean) -cell2mat(windowDescriptor)).^2).^0.5);
        imageSimilarityArray{(j/5)-7,(k/5)-19}= disSimilarity./similarity;
    end
end
%findMaxWindow(imageSimilarityArray,image);
finalImage=findMaxWindow(imageSimilarityArray,image);

end