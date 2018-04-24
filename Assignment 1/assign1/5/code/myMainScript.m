%% Assignment1-5: Compressive Video Acquisition using coded snapshot
% * Rollno: 163059009, 16305R011

%% Init
% adding path for MMREAD
addpath('../MMread');
file='../input/cars.avi';
video=mmread(file,1:10,[],false,true);
H=120;W=240;

%% 1. Part(a) Fetch T=3 frames
T=3; %no.of frames
frame=fetchFrames(video,T,H,W) ; 

%% 2. Creating Random Code Matrix 

C=generateCodeMtx(H,W,T);

%% 2.1 Creating Coded Snapshot

noiseStd=2.0;
E=generateCodedSnapshot(frame,C,noiseStd);

%% 2.2 Showing the "Coded snapshot"

figure('name','Coded snapshot with noise');
imshow(E/max(E(:)));
title('\fontsize{10}{\color{magenta}Coded snapshot with noise for T=3}');
axis tight,axis on;


%% 3. Part(c): Equation in the form $Ax = b$
%
% C(t): Code for the 't' frame where $t:1 \rightarrow T$
%
% E: Coded Snapshot
% 
% Objective: Estimate $F_t$ of original video where $t:1 \rightarrow T$
% 
% We can write our coded Snapshot equation as Ax=b 
%
% Here, $E= C_1.*F_1 + C_2.*F_2 + \cdots + C_T.*F_T$
% 
% We can write $F_t=\Psi * \theta_t$
% 
% Let $\phi_1 = C_1 , \phi_2 = C_2 \cdots \phi_t = C_t$
% 
% Therefore, $\Phi = [  diag(\phi_1) | diag(\phi_2) | \cdots | diag(\phi_T)
% ]$
% 
% We get $\Phi$ dimension as NxNT where N is the no. of pixel
% 
% Let $F_t$ = Col Vector of Pixels,  then 
% 
% $F = [ F_1^t , F_2^t , \cdots ,  F_T^t,]^t$
% 
% $E= \Phi * \Psi * F$ , 
% 
% where $\Psi$  can be 3D-DCT of NTxNT or Block diagonal of 2D-DCT per frame 
%
% In our we are taking, $\Psi$ as  Block diagonal of 2D-DCT per frame but
% for 8x8 patches
%
% Therefore here, b = E, x = F and A =  $\Phi * \Psi$


%% 4. Part(d & e): Reconstruction
% *Part(d)*
% 
% As in above mentioned i.e 'section 3' the dimentsion of A,b,x are very
% large to compute in one go in limited harware system. So to solve this
% problem we will do patchwise i.e by taking 8x8 overlapping patching. 
%
% Let *P* be the some patch of dim 8x8 cornered at top-left at point (x1,y1)
%
% Let $F_t$ = Col. vector of pixels for P, so the dimension of
% $F_t$ is 64x1
% 
% $F = [ F_1^t , F_2^t , \cdots ,  F_T^t,]^t$ having dimension  64Tx1
% 
% Let $Cp(t)$: Code for patch, cornered at top-left at point (x1,y1) for the 't' frame 
% where $t:1 \rightarrow T$
% 
% So the dimension of $C_p(t)$ is 8x8
% 
% Let $\phi_1 = Cp_1 , \phi_2 = Cp_2 \cdots \phi_t = Cp_t$
% 
% Therefore, $\Phi = [  diag(\phi_1) | diag(\phi_2) | \cdots | diag(\phi_T)
% ]$
% 
% We get $\Phi$ dimension as 64x64T where 64 is the no. of pixel in the
% patch
%
% Each 8x8 patch is sparse in 2D-DCT. So we create $\psi$ as 2d dct of
%  64x64
%
% Therefore, $\Psi$ = Block diagonal of 2D-DCT per frame, dimension $\Psi$ 64Tx64T 
% 
% So, *A*= $\Phi * \Psi$
%
% Let *b* is vectorised form the patch taken from the *Coded Snapshot (E)*
% cornered at top-left point (x1,y1)
%
% Therefore, we have solve $Ax = b$, where x= F 


tic
patchSize=8;ompEpsilon=6;
[outputImg]=reconstruct(E,T,C,patchSize,ompEpsilon);
toc

%% 4.1 Showing o/p
for i=1:T
    figure('name','Result T=3');
    
    % Original    
    subplot(1,2,1);
    imshow(frame(:,:,i),[]);
    label= sprintf('\\fontsize{10}{\\color{red} Orginal T=3: Frame %d}',i);
    title(label);   
    
    % Reconstruction       
    subplot(1,2,2);
    imshow(outputImg(:,:,i),[]);
    label= sprintf('\\fontsize{10}{\\color{magenta} Reconst. T=3: Frame %d}',i);
    title(label);      
    
end
%% 5. Video Acquisition and Reconstuction for # of Frames 5

T=5; %no.of frames
frame=fetchFrames(video,T,H,W) ; 
C=generateCodeMtx(H,W,T);
noiseStd=2.0;

% Create Coded Snapshot
E=generateCodedSnapshot(frame,C,noiseStd);

figure('name','Coded snapshot with noise');
imshow(E/max(E(:)));
title('\fontsize{10}{\color{magenta}Coded snapshot with noise for T=5}');
axis tight,axis on;

% Reconstruction using C.S
tic
patchSize=8;ompEpsilon=6;
[outputImg]=reconstruct(E,T,C,patchSize,ompEpsilon);
toc

%  Showing o/p
for i=1:T
    figure('name','Result T=5');
    
    % Original    
    subplot(1,2,1);
    imshow(frame(:,:,i),[]);
    label= sprintf('\\fontsize{10}{\\color{red} Orginal T=5: Frame %d}',i);
    title(label);   
    
    % Reconstruction       
    subplot(1,2,2);
    imshow(outputImg(:,:,i),[]);
    label= sprintf('\\fontsize{10}{\\color{magenta} Reconst. T=5: Frame %d}',i);
    title(label);      
    
end

%% 6. Video Acquisition and Reconstuction for # of Frames 7

T=7; %no.of frames
frame=fetchFrames(video,T,H,W) ; 
C=generateCodeMtx(H,W,T);
noiseStd=2.0;

% Create Coded Snapshot
E=generateCodedSnapshot(frame,C,noiseStd);

figure('name','Coded snapshot with noise');
imshow(E/max(E(:)));
title('\fontsize{10}{\color{magenta}Coded snapshot with noise for T=7}');
axis tight,axis on;

% Reconstruction using C.S
tic
patchSize=8;ompEpsilon=6;
[outputImg]=reconstruct(E,T,C,patchSize,ompEpsilon);
toc

%  Showing o/p
for i=1:T
    figure('name','Result T=5');
    
    % Original    
    subplot(1,2,1);
    imshow(frame(:,:,i),[]);
    label= sprintf('\\fontsize{10}{\\color{red} Orginal T=7: Frame %d}',i);
    title(label);   
    
    % Reconstruction       
    subplot(1,2,2);
    imshow(outputImg(:,:,i),[]);
    label= sprintf('\\fontsize{10}{\\color{magenta} Reconst. T=7: Frame %d}',i);
    title(label);      
    
end
