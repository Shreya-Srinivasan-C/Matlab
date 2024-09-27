clc;clear all; close all;
x = input('enter the first sequence x(n) = ');
h = input('enter the second sequence h(n) = ');
Xlen = length(x);
Hlen = length(h);

n = 0: 1: Xlen-1;
subplot(4,1,1);
stem(n,x,'filled');
title('input sequence');
xlabel('n-->'); 
ylabel('x(n)-->');
grid on;
n=0:1:Hlen-1;
subplot(4,1,2);
stem(n,h,'filled');
title('impulse sequence'); 
xlabel('n-->'); 
ylabel('h(n)-->');
grid on;

y = conv(h,x);
disp(y);
Ylen = Xlen+Hlen-1;
n = 0:1:Ylen-1;
subplot(4,1,3);
stem(n,y,"filled")
title('linear convolution of x(n)*h(n)'); 
xlabel('n-->'); 
ylabel('y(n)-->');
grid on;

N = max(Xlen,Hlen);
y1 = cconv(h,x,N);
disp(y1)
n=0:1:N-1;
subplot(4,1,4);
stem(n,y1,"filled"); 
title('circular convolution of x(n)*h(n)');
xlabel('n-->');
ylabel('y(n)-->');
grid on;