function outIM = autoDarkWB(inIM)

[m,n,~] = size(inIM);

inIM = double(inIM);
r = inIM(:,:,1);
g = inIM(:,:,2);
b = inIM(:,:,3);

A = mean2((r+g+b)/3);

w = 5;
dark = min(inIM, [], 3);
darkmin = ordfilt2(dark,1,ones(w), 'symmetric');

t =  1 - darkmin/A;
t = max(t,0.05);
 
t1 = mean2(t);

%阈值k，大于230认为是过饱和区域
K = 230; 
T = zeros(m,n);
for i = 1:m
    for j =1:n
        if ((darkmin(i,j))<K && (t(i,j)<t1))
        T(i,j) = 255;
        else
        T(i,j) = 0;   
        end
    end
end
  
 
rsum = 0;
gsum = 0;
bsum = 0;
kt = 0;

for i = 1:m
    for j = 1:n
       if  T(i,j)==255
           rsum = rsum + r(i,j);
           gsum = gsum + g(i,j);
           bsum = bsum + b(i,j);
           kt = kt + 255;
       end
    end
end
       
rgain = rsum / kt;
ggain = gsum / kt;
bgain = bsum / kt;


Wy = 0.21267*rgain + 0.71516*ggain + 0.072169*bgain;
outIM(:,:,1) = r * Wy / rgain;
outIM(:,:,2) = g * Wy / ggain;
outIM(:,:,3) = b * Wy / bgain;

end







