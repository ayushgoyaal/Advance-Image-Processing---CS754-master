% It will predict the Digit using Compressed measurement
function [xCoeff] = mnistTestDictionary(y,phi,Dic,K)
    % Init
    N=size(y,2);
    xCoeff=zeros(K,N);
    isSq=size(Dic,1) == size(Dic,2);
    %% Predicting 
    for i=1:N
         A=phi(:,:,i)*Dic;
         if isSq
            v1=omp(y(:,i),A,2);
         else
            v1=ompInterBased(y(:,i),A,5);
         end
         xCoeff(:,i)=v1;
    end
end

