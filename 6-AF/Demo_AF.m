%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------
%%
clear;
close all;
clc;

addpath('./algorithms/');

pathname = './data/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

data_type = 'bmp'; % raw: raw data %bmp: bmp data

conf.savepath = './result/';
if ~exist(conf.savepath,'var')
    mkdir(conf.savepath)
end


conf.remake=[];

for i = 1:img_num
    switch data_type
        case 'bmp'
            name = split(img_name{i+2},'.');
            conf.imgname = name{1};
            conf.imgtype = name{2};
            img = imread([pathname,img_name{i+2}]);
            [m,n,z] = size(img);
    end
    
    if z == 3
        img_yuv = rgb2ycbcr(double(img));
        img_in = double(img_yuv(:,:,1)./255);
    else
    end
    
    
    %% paper<Fully Digital Auto-Focusing System with Automatic Focusing Region Selection and Point Spread Function Estimation>
    conf.block_size = 8;
    func_Fully_Digital_AF(img_in,conf);
    
    
end


