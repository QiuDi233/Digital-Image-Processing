% originalImage = imread('football.jpg');
originalImage = imread('kids.tiff');

% scaleFactor = 0.5;
% method = 'nearest';
scaleFactor = 0.5;
method = 'bilinear';


resizedImage = my_imresize(originalImage, scaleFactor, method);

% imwrite(resizedImage, 'resized_football_bilinear_200x100.jpg');
imwrite(resizedImage, 'resized_kids_bilinear0.5.tiff');