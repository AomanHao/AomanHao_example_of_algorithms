function out=Contrast_per_Pixel(input)
kernel = [-1, -1, -1, -1, 8, -1, -1, -1]/8;
diffImage = conv2(double(input), kernel, 'same');
out = mean2(abs(diffImage));