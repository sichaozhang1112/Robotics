%线性代数运算 
A = rand(6,6);
B = rand(6,1);
X_t = inv(A)*B;
[ L,U ] = LUsolver( A );
[ X,Y ] = Xsolver( L,U,B );
X-X_t

