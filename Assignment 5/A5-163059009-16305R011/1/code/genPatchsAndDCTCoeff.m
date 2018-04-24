function [imgvec,dctCoffvec]=genPatchsAndDCTCoeff(img,pSize)
    [rows,cols]=size(img);
    totalPatch=ceil((rows*cols)/(pSize*pSize));
    imgvec=zeros(pSize*pSize,totalPatch);
    dctCoffvec=zeros(pSize*pSize,totalPatch);
    count=1;
    for i=1:pSize:rows-pSize
        for j=1:pSize:cols-pSize
            patchImg=img(i:i+pSize-1,j:j+pSize-1);
            dctCoff=dct2(patchImg);
            imgvec(:,count)=reshape(patchImg,pSize*pSize,1);
            dctCoffvec(:,count)=reshape(dctCoff,pSize*pSize,1);                        
            count=count+1;
        end
    end
end