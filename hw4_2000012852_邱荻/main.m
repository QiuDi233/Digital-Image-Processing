originalImage = imread('WhiteBalance_before.jpg');

originalImage = im2double(originalImage);


avgR = mean(mean(originalImage(:,:,1)));
avgG = mean(mean(originalImage(:,:,2)));
avgB = mean(mean(originalImage(:,:,3)));
avgRGB = [avgR, avgG, avgB];

%平均灰度
avgGray = mean(avgRGB);

%调整系数
adjustR = avgGray / avgR;
adjustG = avgGray / avgG;
adjustB = avgGray / avgB;

balancedImage = originalImage;
balancedImage(:,:,1) = originalImage(:,:,1) * adjustR;
balancedImage(:,:,2) = originalImage(:,:,2) * adjustG;
balancedImage(:,:,3) = originalImage(:,:,3) * adjustB;

imwrite(balancedImage, 'WhiteBalance_after.jpg');