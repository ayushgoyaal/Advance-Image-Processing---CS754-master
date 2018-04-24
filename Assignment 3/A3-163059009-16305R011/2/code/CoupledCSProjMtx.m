classdef CoupledCSProjMtx    
    properties        
        transpose = 0;
        coupleSize=1;
        theta = {};    
        noOfAngle=0;
        n=0;
        m=0;
        h=0;
        w=0;
        mapMtx=[];
    end    
    methods      
       function obj = CoupledCSProjMtx(projSize,h,w,coupleSize,theta)            
            obj.m=projSize;
            obj.noOfAngle=numel(theta{1});
            obj.n=h*w;
            obj.h=h;
            obj.w=w;
            obj.theta=theta;
            obj.coupleSize=coupleSize;            
            
       end
       %  operator * overloading
       function result = mtimes(obj,beta)                        
            if obj.transpose == 0 % A.beta = R.U.Beta= R.x  
                predictY=[];
                betaCell = getBetaMtxFromVec(obj,beta);
                % Going Row by Row
                for i=1:obj.coupleSize
                    betaSum=zeros(obj.h,obj.w);
                    for j=1:i                        
                        betaSum=betaSum+betaCell{j};                       
                    end                    
                    angles=obj.theta{i};                        
                    dctCoffMat=betaSum;
                    x=idct2(dctCoffMat);
                    Ax=radon(x,angles);   
                    predictY=horzcat(predictY,Ax);
                end
                
                result=reshape(predictY,obj.m*obj.noOfAngle*obj.coupleSize,1);
            else %At.beta
                % Rt = iradon     
                yCell = getYMtxFromVec(obj,beta);
                predictBeta=[];        
                for i=1:obj.coupleSize
                    projSum=zeros(obj.h,obj.w); 
                    for j=i:obj.coupleSize                       
                        angles=obj.theta{j}; 
                        projectionMat=yCell{j}; 
                        %x=iradon(projectionMat,angles,'linear','Ram-Lak',1,max(obj.h,obj.w));                        
                        %Atx=dct2(x);
                        Atx=dct2(iradon(projectionMat,angles,'linear','Ram-Lak',1,obj.h));
                        projSum=projSum+Atx;
                    end    
                    predictBeta=horzcat(predictBeta,Atx);
                end
                
                result=reshape(predictBeta,obj.n*obj.coupleSize,1);
            end
       end  
       %  operator ' overloading
       function  updatedObj = ctranspose(obj)
           obj.transpose=xor(obj.transpose,1);           
           updatedObj=obj;
       end
       
       % Decoupl  Coupled Vector Beta into Vector 
       function betaCell = getBetaMtxFromVec(obj,vecBeta)
             betaCell=cell(obj.coupleSize,1);
             vsize=obj.h*obj.w;
             for i=1:obj.coupleSize                
                offset=(i-1)*vsize;
                tbeta=vecBeta(offset+1:offset+vsize,1);
                dctCoffMat=reshape(tbeta,obj.h,obj.w);
                betaCell{i}=dctCoffMat;
             end
       end
       
       % Decoupl Coupled Y into Projection 
       function yCell = getYMtxFromVec(obj,vecY)
             yCell=cell(obj.coupleSize,1);
             vsize=obj.m*obj.noOfAngle;
             for i=1:obj.coupleSize                
                offset=(i-1)*vsize;
                y=vecY(offset+1:offset+vsize,1);
                proj=reshape(y,obj.m,obj.noOfAngle);
                yCell{i}=proj;
             end
       end
    end    
end

