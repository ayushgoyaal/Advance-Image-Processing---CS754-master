% Reconstruct the image
function [outFrames] = reconstruct(snapshot,noOfFrame,codes,patchSize,epsilon)
    % Reconstruct patch wise with overlapping patch
    
    % Init
    [row,col]=size(snapshot);    
    vectorSize=patchSize^2;
    

    %% Creating shi (PatchSize*PatchSize*NoOfFrame) X (PatchSize*PatchSizex*NoOfFrame)
    dct2d=get2dDCT(patchSize,patchSize);
    if noOfFrame==2
        shi=blkdiag(dct2d',dct2d');
    elseif noOfFrame==3         
         shi=blkdiag(dct2d',dct2d',dct2d');        
    elseif noOfFrame==5
        shi=blkdiag(dct2d',dct2d',dct2d',dct2d',dct2d');    
    elseif noOfFrame==7
        shi=blkdiag(dct2d',dct2d',dct2d',dct2d',dct2d',dct2d',dct2d');
    end
    
    %% Reconstruct 
    
    img=zeros(row,col,noOfFrame);
    patchAddedCount=zeros(row,col,noOfFrame);
    for r=1:row-patchSize+1
        %fprintf('r=%d\n',r);
        for c=1:col-patchSize+1
            x1=r;x2=r+patchSize-1;
            y1=c;y2=c+patchSize-1;
            
            pE=snapshot(x1:x2,y1:y2);
            pEVec=reshape(pE',vectorSize,1);
            phi=getPhi(codes,r,c,patchSize);
            A=phi*shi;
            theta=omp(pEVec,A,epsilon);
            xVec=shi*theta;               
            xMat=convert3dVectToMat(xVec,patchSize,noOfFrame);
            for t=1:noOfFrame
                img(x1:x2,y1:y2,t)=img(x1:x2,y1:y2,t)+xMat(:,:,t);
                patchAddedCount(x1:x2,y1:y2,t)=patchAddedCount(x1:x2,y1:y2,t)+1;
            end
        end
    end
    
    % normalizing count
     for t=1:noOfFrame
           img(:,:,t)=img(:,:,t)./patchAddedCount(:,:,t);
     end
     outFrames=img;
end



