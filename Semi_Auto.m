close all;
clear;
clc;

%---------------Open image-------------------------------------

F = imread('C:\\Users\\AsusPC\\Dropbox\\Kuliah\\Research_Osteoporosis\\Data\\Images\\Data_1\\Osteoporosis\\S9.tif');
[ysize xsize col] = size(F);

if col == 3
    Fcrop = rgb2gray(F); % Converting RGB images to grayscale
end

%---------------Crop image into 2 parts-------------------------------------

Fcrop = F(1:end/2, :); % we only need the upper half of the image
[ysizecrop,xsizecrop,colcrop] = size(Fcrop);

%---------------Crop image into squares (1/5)-------------------------------------

cy = round(ysizecrop./4);
Fcrop = double(Fcrop(1:3*cy,:));

cx = round(xsizecrop./10); % cutting center region
Fcrop(:,cx:9*cx)=[];

Fcrop = Fcrop./255;

[ysizecrop,xsizecrop,colcrop] = size(Fcrop);

%---------------Pre-Processing-------------------------------------

%%% Insert pre-processing algorithm here %%%

%---------------Applying CVE-------------------------------------

Fcve = zeros(ysizecrop,xsizecrop); % cve image

WS=5; % radius of windows
for jj = WS+1 : WS: ysizecrop-WS
    for ii = WS+1 : WS: xsizecrop-WS
        tmp = Fcrop(jj-WS:jj+WS, ii-WS:ii+WS);
        tmp = (tmp-mean(tmp(:)))./(std(tmp(:))+1E-7);
        tmp = tmp-min(tmp(:));
        tmp = tmp./max(tmp(:));
        
        Fcve(jj-WS:jj+WS, ii-WS:ii+WS) = tmp;
        
    end
end

%---------------Displaying ready image-------------------------------------

figure(1)
a=imshow(Fcve);
title('X-Ray Image');

%---------------Applying snake function-------------------------------------

% determining various parameters
alpha = 0.40;
beta = 0.20;
gamma = 1.00;
kappa = 0.15;
weline = 0.30;
weedge = 0.70;
weterm = 0.70;
inter =  200;

% intializing the snake on the image
[xs, ys] = getsnake(Fcve); 

% Making the snake move
interate(Fcve, xs, ys, alpha, beta, gamma, kappa, weline, weedge, weterm, inter);
