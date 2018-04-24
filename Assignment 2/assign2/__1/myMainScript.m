%% MyMainScript
%% Assignment1-5 
% Rollno: 163059009, 16305R011 

%% Init
clear all;
file='barbara256.png';
img=imread(file);
img=double(img);
%%img=im2double(img);


figure('name','Original barbara');
imshow(img,[]);
title('\fontsize{10}{\color{red}noisy barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%% 1. Part (a) y = x + eta  
[H,W]=size(img);

stdDev=10;
NoisyImg=img+getGuassainNoise(H,W,stdDev);
%nimg=NoisyImg(100:200,100:200);
%pimg=img(100:200,100:200);
nimg=NoisyImg;
pimg=img;

figure('name','noisy barbara');
imshow(nimg,[]);
title('\fontsize{10}{\color{red}noisy barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);


figure('name','original barbara');
imshow(pimg,[]);
title('\fontsize{10}{\color{red}noisy barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

%% 1.1 Rescontruction 
patchSize=8; alphaAdd=3.0;
convergeVal=0.1; lambda=30;

outImg=reconstruct(nimg,patchSize,lambda,convergeVal,alphaAdd);

%%
figure('name','outImg barbara');
imshow(outImg,[]);
title('\fontsize{10}{\color{magenta}outImg barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% Mean square error
rmse=getRMSE(outImg,pimg );
fprintf('RMS Error: %f\n',rmse);

%% 2. Part b

[H,W]=size(img);
epsilon=0.039;
patchSize=8;

figure('name','original barbara');
imshow(img,[]);
title('\fontsize{10}{\color{red}noisy barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);


%% Reconstruction 
tic
lambda=1; %0.0039
convergeVal=0.1;
alphaAdd=35.0;
outImg=reconstructb(img,C,patchSize,lambda,convergeVal,alphaAdd);

figure('name','outImg barbara');
imshow(outImg,[]);
title('\fontsize{10}{\color{magenta}outImg barbara}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% Mean square error
rmse=getRMSE(outImg,pimg );
fprintf('RMS Error: %f\n',rmse);
toc

%% 3. Part c
% N : signal length
rng(3,'twister');

N = 100;                            
x = zeros(N,1);
pos=randi([1,100],10,1);
x(pos)=randi([-100,100],10,1);

% Define filter
num = [1, 2, 3, 4, 3, 2, 1]; dnum = 16;                        
hx = filter(num,dnum,x);

%h = filter(b, a, [1 zeros(1,N)]);       % Calculate impulse response.

%randn('state',0);                       % Set seed to example reproducible
noise = 0.05*sum(abs(x))*randn(N,1)/10;
y = hx + noise;

%% Showing Signal
figure('name','Sparse Signal');
plot(x)
title('\fontsize{10}{\color{red}Sparse Signal}');
axis tight,axis on;

figure('name','Convolution Signal');
plot(hx)
title('\fontsize{10}{\color{magenta}Convolution Signal}');
axis tight,axis on;

figure('name','Noisy Signal');
plot(y)
title('\fontsize{10}{\color{magenta}Noisy Signal}');
axis tight,axis on;

%% Creating A matrix

% Deriving H matrix(circulant matrix derived from blur kernel)
NUM=zeros(100,100);
[~,numlen]=size(num);
for i=1:N-numlen+1
    NUM(i,i:numlen+i-1)=num;
end

DNUM=zeros(100,100);
[k,numlen]=size(dnum);
for i=1:N-numlen+1
    DNUM(i,i:numlen+i-1)=dnum;
end


H=DNUM\NUM';


% deconvolution
lam=0.8;
convergeVal=0.0005;
alphaAdd=2.0;
alpha=eigs((H'*H),1)+alphaAdd;  
theta=ISTA(y,H,lam,convergeVal,alpha);


% lam = 2.0;                                      % lam : regularization parameter
% Nit = 100;                                      % Nit : number of iterations
% [x_, cost] = deconvL1(y, lam, num, dnum, 1000 ); 




figure('name','cleaned Signal');
plot(theta)
title('\fontsize{10}{\color{red}cleaned Signal}');
axis tight,axis on;
o1 = get(gca, 'Position');
colorbar(),set(gca, 'Position', o1);

% % 
% % figure('name','x cleaned Signal');
% % plot(x_)
% % title('\fontsize{10}{\color{red}x cleaned Signal}');
% % axis tight,axis on;
% % o1 = get(gca, 'Position');
% % colorbar(),set(gca, 'Position', o1);
