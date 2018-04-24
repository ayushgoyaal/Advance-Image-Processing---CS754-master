
% Reconstruct the image
function [outFrame] = reconstruct(img,patchSize,lambda,convergeVal,alphaAdd)
    % Reconstruct patch wise with overlapping patch
    % Init
    [row,col]=size(img);    
    vectorSize=patchSize^2;
    % 2D basis
    shi=kron(dctmtx(8),dctmtx(8))';
    % figure;imshow(shi);
    
    %% Reconstruct 
    imgReconstruct=zeros(row,col);
    patchAddedCount=zeros(row,col);
    % Finding alpha
    A=shi;
    alpha=eigs((A'*A),1)+alphaAdd;  
    for r=1:row-patchSize+1
        fprintf('r=%d\n',r);
        for c=1:col-patchSize+1
            %fprintf('c=%d\n',c);
            x1=r;x2=r+patchSize-1;
            y1=c;y2=c+patchSize-1;           
            pE=img(x1:x2,y1:y2);
            pEVec=reshape(pE',vectorSize,1);            
            
            theta=ISTA(pEVec,A,lambda,convergeVal,alpha);
            
            xVec=shi*theta;               
            xMat=reshape(xVec(:),patchSize,patchSize)';
            imgReconstruct(x1:x2,y1:y2)=imgReconstruct(x1:x2,y1:y2)+xMat(:,:);
            patchAddedCount(x1:x2,y1:y2)=patchAddedCount(x1:x2,y1:y2)+1;
        end
    end
    
    % normalizing count
    imgReconstruct(:,:)=imgReconstruct(:,:)./patchAddedCount(:,:);
    outFrame=imgReconstruct;
end

