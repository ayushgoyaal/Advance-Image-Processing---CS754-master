% Generate Multivarient Covarience matrix
function [ mvcovar ] = multivarientCoVar(mtxsize,alpha)
    rng(1)
    % Creating Non-sigular matrix
    mtx=randn(mtxsize);
    
    % Creating Orthonormal U  
    [u,~,~]=svd(mtx);
    eigVal=[1:mtxsize];
    eigVal=eigVal.^(-alpha);
    eigVal=diag(eigVal);
    mvcovar=u*eigVal*u';    
end

