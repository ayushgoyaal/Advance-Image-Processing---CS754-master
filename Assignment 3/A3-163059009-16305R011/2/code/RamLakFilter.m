function output=RamLakFilter(proj,theta)
    [lenProj,noProj]=size(proj);
    
    outputSize = 2*floor(size(proj,1)/(2*sqrt(2)));    
    
    % creating ramp filter
    order = 2^nextpow2(2*lenProj);
    % order=lenProj;
    filter = 2*[0:(order/2)-1 , (order/2):-1:1 ]'/order;
    
    % inc size of the projection matrix
    proj(size(filter),1)=0;
    % fft of the projection
    projFreq=fft(proj);
    
    filteredProj=zeros(size(filter,1),noProj);
    for i=1:noProj
        filteredProj(:,i)=projFreq(:,i).*filter;
    end
    proj=real(ifft(filteredProj));
    cx=outputSize/2;
    cy=outputSize/2;
    output = zeros(outputSize); 
    ctrId = ceil(lenProj/2);
    
    for t=1:noProj
        projection=proj(:,t);
        projectedAngle=theta(t);
        projectedAngle=projectedAngle*pi/180;
        for x=1:outputSize
            for y=1:outputSize
                l=(x-cx)*cos(projectedAngle)+(y-cy)*sin(projectedAngle);
                l=round(l);
                %fprintf('%d\n',l);
                output(y,x)=output(y,x)+projection(l+ctrId);
            end
        end
    end
   
end