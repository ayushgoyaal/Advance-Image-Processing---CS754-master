% Gives the 3D DCT Matrix
function [dct2dMtx]=get3dDCT(M,N,T)
    %c=reshape(b*reshape(a',4,1),2,2)'
    d=M*N;
    dct2dMtx=zeros(d*T,d*T);
    r=1;
    for w=1:T
        if (w-1) == 0
            c3=sqrt(1/T);
        else
            c3=sqrt(2/T);
        end    
        for u=1:M
            if (u-1) == 0
                c1=sqrt(1/M);
            else
                c1=sqrt(2/M);
            end
            for v=1:N
                if (v-1) == 0
                    c2=sqrt(1/N);
                else
                    c2=sqrt(2/N);
                end        
                c=1;
                for t=1:T                
                    for m=1:M                           
                        for n=1:N
                         val=c1*c2*c3*cos( (pi*(2*(m-1)+1)*(u-1) )/(2*M) )...
                                * cos( (pi*(2*(n-1)+1)*(v-1) )/(2*N) ) ...
                                * cos( (pi*(2*(t-1)+1)*(w-1) )/(2*T) );                        
                         dct2dMtx(r,c)=val;
                         c=c+1;
                        end
                    end
                end
                r=r+1;
            end
        end
    end
end