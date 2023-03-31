
clc
clear all

%LG
pathfilename='C:\Users\m02269\Desktop\gamma校正前图像\LG_expo60.raw';
fid=fopen(pathfilename,'rb');
YL=fread(fid,[1920,1080],'uint16');
YL=YL';
fclose(fid);

imtool(YL,[]);

YLc= demosaic(uint8(YL/16),'gbrg');
imtool(YLc,[]);


%HG
pathfilename='C:\Users\m02269\Desktop\gamma校正前图像\HG_expo60.raw';
fid=fopen(pathfilename,'rb');
YH=fread(fid,[1920,1080],'uint16');
YH=YH';
fclose(fid);

imtool(YH,[]);

YHc= demosaic(uint8(YH/16),'bggr');% 'gbrg' 'grbg'  'bggr' 'rggb'
imtool(YHc,[]);

YLg=255*(YL/255).^0.3;
imtool(YLg,[]);

YLgc= demosaic(uint8(YLg),'gbrg');
imtool(YLgc,[]);


%blend
numRows=1080;
numCols=1920;
YL=double(YL);
YH=double(YH);
th=200;%
k=20;
offset=-90;
% k=10;
% offset=10;
YHDR=zeros(numRows,numCols);
for  ii=1:numRows
    for jj=1:numCols
        if YH(ii,jj)<th
            YHDR(ii,jj)=YH(ii,jj);
        else
            YHDR(ii,jj)=k*YL(ii,jj)+offset;
        end
    end
end
imtool(YHDR,[]);


%丢4位
YHDRd=bitshift(YHDR,-4);
imtool(YHDRd,[]);
YHDRdg=255*(YHDRd/255).^0.3;
imtool(YHDRdg,[]);

YHDRdgc= demosaic(uint8(YHDRdg),'gbrg');
imtool(YHDRdgc,[]);


%gamma
th1=3000;
YHDR=min(YHDR,th1);
th2=10;
YHDR=max(YHDR,th2);
YHDR=YHDR-th2;
YHDRg=255*(YHDR/(th1-th2)).^0.3;



YHDRc= demosaic(uint8(YHDRg),'gbrg');
imtool(YHDRc,[]);
% 
% imtool(YHDRg,[]);
% figure()
% imshow(uint8(YHDRg))

% YLg=255*(YL/255).^0.1;
% imtool(YLg,[]);
