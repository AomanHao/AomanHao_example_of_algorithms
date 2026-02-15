function J = func_infrared_enhance(I, conf)
% 输入：I=灰度图(uint8)，omega=0.85，t0=0.1，win_size=15，gamma=1.3
disp("paper---Infrared traffic image enhancement algorithm based on dark channel prior and gamma correction")
omega=conf.omega;
t0=conf.t0;
win_size=conf.win_size;
gamma=conf.gamma;
if mean(I(:))>1
    I = I./255;
end

[h, w] = size(I);

% 1. 计算单通道暗通道
pad = floor(win_size/2);
I_pad = padarray(I, [pad pad], 'symmetric');
dark = zeros(h, w);
for i = 1:h
    for j = 1:w
        patch = I_pad(i:i+win_size-1, j:j+win_size-1);
        dark(i,j) = min(patch(:));
    end
end

% 2. 估计大气光A
dark_vec = dark(:);
[~, idx] = sort(dark_vec, 'descend');
top_num = round(0.001*h*w);
A = mean(I(idx(1:top_num)));

% 3. 计算透射率+红外修正+导向滤波
t = 1 - omega * dark / A;
t = t .^ gamma; % 红外衰减修正
t = imguidedfilter(t, I, 'NeighborhoodSize', [win_size win_size]); % 导向滤波

% 4. 恢复图像
t = max(t, t0);
J = (I - A) ./ t + A;
% J = imadjust(J, [min(J(:)) max(J(:))], [0 1]); % 灰度拉伸
% J = im2uint8(J);
end

% 调用示例
% I = imread('infrared_hazy.png');
% J = infrared_dark_dehaze(I, 0.85, 0.1, 15, 1.3);
% imshowpair(I, J, 'montage');