% 画图
clf, clear
rng(4);
image = imread("pngtree-beautiful-landscape-hd-wallpaper-image_2914564.jpg");
image = rgb2gray(image);
image1= imnoise(image, 'gaussian', 0,0.02);
image2= imnoise(image, 'gaussian', 0,0.04);
image3= imnoise(image, 'gaussian', 0,0.06);

wname='db2';n=3;input=image1;

[img, imgs, psn, PSN] = WaveletDenoising(input, n, wname, image, -1);

figure(1);
subplot(221);disp('噪声图像峰值信噪比:'),psnr(image, input)
imshow(input, []);title('原噪声图像');

subplot(222);disp('硬阈值去噪后的峰值去噪比：'),PSN(1)
imshow(imgs(:, :, 1), []);title('硬阈值去噪后的图像');

subplot(223);disp('软阈值去噪后的峰值去噪比：'),PSN(100)
imshow(imgs(:, :, 100), []);title('软阈值去噪后的图像');

subplot(224);disp('最佳折中阈值去噪后的峰值去噪比：'),psn
imshow(img, []);title('最佳折中阈值去噪后的图像');

figure(2);
xlabel('迭代次数');ylabel('峰值信噪比PSNR');
title('噪声方差0.06，PSNR随折中系数的变化');
plot(PSN);
