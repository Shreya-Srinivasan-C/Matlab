clc;
clear all;
close all;
N = input('desire impulse response length N = ');
b = input('coefficients of x(n) numerator b = ');
a = input('coefficients of y(n) denominator a = ');
h = impz(b,a,N);
disp('impulse response is ');
disp(h);
n = 0:1:N-1;
stem(n,h)
xlabel('time index');
ylabel('amplitude');
title('impulse response h(n)');