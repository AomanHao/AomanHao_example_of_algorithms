%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------
%% 无背景的阴影校正
clear;
close all;
clc;

addpath('./algorithms/');

pathname = './data/cell/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

data_type = 'bmp'; % raw: raw data %bmp: bmp data

conf.savepath = './result/';
if ~exist(conf.savepath,'var')
    mkdir(conf.savepath)
end

methods = {'LSC_sscnew'};
conf.remake=[];
for j = 1:numel(methods)
    LSC_type = methods{j};
    for i = 1:img_num
        switch data_type
            case 'bmp'
                name = split(img_name{i+2},'.');
                conf.imgname = name{1};
                conf.imgtype = name{2};
                img = imread([pathname,img_name{i+2}]);
                [m,n,z] = size(img);
                img_in(:,:,i) = double(img);
                
        end
        
        if z == 3
            img_yuv = rgb2ycbcr(img_in(:,:,i));
            img_in(:,:,i) = uint8(img_yuv(:,:,1));
        else
            
        end
    end
    
    %% Single channel data only
    switch LSC_type
        
        case 'LSC_sscnew'
            [Iout, flatfield_model] = LSC_sscnew(img_in);
    end
    for i = 1:img_num
    imwrite(uint8(Iout(:,:,i)),strcat(conf.savepath,conf.imgname,'_',LSC_type,num2str(i),'.png'));
    end
end
