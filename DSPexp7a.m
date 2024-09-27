clc;
clear ;
close all;
x=input("Enter the sequence x = ");
N=length(x);
n=0:N-1;
X=zeros(1,N);
for k=0:N-1
    W=exp((-1i)*2*pi*k*n/N);
    dprod=x.*W;
    X(k+1)=sum(dprod);
    disp(X(k+1));
end
magX=abs(X);
phazX=angle(X);
figure(1);
subplot(2,1,1);
n=0:N-1;
stem(n,magX);
title('magnitude of X(k)');
xlabel('n-->');
ylabel('magnitude');
subplot(2,1,2);
n=0:N-1;
stem(n,phazX);
title('phase of X(k)');
xlabel('n-->');
ylabel('phase');