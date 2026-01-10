
function Iout = LSC_mesh(img)


%% estimate flatfield and darkfield
% For brightfield images, darkfield estimation is not necessary (default)
% also, we do not need to set regularisation parameters, lambda and
% lambda_dark, but use default setted ones
flatfield = BaSiC(img);  
basefluor =  BaSiC_basefluor(img,flatfield);

Iout = zeros(size(img));
for i = 1:length(files)
%     IF_corr(:,:,i) = double(IF(:,:,i))./flatfield - basefluor(i);
Iout(:,:,i) = double(img(:,:,i))./flatfield;
end