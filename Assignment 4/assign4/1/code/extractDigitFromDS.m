function [sampleImg1,sampleImg2] = extractDigitFromDS(dataset,datasetLabel,downsampleDim,noImgPerDigit,testImgPerDigit )
    imgDim=downsampleDim;
    sampleImg1=zeros(imgDim(1)*imgDim(2),noImgPerDigit*10);
    sampleImg2=zeros(imgDim(1)*imgDim(2),testImgPerDigit*10);
    dpCounter=1;%datapoint
    dpTestCount=1;% for test img
    for i=1:10
        num=i-1;
        idx=find(datasetLabel==num);       
        trainIdx=idx(1:noImgPerDigit);
        testIdx=idx(noImgPerDigit+1:noImgPerDigit+testImgPerDigit);
        for j=1:noImgPerDigit
             img=dataset(:,:,trainIdx(j));
             img1=imresize(img,imgDim(1)/28,'bilinear');
             vImg=reshape(img1,imgDim(1)*imgDim(2),1);
             sampleImg1(:,dpCounter)=vImg;
             dpCounter=dpCounter+1;
        end
        for j=1:testImgPerDigit
             img=dataset(:,:,testIdx(j));
             img1=imresize(img,imgDim(1)/28,'bilinear');
             vImg=reshape(img1,imgDim(1)*imgDim(2),1);
             sampleImg2(:,dpTestCount)=vImg;
             dpTestCount=dpTestCount+1;
        end
    end

end

