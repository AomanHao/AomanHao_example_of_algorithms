function ccpr = computeCCPR(Irgb, gray, tau)
% CCPR: Color Contrast Preserving Ratio
% Irgb: RGB double图像
% gray: 输出灰度图
% tau : 感知阈值（Lab空间推荐5）

Lab = rgb2lab(Irgb);
H = size(gray,1);
W = size(gray,2);

%% 水平相邻像素对
dx_g = abs(gray(:,1:end-1) - gray(:,2:end));
dLab_x = vecnorm(Lab(:,1:end-1,:)-Lab(:,2:end,:), 2, 3);

%% 垂直相邻像素对
dy_g = abs(gray(1:end-1,:) - gray(2:end,:));
dLab_y = vecnorm(Lab(1:end-1,:,:)-Lab(2:end,:,:), 2, 3);

%% 合并统计
colorDiffAll  = [dLab_x(:); dLab_y(:)];
grayDiffAll   = [dx_g(:); dy_g(:)];

validColor = colorDiffAll > tau;
totalColorPair = sum(validColor);
if totalColorPair == 0
    ccpr = 0;
    return;
end
survivePair = sum( validColor & (grayDiffAll > tau) );
ccpr = survivePair / totalColorPair;
end