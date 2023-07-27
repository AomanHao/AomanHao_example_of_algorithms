% This program realize Natural Enhancement of Color Image (NECI)
% 
% Principles: 
% The Retinex used is modified one-filter Retinex (algorithm of NRCIR in
% ICIP09: Shaohua Chen & Azeddine Beghdadi). Histogram rescaling and 
% content-based global mapping is applied. Colorspace LCH is chosen for 
% luminance and chrominance enhancement. Hue angle remains unchanged to 
% avoid evident hue-shift. Enhancement map applied to Chrominance channel
% to avoid unbalanced RGB independent enhancement. 
%
% Ver. 10, December 30th, 2011, Shaohua Chen, Matrox Imaging

close all ;
clear all ; clc ; %path(path,'NECI_TOOLs') ; 
warning off; 

% Inputting Image
[im_name, im_path] = uigetfile( {'*.jpg;*.tiff;*.tif;*.ppm;*.pgm;*.png;*.bmp'},'Pick a picture'); % user is prompted to select an image



im_src = imread(fullfile(im_path,im_name)) ;
input=im_src;
figure, imshow(im_src) ; title('Source Image')

tstart = tic;

im_src = mat2gray(double(imread(fullfile(im_path,im_name)))) ; % Convert matrix to grayscale image
[im_h,im_w,im_d] = size(im_src) ;
%if(min(im_h,im_w)>4096),im_src = imresize(im_src,0.5) ; end 

% For gray level image, make pseudo color image
if(im_d==1)
    im_src_color = zeros(im_h,im_w,3) ; % Preallocation of im_src_color space array
    for k = 1:3, im_src_color(:,:,k) = im_src ; end
    im_src = im_src_color ;
end

% Content-dependent global mapping 
im_src_Lch = colorspace('rgb->Lch',im_src) ;
L_src = im_src_Lch(:,:,1) ; c_src = im_src_Lch(:,:,2) ; h_src = im_src_Lch(:,:,3) ;
[im_src,flag] = fun_gm(im_src,L_src) ;
im_src_Lch = colorspace('rgb->Lch',im_src) ;
L = im_src_Lch(:,:,1) ; c = im_src_Lch(:,:,2) ; h = im_src_Lch(:,:,3) ;

% Enhancement of luminance channel using modified one-filter Retinex 
im_enh_Lch = zeros(size(im_src)) ;
% Luminance enhanced by NRCIR_Chen
[im_enh_Lch(:,:,1),im_mask] = fun_NRCIR(L) ;

% figure;imshow(uint8(L))
% figure;imshow(uint8(im_enh_Lch(:,:,1)))

% Chrominance enhancement with NRCIR enhance map
im_enh_norm = fun_hist_scaling(im_enh_Lch(:,:,1)) ; 
map_ref = im_enh_norm./(mat2gray(L_src+L)+eps) ; 

map_ref_log = log2(map_ref+eps) + 1 ; 
enh_map = map_ref_log ; 
im_enh_Lch(:,:,2) = c.*enh_map ;

% Keep hue angle unchanged
im_enh_Lch(:,:,3) = h ;

im_enh_Lch(:,:,1) = max(L(:))*fun_hist_scaling(im_enh_Lch(:,:,1)) ;
im_enh = colorspace('Lch->rgb',im_enh_Lch) ;

% Detail Enhancement using Cortex Transform 
% % This step is optional, because it takes long to computer. 
%  [im_base,im_HF] = fun_cortex_image(im_enh) ; 
% % 
%  COEF = 0.3 ; 
%  im_enh = im_enh + im_HF*COEF ; 
tElapsed = toc(tstart)

% Show Mapped Images Using Cortex
figure, imshow(im_enh) ; title('Final image using enhanced image f+ HF component') ; 
output=uint8(255*im_enh);
%***********************************************
brisque_original=brisque(input)
brisque_enhanced =brisque(output) 

score_original=niqe(input)
score_enhanced =  niqe(output) 

C_original=Contrast_per_Pixel(rgb2gray(input));
C_enhanced=Contrast_per_Pixel(rgb2gray(output));
contrast_gain=(C_enhanced/C_original)

