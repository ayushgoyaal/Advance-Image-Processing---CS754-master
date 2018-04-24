% Fetches the 'noOfFrames' frames from video of dim HxW
function [ frame ] = fetchFrames(video,noOfFrames,h,w)    
    vH=video.height;
    vW=video.width;
    frameTotal=video.frames;
    frame=zeros(h,w,noOfFrames);
    for i=1:noOfFrames   
        img=rgb2gray(frameTotal(i).cdata);    
        frame(:,:,i)=img(vH-h+1:vH,vW-w+1:vW);
    end        
end


