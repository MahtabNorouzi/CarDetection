function Gabor_Mean()
negImages = dir(fullfile('CarData\TrainImages\neg','*.pgm'));
posImages = dir(fullfile('CarData\TrainImages\pos','*.pgm'));

gab = Create_Gab_Kernels([6 6 6],100);
%making the 500*180 matrix :mean of each 20*20 cell
%for negetavie images
negImageMean=zeros(1,450,'double');
for i=1:size(negImages)
    im = imread(fullfile(negImages(i).folder,negImages(i).name));
    [imRows imColumns] = size(im);
    squareTrainIm = imresize(im,[2.5.*imRows imColumns]);
    %negImagesGab= 1*500 array of each image...in each cell it has
    % 18 images (18 gab filter)
    squareNegImageGab{i} = Compute_Gabbed_Image(double(squareTrainIm), gab);
    for j=1:18
        %devide th 40*100 window into 10 20*20 window
        negImageGabCell{i,j}=mat2cell(squareNegImageGab{1,i}{1,j},[20 20 20 20 20],[20 20 20 20 20]);
        negImageGabCell{i,j}=reshape(negImageGabCell{i,j},1,25);
        for k=1:25
            negImageDescriptor(i,(j-1)*25+k)=mean(mean(negImageGabCell{i,j}{1,k}));
        end
    end
    negImageMean = negImageMean + negImageDescriptor(i,1:450);
    %negImageMean=negImageMean+negImageDescriptor{i};
end
negImageMean=negImageMean./500;

%making the 500*180 matrix :mean of each 20*20 cell
%for positive images

posImageMean=zeros(1,450,'double');
for i=1:size(posImages)
    im = imread(fullfile(posImages(i).folder,posImages(i).name));
    [imRows imColumns] = size(im);
    squareTrainIm = imresize(im,[2.5.*imRows imColumns]);
    squarePosImageGab{i} = Compute_Gabbed_Image(double(squareTrainIm), gab);
    for j=1:18
        posImageGabCell{i,j}=mat2cell(squarePosImageGab{1,i}{1,j},[20 20 20 20 20],[20 20 20 20 20]);
        posImageGabCell{i,j}=reshape(posImageGabCell{i,j},1,25);
        for k=1:25
            posImageDescriptor(i,(j-1)*25+k)=mean(mean(posImageGabCell{i,j}{1,k}));
        end
    end
    posImageMean = posImageMean + posImageDescriptor(i,1:450);
end

posImageMean=posImageMean./550;


dlmwrite('CarData\posImageMean.txt',posImageMean);
dlmwrite('CarData\negImageMean.txt',negImageMean);

end