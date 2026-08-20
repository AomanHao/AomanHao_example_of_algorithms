%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clc
clear
close all
%% Decolor
%% load data
addpath('./algoriam/');

pathname = './data/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

for i = 1:img_num
    %% load data
    imgname = split(img_name{i+2},'.');
    conf.name = [imgname{1}];
    pathfilename = [pathname,img_name{i+2}];
    img = im2double(imread(pathfilename));

    
    %% 1. 传统标准灰度化
    gray_ori = rgb2gray(img);
    figure; imshow(gray_ori); title('彩转灰');
    imwrite(gray_ori,strcat(conf.name,'彩转灰.png'));
    ccpr1 = computeCCPR(img.*255, gray_ori.*255, 5/255);
    
    
    %% 2、RTCP 去色 《Real-time Contrast Preserving Decolorization》
    gray2 = func_RTCP(img);
    figure; imshow(gray2); title('增强灰');
    imwrite(gray2,strcat(conf.name,'RTCP.png'));
    ccpr4 = computeCCPR(img.*255, gray2.*255, 5);
    
end

