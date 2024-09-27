clc;
clear all;
close all;

x = input('Enter the input sequence = ');
h = input('Enter the impulse response sequence = ');

N1 = length(x);
N2 = length(h);

N = max(N1,N2);

newx = [x zeros(1,N-N1)];
newh = [h zeros(1,N-N2)];

xdft = fft(newx);
hdft = fft(newh);

ydft = (xdft.*hdft);
y =ifft(ydft);
disp(y);
figure(1);

subplot(3,1,1);
n = 0:N1-1;
stem(n,x);
title('x(n) sequence');
xlabel('n-->');
ylabel('Amplitude');

subplot(3,1,2);
n = 0: N2-1;
stem(n,h);
title('h(n) sequence');
xlabel('n-->');
ylabel('Amplitude');

subplot(3,1,3);
n = 0:N-1;
stem(n,y);
title('y(n) sequence');
xlabel('n-->');
ylabel('Amplitude');