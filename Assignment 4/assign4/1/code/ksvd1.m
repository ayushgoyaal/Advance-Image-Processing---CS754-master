function [D,xCoeff]=ksvd1(y,phi,phiTphi,stdev,p,X,K,epsilon)
    % initialize dict
    [m,N]=size(y);   
    % initialize dict randomly
    D=randn(p,K); % re-initialize dict...size of dict p*K
    for i=1:K;
        D(:,i)=D(:,i)/norm(D(:,i));
    end  
    xCoeff=zeros(K,N);
    %some convergence criterion
    nitter=100;
    %for it=1:nitter
    change=10^4;oldError=0;idx=1;
    while change> epsilon
    %% Step1: sparse coding stage (N signals)
        for i=1:N
            A=phi(:,:,i)*D;            
            xCoeff(:,i)=ompInterBased(y(:,i),A,5);  
        end
    %% Step2: Codebook Update Stage        
        oldD=D;
        oldXCoeff=xCoeff;
        for k=1:K            
            a=zeros(p,p);
            b=zeros(p,1);
            predictedX=D*xCoeff;
            for i=1:N
                if( xCoeff(k,i) ~=0)      
                    a=a+(phiTphi{i}.*(xCoeff(k,i)^2));
                    y_=y(:,i)-phi(:,:,i)*(predictedX(:,i)-(D(:,k).*xCoeff(k,i)));
                    b=b+phi(:,:,i)'*y_.*xCoeff(k,i);
                end
            end
            Dk=a\b;
            Dk=Dk./norm(Dk);  % normalize
            for i=1:N
                if( xCoeff(k,i) ~=0)              
                    y_=y(:,i)-phi(:,:,i)*(predictedX(:,i)-(D(:,k).*xCoeff(k,i)));
                    a=Dk'*phi(:,:,i)'*y_;
                    b=Dk'*phiTphi{i}*Dk;
                    xCoeff(k,i)=a/b;
               end
            end
            D(:,k)=Dk;
        end
        % check
        predX=D*xCoeff;
        rmseD=rmse(oldD,D);
        rmseXCoeff=rmse(oldXCoeff,xCoeff);
        yerr=0;
         for i=1:N
             yerr=yerr+rmse(y(:,i),phi(:,:,i)*predX(:,i));
         end
        yerr=yerr./N;
        change=abs(yerr-oldError);        
        fprintf('%d) rmseD:%d \t rmseXCoeff:%f \t yerr:%f \t change:%f \t AvgRErr:%f\n',idx,rmseD,rmseXCoeff,yerr,change,avgRelativeError(X, predX));
        idx=idx+1;
        oldError=yerr;
    end
end




