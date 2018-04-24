function [correctRate] = nearestNeighbour(trainAlpha,trainLabel,testAlhpa,testLabel)
    correctCount=0;
    for i=1:size(testAlhpa,2);
        diff=bsxfun(@minus,trainAlpha,testAlhpa(:,i));
        [minval,idx]=min(sum(diff.^2));
        if(trainLabel(idx)==testLabel(i))
            correctCount=correctCount+1;
        end
    end
    correctRate=correctCount/size(testAlhpa,2);
    correctRate=correctRate*100;
end

