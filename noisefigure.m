clf, clear

image = imread("pngtree-beautiful-landscape-hd-wallpaper-image_2914564.jpg");
image = rgb2gray(image);
image1= imnoise(image, 'gaussian', 0,0.02);
image2= imnoise(image, 'gaussian', 0,0.04);
image3= imnoise(image, 'gaussian', 0,0.06);

figure('NumberTitle', 'off', 'Name', '原图像和噪声图像')
subplot(221);imshow(image);title('原图像');
subplot(222);imshow(image1);title('均值为0，方差为0.02的噪声图像');
subplot(223);imshow(image2);title('均值为0，方差为0.04的噪声图像');
subplot(224);imshow(image3);title('均值为0，方差为0.06的噪声图像');

disp('0.02噪声图像的峰值信噪比：'),psnr(image,image1)
disp('0.04噪声图像的峰值信噪比：'),psnr(image,image2)
disp('0.06噪声图像的峰值信噪比：'),psnr(image,image3)
