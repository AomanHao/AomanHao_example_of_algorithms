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

dedust_type = 'BlueComp';
for i = 1:img_num
    switch data_type
        case 'bmp'
            name = split(img_name{i+2},'.');
            conf.imgname = name{1};
            conf.imgtype = name{2};
            img = imread([pathname,img_name{i+2}]);
            [m,n,z] = size(img);
    end
    
    %     imtool(img);
    %% 算法处理
    tic;
    switch dedust_type
        case 'Linear'
            %Linear correction
            conf.para = 10;
            result = Dedust_Linear(img,conf);
            
            
        case 'BlueComp'
            result = Dedust_BlueComp(img);
    end
    toc;
    t=toc;
    result = im2uint8(result);
    %% Motion compensation save video result
    imwrite(uint8(img),strcat(conf.savepath,conf.imgname,'.png'));
    imwrite(uint8(result),strcat(conf.savepath,conf.imgname,'_',dedust_type,'.png'));
end



