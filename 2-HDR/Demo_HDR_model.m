%% 程序分享Code share
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
% Zhihu https://www.zhihu.com/people/aomanhao-hao
%--------------------------------------
clear;
clc;
close all;

%% 1、load data calculate data mean value
% load long exposure data 12bit
pathname='.\data\L_exp\';
listfile=dir(fullfile(pathname,'*.raw'));
nn=length(listfile);

Lexp_mean=zeros(1,nn);
for ii=1:nn
    filename=listfile(ii).name;
    pathfilename=fullfile(pathname,filename);
    
    fid=fopen(pathfilename,'rb');
    A=fread(fid,[1280,1024],'uint16');%16
    A=A';
    A = A(:,10:1024);%delete bad pixel columns
    fclose(fid);
    Lexp_mean(ii)=mean(A,'all');
end

% load short exposure data
pathname='.\data\S_exp\';
listfile=dir(fullfile(pathname,'*.raw'));
nn=length(listfile);

Sexp_mean=zeros(1,nn);
for ii=1:nn
    filename=listfile(ii).name;
    pathfilename=fullfile(pathname,filename);
    
    fid=fopen(pathfilename,'rb');
    A=fread(fid,[1280,1024],'uint16');%16
    A=A';
    A = A(:,10:1024);%
    fclose(fid);
    Sexp_mean(ii)=mean(A,'all');
end

%
figure;
plot(1:nn,Sexp_mean,'o-');
grid on;hold on
plot(1:nn,Lexp_mean,'.-');
hold off
xlabel('Num');
ylabel('Data（DN）');
title('data curve');
legend('Sexp','Lexp','location','Best');

%%  2、calculate S-L data  line relationship
para = polyfit(Sexp_mean,Lexp_mean,1);%line relationship
Lexp_mean_fit = polyval(para,Sexp_mean);%line relationship result
figure;
plot(Sexp_mean,Lexp_mean,'o-');
grid on;hold on
plot(Sexp_mean,Lexp_mean_fit,'.-')
hold off
xlabel('Sexp data（DN）');
ylabel('Lexp data（DN）');
title('HDR line relationship curve');
legend('Real curve','Fit curve','location','Best');
disp('over!');


%% 3、test result
numRows=1024;
numCols=1280;
savepath = '.\result\test\';
% load data  test Sexp Lexp data (12bit)
pathfilename='.\data\test\Sexp.raw';
fid=fopen(pathfilename,'rb');
im_Sexp=fread(fid,[numCols,numRows],'uint16');
im_Sexp=double(im_Sexp)';
fclose(fid);

pathfilename='.\data\test\Lexp.raw';
fid=fopen(pathfilename,'rb');
im_Lexp=fread(fid,[numCols,numRows],'uint16');
im_Lexp=double(im_Lexp)';
fclose(fid);

hdr_type = 'line';%
th=3500;%threshold 0.9*data range
k=para(1);%
offset=para(2);%

img_HDR=zeros(numRows,numCols);
switch hdr_type
    %% line relationship
    case 'line'
        for  ii=1:numRows
            for jj=1:numCols
                if im_Lexp(ii,jj)<th
                    img_HDR(ii,jj)=im_Lexp(ii,jj);
                else
                    img_HDR(ii,jj)=k*im_Sexp(ii,jj)+offset;
                end
            end
        end
        %         imwrite(imHDR_bayer./4096,[savepath,'HDR_line.png']);
end
img_HDR=uint16(img_HDR);
img_HDR_out=bitshift(img_HDR,-1);

figure;imshow((im_Sexp./4096));
figure;imshow((im_Lexp./4096));
figure;imshow((double(img_HDR_out))./4096./2);%

