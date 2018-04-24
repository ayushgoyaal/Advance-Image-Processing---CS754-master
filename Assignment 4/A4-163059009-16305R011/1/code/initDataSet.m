function [y,phi,phiTphi,stdev] = initDataSet(X,p,N,m,f)
    %% Creating Phi
    phi=zeros(m,p,N);
    stdev=zeros(N,1);
    y=zeros(m,N);
    for i=1:N
        ithPhi=randi([0,1],[m,p]);
        ithPhi(ithPhi==0)=-1;
        ithPhi=ithPhi.*(1/ sqrt(m));
        phi(:,:,i)=ithPhi;
    end
    
    %% Finding Phi^2
    phiTphi=cell(N,1);
    for i=1:N        
        phiTphi{i}=phi(:,:,i)'*phi(:,:,i);
    end
    %% Creating Y
    stdev=0;normSum=0;
    for i=1:N
        tempY=phi(:,:,i)*X(:,i);
        normSum=normSum+norm(tempY,1);       
    end
    stdev=f*(1/(m*N))*normSum;
    for i=1:N
        tempY=phi(:,:,i)*X(:,i);
        %noise=rand([m,1]).*stdev(i);
        noise=randn(m,1).*stdev;        
        y(:,i)=tempY+noise;
        %y(:,i)=tempY;
    end

end
