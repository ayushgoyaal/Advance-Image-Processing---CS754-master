function [f1Sepr,f2Sepr]=findSepr(f,A1i,A2)
    nItter=100;
    theta2=randn(256,1);
    f2Sepr=A1i*theta2;
    for i=1:nItter
        % f2Sepr fixed
        y=f-f2Sepr;
        f1Sepr=ompInterBased(y,A2,0.001,10);
        
        % f1Sepr fixed
        y=f-f1Sepr;
        f2Sepr=ompInterBased(y,A1i,0.001,10);
    end
end