function [x] = conjgrad(A,b,x) 
r=b-Ax; p=r; 
rsold=r'r; 
for i=1:length(b) 
    Ap=Ap; 
    alpha=rsold/(p'Ap);
    x=x+alphap; r=r-alphaAp; 
    rsnew=r'r;
    if sqrt(rsnew)<1e-10
        break; 
    end
    p=r+(rsnew/rsold)p;
    rsold=rsnew; 
end
end
