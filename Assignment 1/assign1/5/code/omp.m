function [thetaFinal,support]=omp(y,A,eps)
    support=[];
    i=1;r=y;
    [ySize,xSize]=size(A);
   
    % unit normalizing A
    normACol=sqrt(sum(A.^2));
    %normACol=sum(A.^2);    
    uA=bsxfun(@times,A,normACol.^-1);    
    rNorm=norm(r);
    support=[];
    theta=[];
    while(rNorm>eps)    
        %fprintf('%d%f \n',i,norm(r));
        aj=r'*uA;
        [aMax, index]=max( abs(aj) );
        support=[support,index];        
        Ati=A(:,support);
        theta=Ati\y;
        %theta1=inv(Ati'*Ati)*Ati'*y;
        r=y-Ati*theta;
        rNorm=norm(r);
        i=i+1;
    end
    %fprintf('%d    %f \n',i,norm(r));
    thetaFinal=zeros(xSize,1);
    thetaFinal(support)=theta;
end