function [Image, Images, Psnr, PSNR]=WaveletDenoising(x,n,wname,image,a)
[c,s]=wavedec2(x,n,wname);           

for i=1:3
    if i==1
        num(i,1)=s(i,1)*s(i,2)+1;                   
        num(i,2)=num(i,1)+s(i+1,1)*s(i+1,2);
        num(i,3)=num(i,2)+s(i+1,1)*s(i+1,2);
        step(i)=s(i+1,1)*s(i+1,2);
    else
        num(i,1)=num(i-1,3)+s(i,1)*s(i,2);
        num(i,2)=num(i,1)+s(i+1,1)*s(i+1,2);
        num(i,3)=num(i,2)+s(i+1,1)*s(i+1,2);
        step(i)=s(i+1,1)*s(i+1,2);
    end
end
C=c;
for j=1:101
    b(j)=0.01*(j-1);                        
    for i=1:3
        [H,V,D]=detcoef2('a',c,s,i);        
        B=[H V D];
        [M,N]=size(B);
        for k=1:M
             for w=1:N
                sigma=median(abs(B(k,w)))/0.6745;
             end
        end
        th=sigma*sqrt(2*log10(M*N));
        
        ch=c(1,num(4-i,1):num(4-i,2)+step(4-i)-1);
        C(1,num(4-i,1):num(4-i,2)+step(4-i)-1)=ThresholdProcessing(ch,th,b(j));
        cv=c(1,num(4-i,2):num(4-i,2)+step(4-i)-1);
        C(1,num(4-i,2):num(4-i,2)+step(4-i)-1)=ThresholdProcessing(cv,th,b(j));
        cd=c(1,num(4-i,3):num(4-i,2)+step(4-i)-1);
        C(1,num(4-i,3):num(4-i,2)+step(4-i)-1)=ThresholdProcessing(cd,th,b(j));
    end
    ReImage(:,:,j)=waverec2(C,s,wname);
    [a1,b1]=size(image);
    sqr=double(image) - double(ReImage(:,:,j));
    mse= sum(sum( sqr.^2 ))/(a1*b1);
    PSNR(j)= 10*log10( 255*255 / mse ); 
    
end
%返回输出值
a=a+1;
[Ma,Mn]=max(PSNR); 
if a==0
    Psnr=Ma;
    Image=ReImage(:,:,b(Mn)*100);
    disp("最佳阈值:"),b(Mn)
else
    Image=ReImage(:,:,a);
Psnr=PSNR(a);
end
Images = ReImage;
end
