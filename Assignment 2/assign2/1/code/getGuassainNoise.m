% Generate IID guassain noise
function noise= getGuassainNoise(row,col,stdDev)    
    %adding noise to an image    
    %rng(0,'twister');
    mean = 0.0;
    sigma = stdDev;
    noise = sigma.*randn(row,col) + mean;    
    %j = imnoise(uint8(img1),'gaussian',0,sigma^2/255^2);
end
