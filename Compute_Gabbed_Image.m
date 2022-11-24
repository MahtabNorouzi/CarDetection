function imGab = Compute_Gabbed_Image(im, Gab)
im = log(im + 1);
imsz = size(Gab, 1);
[xx, yy] = meshgrid(-imsz/2:imsz/2-1);
rr = fftshift(exp(-(xx.^2+yy.^2)/16));
im = im - real(ifft2(fft2(im)*rr));
tmp = sqrt(abs(ifft2(fft2(im.^2)*rr))); 
im = fft2(im./(0.1 + tmp)); 
for n = 1:size(Gab,3)
    imgab = abs(ifft2(im*Gab(:,:,n)));    
    imGab{n} = imgab;
end