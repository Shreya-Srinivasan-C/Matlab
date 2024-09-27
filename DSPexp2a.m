clc;
clear all;
close all;
x = input("enter values for x = ");
y = input("enter values for y = ");
N = length(x);
L = length(y);
M = L-N+1;
[h,r] = deconv(y,x);
disp('impulse response is ')
disp(h)
m = 0:M-1;
stem(m,h)
xlabel('t-->');
ylabel('amplitude');
title('impulse response');