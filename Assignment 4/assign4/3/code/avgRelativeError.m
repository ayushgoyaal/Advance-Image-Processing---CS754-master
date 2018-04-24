% finds the average relative error
function [totalError] = avgRelativeError(X, predX)
    totalError=0;
    N=size(X,2);
    for i=1:N
        error=norm(X(:,i)-predX(:,i))/norm(X(:,i));
        totalError=totalError+error;    
        %fprintf('%f\n',error);
    end   
    totalError=totalError/N;
end

