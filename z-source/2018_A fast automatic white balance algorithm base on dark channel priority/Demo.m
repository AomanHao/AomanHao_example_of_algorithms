%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------
%%
clear;
close all;
clc;

addpath('./methods/');
addpath('./tools/');

pathname = './data/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

data_type = 'bmp';

conf.remake=[];
for i = 1:img_num
    switch data_type
        case 'bmp'
            name = split(img_name{i+2},'.');
            conf.imgname = name{1};
            conf.imgtype = name{2};
            img = imread([pathname,img_name{i+2}]);
            [m_img,n_img,z_img] = size(img);
%             figure;imshow(img);
    end
    
    result = autoDarkWB(img);
    figure,
    subplot(1,2,1)
    imshow(uint8(img));
    title('original imag')
    subplot(1,2,2)
    imshow(uint8(result));
    title('deal imag')
end