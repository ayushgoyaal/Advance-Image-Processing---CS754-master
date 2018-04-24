% root mean sq error
function [ output ] = rmse(m1,m2)
    n=numel(m1);
    diff=abs(m1-m2);
    diffSq=diff.^2;
    mse=sum(diffSq(:))/n;
    output=sqrt(mse);
end

