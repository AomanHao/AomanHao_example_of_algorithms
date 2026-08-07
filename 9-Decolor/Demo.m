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

Eva_type = 'grad_max';%%\grad_max、Inte+Frac_Differ、Laplace

for i = 1:img_num
    %% load data
    
    imgname = split(img_name{i+2},'.');
    conf.name = [imgname{1}];
    pathfilename = [pathname,img_name{i+2}];
    img = imread(pathfilename);
   
    

% 2. 传统标准灰度化
gray_ori = rgb2gray(rgb_img);
figure; imshow(gray_ori); title('彩转灰');
imwrite(gray_ori,'彩砖灰2.png')
ccpr1 = computeCCPR(rgb_img.*255, gray_ori.*255, 5/255);
    

%% RTCP 去色
gray2 = func_RTCP(rgb_img);
figure; imshow(gray2); title('增强灰2');
imwrite(gray2,'RTCP2.png')
ccpr4 = computeCCPR(rgb_img.*255, gray2.*255, 5);
    
end

