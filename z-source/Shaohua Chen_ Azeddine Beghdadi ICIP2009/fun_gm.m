% This program aims to modify the global illumination of image as a
% pre-processing of HDR image for retinex algo.
%
% Ver. 3, Jan 18th, 2010, By S.H.CHEN, Lab L2TI, FRANCE

function [im_hdr_gm, flag] = fun_gm(im_src, im_src_lum)

flag = 0 ; im_hdr_gm = im_src ;
[im_h,im_w] = size(im_src_lum) ;
im_log = log(im_src_lum + eps) ;
key = exp(sum(im_log(:))/prod(size(im_src_lum))) ;

%% Globle mapping to ICE competence using a circle curve instead of gamma.
key = min(86,max(14,key)) ;
% This condition is for general non-compressed image.
if(key <= 50)
    for k = 1:3
        r = 3*log(key/10+eps) ;
        r = max(r,1.4) ;
        x0 = (2 + sqrt(4-8*(1-r*r)))/4 ;    y0 = 1 - x0 ;
        % Combine with gamma correction:
        y1 = 0.15 ;
        x1 = x0 - sqrt(r*r - (y1-y0)*(y1-y0)) ;
        gamma_value = log(y1)/log(x1) ;
        temp1 = y0 + sqrt(r*r -(im_src(:,:,k)-x0).*(im_src(:,:,k)-x0)) ;
        temp2 =  im_src(:,:,k).^gamma_value ;
%         im_hdr_gm(:,:,k) = min(temp1,temp2) ;
        im_hdr_gm(:,:,k) = max(temp1,temp2) ;
        flag = 0 ;
    end
end
if(key >= 60)
    for k = 1:3
        r = 3*log(10-key/10+eps) ;
        r = max(r,1.4) ;
        x0 = (2 - sqrt(4-8*(1-r*r)))/4 ;    y0 = 1 - x0 ;
        im_hdr_gm(:,:,k) = y0 - sqrt(r*r -(im_src(:,:,k)-x0).*(im_src(:,:,k)-x0)) ;
    end
    flag = 1 ;
end
im_hdr_gm = real(min(1,max(0,im_hdr_gm))) ;

% End of Program