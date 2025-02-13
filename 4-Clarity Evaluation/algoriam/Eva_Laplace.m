function diff_sum = Eva_Laplace(img_center_exp,conf)

%% ������˹���ֵ���
[m,n] = size(img_center_exp);
win = conf.win;%һ��Ϊ3
winhalf = floor(win/2);
diff_sum=0;

if ~exist(conf.mask)
    mask  = [0,1,0;1,-4,1;0,1,0];%mask
else
    mask = conf.mask;
end
for i = 1+winhalf : m-winhalf
    for j = 1+winhalf : n-winhalf
        
        img_temp = double(img_center_exp(i-winhalf:i+winhalf,j-winhalf:j+winhalf));
        
        diff_temp = abs(sum(img_temp.*mask,'all'));
        
        diff_sum = diff_sum+diff_temp;
    end
end

diff_sum = diff_sum/conf.num_center;
