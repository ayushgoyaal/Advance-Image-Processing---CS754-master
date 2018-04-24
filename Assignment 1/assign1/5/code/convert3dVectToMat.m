% Convert 3d Vector 3D Matrix
function [mat3d] = convert3dVectToMat(vec,patchSize,noOFFrame)
    patch=zeros(patchSize,patchSize,noOFFrame);
    n=patchSize*patchSize;
    for t=1:noOFFrame
        offset=(t-1)*n;
        patch(:,:,t)=reshape(vec(offset + 1: offset + n),patchSize,patchSize)';
    end
    mat3d=patch;
end

