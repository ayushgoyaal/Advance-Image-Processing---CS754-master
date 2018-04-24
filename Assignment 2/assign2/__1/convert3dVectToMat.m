% Convert 3d Vector 3D Matrix
function [mat3d] = convert3dVectToMat(vec,patchSize)
    patch=zeros(patchSize,patchSize);
    n=patchSize*patchSize;
    for t=1:noOFFrame
        offset=(t-1)*n;
        patch(:,:)=reshape(vec(1:n),patchSize,patchSize)';
    end
    mat3d=patch;
end
