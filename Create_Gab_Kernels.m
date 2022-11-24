function Gab = Create_Gab_Kernels(ornt, imsz) 
[xx, yy] = meshgrid(-imsz/2:imsz/2-1); 
rr = fftshift(sqrt(xx.^2 + yy.^2)); 
aa = fftshift(angle(xx + sqrt(-1) * yy)); 
 
n = 0; 
Gab = zeros([imsz imsz sum(ornt)]); 
for i = 1:length(ornt) 
    for j = 1:ornt(i) 
        n = n + 1; 
        bb = aa + pi/(ornt(i))*(j-1);  
        bb = bb + 2*pi*(bb<-pi);  
        bb = bb - 2*pi*(bb>pi); 
        Gab(:, :, n) = exp(-5 * (rr/imsz/(0.5/(2^(i-1)))-1).^2 - 2*(16*ornt(i)^2/1024) * pi * bb.^2); 
    end 
end