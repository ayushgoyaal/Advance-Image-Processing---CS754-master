function [f1Sepr,f2Sepr]=findSepratedSignals(f,A1,A2,T0)
    rng(1,'twister');
    theta2=randn(128,1);
    f2Sepr=A2*theta2;
    change=10^5;oldError=0;epsilon=1e-3;
    while change> epsilon        
        % f2Sepr fixed
        y=f-f2Sepr;
        theta1=ompInterBased(y,A1,T0);
        f1Sepr=A1*theta1;
        % f1Sepr fixed
        y=f-f1Sepr;
        [theta2]=ompInterBased(y,A2,T0);
        f2Sepr=A2*theta2;
        error=norm(y-(f1Sepr+f2Sepr));
        change=abs(oldError-error);
        %fprintf('error:%f\tchange:%f\n',error,change);        
        oldError=error;
    end
end