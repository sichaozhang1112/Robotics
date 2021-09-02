function [ L,U ] = LUsolver( A )
    n = size(A,1);
    L = zeros(n,n);
    U = zeros(n,n);
    for k = 1 : n
        for j = k : n
            U(k,j) = A(k,j);
            if k > 1
                for i = 1 : k-1
                    U(k,j) = U(k,j)-L(k,i)*U(i,j);
                end
            end
        end
        for i = k : n
            L(i,k) = A(i,k);
            if k > 1
                for j = 1 : k-1
                    L(i,k) = L(i,k)-L(i,j)*U(j,k);
                end
            end
            L(i,k) = L(i,k)/U(k,k);
        end
    end        
end