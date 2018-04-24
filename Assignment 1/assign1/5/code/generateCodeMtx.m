% Returns the RANDOM {0,1} coded matrix
function [ output ] = generateCodeMtx(h,w,noOfFrames)
    % Creating Code HxWxT 
    output=randi([0 1],h,w,noOfFrames);
end

