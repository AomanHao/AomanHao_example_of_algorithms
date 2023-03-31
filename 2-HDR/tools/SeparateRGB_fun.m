function [R,G,B ]= SeparateRGB_fun(A,BayerPattern)
%选择不同Bayer模板
%分离R G B三通道
[Width,Height]=size(A);
NumPixels=Width*Height;
NumPixels_R=NumPixels/4;
NumPixels_G=NumPixels/2;
NumPixels_B=NumPixels/4;
R=zeros(NumPixels_R,1);
G=zeros(NumPixels_G,1);
B=zeros(NumPixels_B,1);
switch BayerPattern
    case 'gbrg'
        nnR=0;
        nnG=0;
        nnB=0;
        for  ii=1:Width
            for jj=1:Height
                FlagRow=mod(ii,2);
                FlagCol=mod(jj,2);
                if FlagRow==0 &&  FlagCol==1
                    nnR=nnR+1;
                    R(nnR)=A(ii,jj);
                elseif FlagRow==1 &&  FlagCol==0
                    nnB=nnB+1;
                    B(nnB)=A(ii,jj);
                else
                    nnG=nnG+1;
                    G(nnG)=A(ii,jj);
                end
            end
        end
        
    case 'grbg'
        nnR=0;
        nnG=0;
        nnB=0;
        for  ii=1:Width
            for jj=1:Height
                FlagRow=mod(ii,2);
                FlagCol=mod(jj,2);
                if FlagRow==1 &&  FlagCol==0
                    nnR=nnR+1;
                    R(nnR)=A(ii,jj);
                elseif FlagRow==0 &&  FlagCol==1
                    nnB=nnB+1;
                    B(nnB)=A(ii,jj);
                else
                    nnG=nnG+1;
                    G(nnG)=A(ii,jj);
                end
            end
        end
     
    case 'bggr'
        nnR=0;
        nnG=0;
        nnB=0;
        for  ii=1:Width
            for jj=1:Height
                FlagRow=mod(ii,2);
                FlagCol=mod(jj,2);
                if FlagRow==0 && FlagCol==0
                    nnR=nnR+1;
                    R(nnR)=A(ii,jj);
                elseif FlagRow==1 && FlagCol==1
                    nnB=nnB+1;
                    B(nnB)=A(ii,jj);
                else
                    nnG=nnG+1;
                    G(nnG)=A(ii,jj);
                end
            end
        end
        
    case 'rggb'
        nnR=0;
        nnG=0;
        nnB=0;
        for  ii=1:Width
            for jj=1:Height
                FlagRow=mod(ii,2);
                FlagCol=mod(jj,2);        
                if FlagRow==1 &&  FlagCol==1
                    nnR=nnR+1;
                    R(nnR)=A(ii,jj);
%                     disp(nnR);
                elseif FlagRow==0 &&  FlagCol==0
                    nnB=nnB+1;
                    B(nnB)=A(ii,jj);
                else
                    nnG=nnG+1;
                    G(nnG)=A(ii,jj);
                end
            end
        end
        
    otherwise
        disp('error');
        
end




end

