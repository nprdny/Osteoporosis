clear all;
close all;
clc;

k = 4; % number of gaussian
F = double(imread('S20.TIF'));
[ysize,xsize,col] = size(F);

if col == 3
	F = rgb2gray(F./255);
end

Fcrop = F(1:end/2, :); % we only need the upper half of the image

H = mean(Fcrop);
H=H'./sum(H);
[n,tmp] = size(H);

T = sum(H);
x = (1:n)';
yoko = 1:0.5:n;

%% initialization membership w

N=zeros(k,1);              % total of membership values
m=zeros(k,1);              % mean value of a gaussian
s=zeros(k,1);              % variance of a gaussian
w=0.1.*rand(n,k); % membership values
t=fix(n./k);

for jj = 1 : k
  w((jj-1)*t+1:jj*t,jj)=1;
end

p=zeros(n,k); % probability of observed values
r=zeros(k,1);        % ratio of gaussian
w=w./repmat(sum(w,2),1,k);
J=0;
b=H;

while(1)
  old_w=w;
  
  figure(1);
  clf;
  hold on;
  box on;
  
  %figure(1),plot(x,b,'g-','LineWidth',1.5);
  
  axis square;
  y=zeros(size(yoko));
  
  for jj = 1 : k
    N(jj)=sum(H.*w(:,jj));
    r(jj)=N(jj)./T;
    m(jj)=sum(b.*w(:,jj).*x)./N(jj);
    s(jj)=sum(b.*w(:,jj).*(x-m(jj)).^2)./N(jj);
    p(:,jj)=exp(-((x-m(jj)).^2)./(2.*s(jj)))./sqrt(2.*pi.*s(jj));
%    J=J+sum((x-m(j)).^2)./(2.*s(j))+n.*log(2.*pi.*s(j))./2;
    tate = r(jj).*exp(-((yoko-m(jj)).^2)./(2.*s(jj)))./sqrt(2.*pi.*s(jj));		
    y = y+tate;
   
    figure(1);
    plot(yoko,tate,'r:','LineWidth',1.5);
    
  end
  
  p=p.*repmat(r',n,1);
  w=p./repmat(sum(p,2),1,k);
  J=norm(old_w-w)^2;
  
  if J<1E-5, break;
  
  end
  
  J;
  pause(0.01);
  
end

figure(1);
plot(yoko,y,'b-','LineWidth',1.5);

figure(1);
plot(H,'g-','LineWidth',1.5);
% % % 
% % % figure(2);
% % % imshow(F);
print('S20_v','-dpng')
