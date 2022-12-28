%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
% zhihu https://www.zhihu.com/people/aomanhao-hao
% --------------------------------------
%% 图像透雾算法‘灵犀’效果测试
clear;
close all;
clc;

addpath('./method');
addpath('./tools');

pathname = './data/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

data_type = 'bmp'; % raw: raw data
%bmp: bmp data
conf.savepath = './result/';
if ~exist(conf.savepath,'var')
    mkdir(conf.savepath)
end

method = 'LingXi_Dehaze';
conf.remake=[];
for i = 1:img_num
    switch data_type
        case 'bmp'
            name = split(img_name{i+2},'.');
            conf.imgname = name{1};
            conf.imgtype = name{2};
            img = imread([pathname,img_name{i+2}]);
            img_in = im2double(img);
            [m_img,n_img,z_img] = size(img_in);
            figure;imshow(img_in);
    end
       
    %% Single channel data only
    switch method
        case 'LingXi_Dehaze'
            result = LingXi_Dehaze_aomanhao(img_in);          
    end

    figure;imshow(result);
    imwrite(result,[conf.savepath,conf.imgname,'_',method,'.png']);
end

