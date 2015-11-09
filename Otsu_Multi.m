clear all;, close all;

filename=sprintf('N2.jpg');
timg=imread(filename);
[ysize xsize col]=size(timg);
if col==3
	timg=rgb2gray(timg);
end

% histogram computation
histogram=zeros(256,1);
for ii = 1 : ysize
	for jj = 1 : xsize
		histogram(timg(ii,jj)+1)=histogram(timg(ii,jj)+1)+1;
	end
end

% multi_thresholding
num=6;
[label, thresholds]=otsu_multi(histogram,num);

% results
figure(1),clf,hold on
figure(1),subplot(1,2,1),imshow(timg);,title('input image');
OUT=zeros(size(timg));
for ii = 1 : ysize
	for jj = 1 : xsize
		if label(timg(ii,jj)+1)>1 & label(timg(ii,jj)+1)<num+1
			OUT(ii,jj)=timg(ii,jj);
		end
	end
end
figure(1),subplot(1,2,2),imshow(OUT./255);,title('num-gradation image');

figure(2),clf,hold on
plot(histogram);,title('histogram');
plot(thresholds,zeros(num,1),'r.');,title('histogram');
