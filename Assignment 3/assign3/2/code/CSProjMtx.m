classdef CSProjMtx    
    properties        
        transpose = 0;
        theta = []; 
        noOfAngle=0;
        n=0;
        m=0;
        h=0;
        w=0;
    end    
    methods      
       function obj = CSProjMtx(m,n,theta)            
            obj.m=m;
            obj.n=n;
            obj.h=round(sqrt(n));
            obj.w=round(sqrt(n));
            obj.theta=theta;            
            obj.noOfAngle=numel(theta);
       end
       %  operator * overloading
       function result = mtimes(obj,beta)
            angles=obj.theta;
            if obj.transpose == 0 % A.beta = R.U.Beta= R.x  
                dctCoffMat=reshape(beta,obj.h,obj.w);                
                x=idct2(dctCoffMat);
                Ax=radon(x,angles);
                result=reshape(Ax,obj.m*obj.noOfAngle,1);
            else %At.beta
                % Rt = iradon                
                projectionMat=reshape(beta,obj.m,obj.noOfAngle);
                Atx=dct2(iradon(projectionMat,angles,'linear','Ram-Lak',1,obj.h));               
                result=reshape(Atx,obj.n,1);
            end
       end  
       %  operator ' overloading
       function  updatedObj = ctranspose(obj)
           obj.transpose=xor(obj.transpose,1);   
           updatedObj=obj;
       end
    end    
end

