function PSNR = psnr(image1,image2)
[a,b]=size(image1);
sqr=double(image1) - double(image2);
mse= sum(sum( sqr.^2 ))/(a*b);
PSNR= 10*log10( 255*255 / mse );

end
