function [integration] = Simpson38Integration(ctrlPoint,n)
L =0;R=1;
midL = (2*L+R)/3;
midR = (L+2*R)/3;
integration = (norm(Bezierqprime(ctrlPoint,L,n))+3*norm(Bezierqprime(ctrlPoint,midL,n))+3*norm(Bezierqprime(ctrlPoint,midR,n))+norm(Bezierqprime(ctrlPoint,R,n)))/8;
end