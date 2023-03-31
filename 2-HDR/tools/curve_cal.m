% curve cal
clc
close all
clear all

line_time=5:5:70;


DN_HG_R=[232.5586
327.5804
429.6298
535.2554
590.1521
699.0244
810.4632
922.9670
1036.2354
1095.5435
1209.6207
1326.1125
1441.3981
1501.3149
1620.0418
1736.3998
1854.7655
1971.8709
2030.7237
2151.9952
2272.6939
2393.2613
2513.8853
2575.7716
];
DN_LG_R=[137.0588
140.7204
145.0983
149.3425
151.9350
155.8580
160.2417
164.4487
168.9648
171.1638
175.8601
180.1614
184.7127
186.9759
191.8456
196.2903
200.9548
205.2334
207.3452
212.1122
216.6747
220.9303
225.6638
228.3148
];

DN_hg=DN_HG_R;
DN_lg=DN_LG_R;

figure;
plot(DN_lg,DN_hg,'o--');
xlabel('DN lg');
ylabel('DN hg');



p = polyfit(DN_lg,DN_hg,1);

DN_hg_fit = polyval(p,DN_lg);


figure(6)
plot(DN_lg,DN_hg,'o--');
grid on;
hold on
plot(DN_lg,DN_hg_fit,'.-')
hold off
xlabel('低增益像素输出平均灰度值（DN）');
ylabel('高增益像素输出平均灰度值（DN）');
title('HDR 合成曲线图');
% title('HDR 合成曲线图--B通道')
% text('\leftarrow sin(\pi)')
disp(p)
