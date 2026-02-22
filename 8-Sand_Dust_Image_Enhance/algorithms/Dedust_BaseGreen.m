function img_out = Dedust_BaseGreen(img,conf)
%% 色彩平衡，应用在除沙尘颜色校正场景，白平衡也能用
%色偏校正+绿色通道保持颜色归一化
img = double(img);
if mean(img(:),'all')>1
    img = img./255;
end

% 分离RGB通道
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
% 权重计算
Wm = [mean(G(:))-mean(R(:)), mean(G(:))-mean(G(:)), mean(G(:))-mean(B(:))];
Wh = [var(G(:),1)/var(R(:),1), var(G(:),1)/var(G(:),1),var(G(:),1)/var(B(:),1)];
Ww = 1-(1-mean(B(:))+mean(R(:)))/2;

for i = 1:size(img,3)
    img_temp = img(:,:,i);

    img_t = img_temp+(Wm(i)* Wh(i).*Ww.*img_temp) .*G;
%     img_tt(:,:,i) = img_t;
    
    img_out(:,:,i) = (img_t - mean(img_t(:)))/(max(img_t(:))-min(img_t(:)))+mean(G(:));
end
% figure;imshow(img);
% figure;imshow(img_tt);
% figure;imshow(img_out);
img_out = im2uint8(img_out);

