
clc
close all;clear;

% pathname=".\data_1109\lg\";
pathname=".\data_1109\hg\";

listfile=dir(fullfile(pathname,'*.raw'));
nn=length(listfile);
sensor_type = 'gray';

switch sensor_type
    case 'rgb'
        R_mean_all=zeros(1,nn);
        G_mean_all=zeros(1,nn);
        B_mean_all=zeros(1,nn);
    case 'gray'
        B_mean_all=zeros(1,nn);
end

for ii=1:nn
    filename=listfile(ii).name;
    pathfilename=fullfile(pathname,filename);
    
    fid=fopen(pathfilename,'rb');
    A=fread(fid,[1280,1024],'uint16');%16
    A=A';
    fclose(fid);
    switch sensor_type
        case 'rgb'
            [R_mean,G_mean,B_mean]=SeparateRGBmean_func(A,'bggr');
            R_mean_all(ii)=R_mean;
            G_mean_all(ii)=G_mean;
            B_mean_all(ii)=B_mean;
        case 'gray'
            mean_temp = mean(A,'all');
            mean_all(ii) = mean_temp;
    end
    
    
end

% aa=5:5:90;
% line_time=[ 1 aa ];
%
% figure(1)
% plot(line_time,R_mean_all,'r-');
% hold on;
% grid on;
% plot(line_time,G_mean_all,'g-');
% plot(line_time,B_mean_all,'b-');
% hold off;
switch sensor_type
    case 'rgb'
        % R  G  B
        fid =fopen('LG12_R.txt','w+');
        fprintf(fid,'%8.4f\n',R_mean_all);
        fclose(fid);
        
        fid =fopen('LG12_G.txt','w+');
        fprintf(fid,'%8.4f\n',G_mean_all);
        fclose(fid);
        
        fid =fopen('LG12_B.txt','w+');
        fprintf(fid,'%8.4f\n',B_mean_all);
        fclose(fid);
    case 'gray'
        % gray
        fid =fopen('HG12_gray.txt','w+');
        fprintf(fid,'%8.4f\n',mean_all);
        fclose(fid);
        
end
disp("over");










