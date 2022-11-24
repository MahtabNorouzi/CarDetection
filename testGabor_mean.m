function  windowDescriptor = testGabor_mean( window )
gab = Create_Gab_Kernels([6 6 6],100);
[imRows imColumns] = size(window);
squareWindow = imresize(window,[2.5.*imRows imColumns]);
windowGab = Compute_Gabbed_Image(double(squareWindow), gab);

for j=1:18
    %devide th 40*100 window into 10 20*20 window
    windowGabCell{j}=mat2cell(windowGab{j},[20 20 20 20 20],[20 20 20 20 20]);
    windowGabCell{j}=reshape(windowGabCell{j},1,25);
    for k=1:25
        windowDescriptor{(j-1)*25+k}=mean(mean(windowGabCell{j}{1,k}));
    end
end
end