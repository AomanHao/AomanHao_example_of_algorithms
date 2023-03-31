% batch_process 批量处理
clc

pathname="E:\blend_LGHG201\data_0519_201_2000\实景1";
folderName="灰度图像";
mkdir(fullfile(pathname,folderName));

listfile=dir(fullfile(pathname,'*.raw'));
nn=length(listfile);
for ii=1:nn
    filename=listfile(ii).name;
    pathfilename=fullfile(pathname,filename);
    
    fid=fopen(pathfilename,'rb');
    I=fread(fid,[1920,1080],'uint8');
    I=I';
    fclose(fid);
    
    
    filename_new=[filename(1:end-4),'_Y','.raw'];
    ptahfilename_new=fullfile(pathname, folderName, filename_new);
    J=demosaic_rgb2gray_fun(I);
    
    fid=fopen(ptahfilename_new,'wb');
    fwrite(fid,J','uint8');
    fclose(fid);
    
end



