negImages = dir(fullfile('C:\Users\mahtab\Desktop\Subject\Binayi\CarData\TrainImages\neg','*.pgm'));
posImages = dir(fullfile('C:\Users\mahtab\Desktop\Subject\Binayi\CarData\TrainImages\pos','*.pgm'));

gab = Create_Gab_Kernels([6 6 6],100);
%making the 500*180 matrix :mean of each 20*20 cell
%for negetavie images
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
            negImageDescriptor{i,(j-1)*25+k}=mean(mean(negImageGabCell{i,j}{1,k}));
        end
    end
end

%making the 500*180 matrix :mean of each 20*20 cell
%for positive images
for i=1:size(posImages)
    im = imread(fullfile(posImages(i).folder,posImages(i).name));
    [imRows imColumns] = size(im);
    squareTrainIm = imresize(im,[2.5.*imRows imColumns]);
    squarePosImageGab{i} = Compute_Gabbed_Image(double(squareTrainIm), gab);
    for j=1:18
        posImageGabCell{i,j}=mat2cell(squarePosImageGab{1,i}{1,j},[20 20 20 20 20],[20 20 20 20 20]);
        posImageGabCell{i,j}=reshape(posImageGabCell{i,j},1,25);
        for k=1:25
            posImageDescriptor{i,(j-1)*25+k}=mean(mean(posImageGabCell{i,j}{1,k}));
        end
    end
end

testImages = dir(fullfile('C:\Users\mahtab\Desktop\Subject\Binayi\CarData\TestImages','*.pgm'));
image = imread(fullfile(testImages(1).folder,testImages(1).name));

[rows, columns] = size(image);
for j=40:5:rows
    for k=100:5:columns
        
        currentWindow = image(j-39:j,k-99:k);
        
        gab = Create_Gab_Kernels([6 6 6],100);
        
        windowGab = Compute_Gabbed_Image(double(currentWindow), gab);
        
        for n=1:18
            %devide th 40*100 window into 10 20*20 window
            windowGabCell{n}=mat2cell(windowGab{n},[20 20],[20 20 20 20 20]);
        end
        for n=1:18
            %fill a new array with the mean of each 20*20 window
            for m=1:5
                windowDescriptor{(n-1)*10+m}=mean(mean(windowGabCell{n}{1,m}));
            end
            for m=6:10
                windowDescriptor{(n-1)*10+m}=mean(mean(windowGabCell{n}{2,m-5}));
            end
        end
        
        [picsNum,x]=size(posImageDescriptor)
        dSum=0;
        posmin =10000;
        for pic=1:picsNum
            difference=0;
            for p=1:180
                difference=difference+abs(cell2mat(posImageDescriptor{pic,p})-cell2mat(windowDescriptor{p}));
            end
            if difference < posmin
                posmin = difference;
            end
            
            %dSum =dSum+( sum((cell2mat(trainImageDescriptor(pic,gaber:gaber+9))- cell2mat(testImageWindow)).^2).^0.5);
            
        end
        
        [picsNum,x]=size(negImageDescriptor)
        dSum=0;
        negmin =10000;
        for pic=1:picsNum
            difference=0;
            for p=1:180
                difference=difference+abs(cell2mat(negImageDescriptor{pic,p})-cell2mat(windowDescriptor{p}));
            end
            if difference < negmin
                negmin = difference;
            end
            
            %dSum =dSum+( sum((cell2mat(trainImageDescriptor(pic,gaber:gaber+9))- cell2mat(testImageWindow)).^2).^0.5);
            
        end
        
    end
end
