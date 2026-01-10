%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------
%% 基于cos?θ规律的径向阴影（Radial Shading）校正
function Iout = LSC_cos4(img)

%img：灰度图像
% 归一化到0-1范围（避免整数运算溢出）
img_norm = im2double(img);
[h, w] = size(img_norm); % 获取图像高、宽

% 图像中心坐标
center_x = w / 2;
center_y = h / 2;

[X, Y] = meshgrid(1:w, 1:h);
dx = X - center_x;
dy = Y - center_y;
r = sqrt(dx.^2 + dy.^2);%欧氏距离

%% 核心公式 cos_theta = focal_length ./ sqrt(r.^2 + focal_length^2)：

focal_length = max(h, w); % 焦距，可根据实际场景调整
% focal_length = 2000;
cos_theta = focal_length ./ sqrt(r.^2 + focal_length^2);
cos4_theta = cos_theta.^4;
cos4_theta(cos4_theta == 0) = eps; 
Iout = img_norm ./ cos4_theta;
