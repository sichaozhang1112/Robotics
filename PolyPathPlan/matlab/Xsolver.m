function [ X,Y ] = Xsolver( L,U,B )
    n = size(L,1);
    X = zeros(n,1);
    Y = zeros(n,1);
    
    for k = 1 : n
        Y(k,1) = B(k,1);
        if k > 1
            for j = 1 : k-1
                Y(k,1) = Y(k,1) - L(k,j)*Y(j,1);
            end
        end
    end
    
    for k = n : -1 : 1
        X(k,1) = Y(k,1);
        if k < n
            for j = k+1 : n
                X(k,1) = X(k,1) - U(k,j)*X(j,1);
            end
        end
%         fprintf('k is %d, x is %f\n',k,X(k,1));
        X(k,1) = X(k,1)/U(k,k);
    end
end