%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clc
clear
close all
%% Clarity Evaluation
%% load data
addpath('./algoriam/');

pathname = './data/img50/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

Eva_type = 'grad_max';%%\grad_max、Inte+Frac_Differ、Laplace

for i = 1:img_num
    %% load data
    
    imgname = split(img_name{i+2},'.');
    conf.name = [imgname{1}];
    pathfilename = [pathname,img_name{i+2}];
    img = imread(pathfilename);
   
    if size(img,3)>1
        img_YUV = rgb2ycbcr(im2double(img));
        img_Y = img_YUV(:,:,1);
    else
        img_Y = img;
    end
    
    [conf.numRows,conf.numCols] = size(img_Y);
    conf.win=3;%滑窗大小
    img_Y_exp = padarray(img_Y,[conf.win,conf.win],'symmetric','both');
    
    %% Clarity Evaluation
    switch Eva_type
        case 'Laplace'
            Eva_sum = Eva_Laplace(img_Y_exp,conf);

        case 'grad_max'
            Eva_sum = Eva_grad_max(img_Y_exp,conf);
            
        case 'Inte+Frac_Differ'
            Eva_sum = Eva_Inte_Frac_Differ(img_Y_exp,conf);
            
    end
    Eva_sum_all(i,:) = Eva_sum;
    
end
Eva_sum_all_norm(:,:) = Eva_sum_all(:,:)./max(Eva_sum_all(:,:));
