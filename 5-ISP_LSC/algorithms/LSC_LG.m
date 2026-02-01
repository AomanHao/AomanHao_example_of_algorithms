%% 程序分享
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------
%% 
function Iout = LSC_LG(img)

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

%% 核心公式 
F= min(h, w);
h = ones(F,F);
img_F = filter2(h,img,'same');
Iout = img./img_F;
% Iout

