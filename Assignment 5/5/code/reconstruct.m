function [x] = reconstruct(y,phi,mvcovar,stdev,m)
    invMVCovar=inv(mvcovar);
    x=(phi'*phi+stdev.*invMVCovar)\(phi'*y);
end

