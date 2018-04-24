% Returns the RMSE between two images
function [ rmse ] = getRMSE(img1,img2 )
    errorDiffSqr=(img1-img2).^2;
    rmse=sqrt(sum(errorDiffSqr(:))./(size(img1,1)*size(img1,2)));    
end

