% Returns the "coded snapot" for Video Acquisition using Compressed sensing
function [ output ] = generateCodedSnapshot(frame,code,noiseStd)
    [h,w,noOfFrames]=size(frame);
    E=zeros(h,w);%coded snapshot 
    % noiseStd : gaussian  standard deviation
    noise=rand([h,w])*noiseStd;
    for i=1:noOfFrames
        E=E+frame(:,:,i).*code(:,:,i);
    end
    % adding noise;
    E = E + noise; 
    output = E;
end

