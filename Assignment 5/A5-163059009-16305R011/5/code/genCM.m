% Generate Compressive Measurement
function [y,phi,stdev] = genCM(X,m,n)
    %% INIT
    f=0.01; % fraction of sigma
    noOfSample=size(X,1);
    %% Creating Phi
    y=zeros(m,noOfSample);
    tempPhi=randi([0,1],[m,n]);
    tempPhi(tempPhi==0)=-1;
    phi=tempPhi.*(1/ sqrt(m));

    %% Creating Y
    normSum=0;
    for i=1:noOfSample
        tempY=phi*X(i,:)';
        normSum=normSum+mean(tempY,1);       
    end
    stdev=f*(1/(noOfSample))*abs(normSum);
    
    for i=1:noOfSample
        tempY=phi*X(i,:)';
        noise=randn(m,1).*stdev;        
        y(:,i)=tempY+noise;
        %y(:,i)=tempY;
    end

end
