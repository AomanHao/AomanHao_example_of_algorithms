function img_norm = Dedust_Linear(img,conf)
%% 线性颜色校正，应用在除沙尘颜色校正场景，白平衡也能用
%基于统计学原理的颜色校正，以较少的时间复杂度去除偏色
para = conf.para;
img = double(img);
if mean(img(:),'all')>1
    img = img./255;
end

for i = 1:size(img,3)
    img_temp = img(:,:,i);
    img_temp_mean = mean(img_temp,'all');
    img_temp_var = var(img_temp(:),1);
    
    img_max = img_temp_mean + para*img_temp_var;
    img_min = img_temp_mean - para*img_temp_var;
    
    % 归一化
    img_temp(img_temp>img_max) = img_max;
    img_temp(img_temp<img_min) = img_min;
    img_norm(:,:,i) = (img_temp - img_min)./(img_max - img_min);

end
