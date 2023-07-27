% This function decompose original image into sub-band images. 
% 
% ver.1 May 3rd, 2010, S.H Chen, Lab L2TI, France & Synchromedia, Canada

function [im_base,im_HF] = fun_cortex_image(im_src) 

[im_h,im_w,im_dim] = size(im_src) ; 
[cortex,base] = fun_cortex(im_h,im_w) ; 
% Fourier Transform 
im_src_fft = fftshift(fft2(im_src)) ; 

% Initialization of parameters of number of channel and orientations
num_ch = 5 ;
num_orient = 6 ;
im_HF = zeros(size(im_src)) ; 
for m = 1:num_ch-2
    for n = 1:num_orient
        cortex_filter = zeros(size(im_src)) ; 
        for k = 1:3, cortex_filter(:,:,k) = cortex(:,:,m,n) ; end
        spectre_subband = im_src_fft.*cortex_filter ; 
        sub_im = real(ifft2(ifftshift(spectre_subband))) ;
        
%         if(m==2 && n==2)
%             figure, imshow(cortex_filter)
%             figure, imshow(mat2gray(sub_im))
%             figure, imshow(sub_im)            
%         end
        
        im_HF = im_HF + sub_im ;        
    end
%     figure, imshow(im_HF)
end

cortex_filter_base = zeros(size(im_src)) ; 
for k = 1:3, cortex_filter_base(:,:,k) = base ; end 

spectre_baseband = im_src_fft.*cortex_filter_base ;
im_base = real(ifft2(ifftshift(spectre_baseband))) ; 

% figure, imshow(im_base)
% End of Function 