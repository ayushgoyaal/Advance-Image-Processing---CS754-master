function [newtheta]=ISTA(y,A,lambda,convergeVal,alphaAdd)
    [row,col]=size(A);
    theta=zeros(col,1);
    newtheta=abs(2.*rand(col,1)-1);
    k=0;
    alpha=eigs((A'*A),1)+alphaAdd;            % +100;
    % disp(norm(theta)-norm(newtheta));
    while(abs(norm(theta)-norm(newtheta))>convergeVal)            %0.001
        theta=newtheta;
        newtheta=theta+(1/alpha).*(A'*(y-A*theta));
        newtheta=soft(newtheta,(lambda/(2*alpha)));
        k=k+1;
        %J = sum(abs(A*theta(:)-y(:)).^2) + lambda*sum(abs(theta(:)));
        %fprintf('itter=%d   diff=%f\n  ' ,k,abs(norm(theta)-norm(newtheta)));
    end
end


function y=soft(y,lambda)
    dim=size(y);
    y((abs(y)-lambda)<0)=0;
    for i=1:1:dim
        if(y(i)>=lambda)
            y(i)=y(i)-lambda;
        elseif(y(i)<=(-1*lambda))
            y(i)=y(i)+lambda;
        end
    end
    
end