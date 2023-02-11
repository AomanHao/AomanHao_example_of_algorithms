% This program aims to implement modified center/around version of Retinex
% Version 1, Jan 18th, 2009, by Shaohua Chen, lab L2TI, France

function [im_enh_lum, im_mask] = fun_NRCIR(im_src_ch)

[im_h, im_w] = size(im_src_ch) ; 
% im_src_ch = 255*(mat2gray(im_src_ch)) ; 
im_src_ch = 255*((im_src_ch)) ; 
K = fix(max(im_h,im_w)/8) ; 
N_lvl = fix(log2(K)) ;   

mask = zeros(2*K+1,2*K+1) ; 
for k = 1:N_lvl
    [x,y] = meshgrid(-K:K,-K:K) ; 
    f = exp(-(x.^2+y.^2)/(2^(2*k))) ; 
    mask = mask + f ; 
end
mask = mask/sum(mask(:)) ; 
mask_pad = zeros(size(im_src_ch)) ; 
mask_pad(im_h/2-K:im_h/2+K, im_w/2-K:im_w/2+K) = mask ; 
mask_fft = fftshift(fft2(mask_pad)) ; 
im_src_ch_fft = fftshift(fft2(im_src_ch)) ; 
im_mask_fft = im_src_ch_fft.*mask_fft ; 
im_mask = abs(fftshift(ifft2(im_mask_fft))) ; 
% temp = mat2gray(im_mask) ;
temp = mat2gray(im_mask) ;
imwrite(temp,'retinex_mask.bmp') ;

% Using log10() to compress dynamic range of mask 
im_mask_log = log10(im_mask + eps) ; 

im_enh_lum = im_src_ch./(im_mask_log + eps) ; 

% End of Function