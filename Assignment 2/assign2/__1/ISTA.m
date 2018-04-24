function [newtheta]=ISTA(y,A,lambda,convergeVal,alpha)
    [row,col]=size(A);
    theta=zeros(col,1);
    newtheta=abs(2.*rand(col,1)-1);
    k=0;    
    %alpha=eigs((A'*A),1)+alphaAdd;   
    % disp(norm(theta)-norm(newtheta));
    error=norm(theta-newtheta);
    while(error>convergeVal)            %0.001
        theta=newtheta;
        predictY=A*theta;
        fun=theta+(1/alpha).*(A'*(y-predictY));
        newtheta=soft(fun,(lambda/(2*alpha) ));
        error=norm(theta-newtheta);
        %fprintf('Error: %f \n',error);
        k=k+1;
        %J = sum(abs(A*theta(:)-y(:)).^2) + lambda*sum(abs(theta(:)));
        %fprintf('itter=%d   diff=%f\n  ' ,k,abs(norm(theta)-norm(newtheta)));
    end
end

% Soft Thershold Function
function y=soft(y,lambda)
    dim=size(y);
    %y((abs(y)-lambda)<0)=0;    
    for i=1:1:dim
        if(y(i)>=lambda)
            y(i)=y(i)-lambda;
        elseif(y(i)<=(-1*lambda))
            y(i)=y(i)+lambda;
        else 
             y(i)=0;
        end
    end
    
end