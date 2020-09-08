function ThresholdingOtsu(filename)

global H Index;
f=imread(filename);
figure
subplot(2,2,1);
imshow(f);
title('Original Image');

V=reshape(f,[],1);
G=hist(V,0:255);
H=reshape(G,[],1);
I=0:255;
Index=reshape(I,[],1);
total=zeros(size([1 256]));
 
 for i=0:255
     [a,b]=calculate(1,i);
     [c,d]=calculate(i+1,255);
     total(i+1)=(a*b)+(c*d);
 end
 
   [threshIndicator,val]=min(total);
   threshval=(val-1)/256;
   oim=im2bw(f,threshval);
   
   subplot(2,2,2);
   plot(G);
   title('Histogram of an Image');
hold on
line([threshval threshval], ylim, 'LineWidth', 5, 'Color', 'r', 'MarkerSize', 25);

hold off
   subplot(2,2,3);
   imshow(oim); 
   title('Otsu’s Thresholded Image');

 function [load,v]=calculate(x,y) 
     load=sum(H(x:y))/sum(H);
     value=H(x:y).*Index(x:y);
     total=sum(value);
     mean=total/sum(H(x:y));
     if(isnan(mean)==1)
     mean=0;
     end
     
%calculation of Variance
    value2=(Index(x:y)-mean).^2;
     num=sum(value2.*H(x:y));
     v=num/sum(H(x:y));
     if(isnan(v)==1)
         v=0;
     end
 end
 end
     