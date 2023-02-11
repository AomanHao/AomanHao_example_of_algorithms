% This programs aims to rescaling image using 99% of histogram
% 
% Version 1, Jan 18th, 2009, by Shaohua Chen, Lab L2TI, France

function im_enh_norm = fun_hist_scaling(im_enh) 

im_enh_norm = im_enh ;

Nbits = 256 ; 
[im_enh_hist, im_enh_lvl] = hist(im_enh(:), Nbits) ; 
im_hist_ttl = sum(im_enh_hist(:)) ; 
cut_hist_left = 0.01*im_hist_ttl ; cut_hist_right = 0.99*im_hist_ttl ; 
sum_hist = 0 ; 
for k = 1:Nbits
    sum_hist = sum_hist + im_enh_hist(k) ; 
    if(sum_hist>cut_hist_left)
        cut_lvl_left = im_enh_lvl(k); 
        break ; 
    end
end
sum_hist = 0 ; 
for k = 1:Nbits
    sum_hist = sum_hist + im_enh_hist(k) ; 
    if(sum_hist>cut_hist_right)
        cut_lvl_right = im_enh_lvl(k) ; 
        break ; 
    end
end
im_enh_norm(im_enh_norm<cut_lvl_left) = cut_lvl_left ; 
im_enh_norm = im_enh_norm/(cut_lvl_right+eps) ; 

% End of Program 