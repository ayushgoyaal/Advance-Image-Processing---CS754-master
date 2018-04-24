% Returns the 2d DCT matrix
function [dct2dMtx]=get2dDCT(M,N)
    d=round(M*N);
    dct2dMtx=zeros(d,d);
    r=1;
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
            for m=1:M                           
                for n=1:N
                 val=c1*c2*cos( (pi*(2*(m-1)+1)*(u-1) )/(2*M) ) * cos( (pi*(2*(n-1)+1)*(v-1) )/(2*N) );
                 dct2dMtx(r,c)=val;
                 c=c+1;
                end
            end
            r=r+1;
        end
    end
end

