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

pathname = './data/cell/';
img_conf = dir(pathname);
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

data_type = 'bmp'; % raw: raw data %bmp: bmp data

conf.savepath = './result/';
if ~exist(conf.savepath,'var')
    mkdir(conf.savepath)
end

methods = {'cos4'};
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
                img_in = double(img);
                [m,n,z] = size(img_in);
                %                 figure;imshow(img_in);
        end
        
        if z == 3
            img_yuv = rgb2ycbcr(img_in);
            img_in = uint8(img_yuv(:,:,1));
        else
        end
        
        %% Single channel data only
        switch LSC_type
            case 'cos4'
                Iout = LSC_cos4(img_in);
                
            case 'BaSiC'
                Iout = BaSiC(img_in);
                
            case 'LG'
                Iout = LSC_LG(img_in);
                
        end
        imwrite(uint8(Iout),strcat(conf.savepath,conf.imgname,'_',LSC_type,'.png'));
    end
end
