% Return "Patched Phi"
function [phi]=getPhi(codes,r,c,patchSize)
    noOfCode=size(codes,3);
    n=patchSize*patchSize;
    phi=[];
    for ci=1:noOfCode;
        codePatch=codes(r:r+patchSize-1,c:c+patchSize-1,ci);
        phi=horzcat(phi,diag(reshape(codePatch',1,n)));
    end    
end
