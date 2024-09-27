clc; 
close all; 
clear all;

%B2.1 Plot the signals x1, x2, x3, y and noise x4.
fs = 20*90; 
t = 0:1/fs:1; 
x1 = 4*sin(2*pi*10*t);
x2 = 3*sin(2*pi*60*t);
x3 = 1*sin(2*pi*95*t);
y1 = x1 + x2 + x3;
SNR = 10; 
x4 = awgn(zeros(size(y1)), SNR);
y = x1 + x2 + x3+ x4;
N = length(y);

fig1 = figure;
subplot(3, 2, 1);
plot(t, x1);
title('Signal x1'); xlabel('Time'); ylabel('Amplitude of x1');
subplot(3, 2, 2);
plot(t, x2);                    
title('Signal x2'); xlabel('Time'); ylabel('Amplitude of x2');
subplot(3, 2, 3);
plot(t, x3);
title('Signal x3'); xlabel('Time'); ylabel('Amplitude of x3');
subplot(3, 2, 4);
plot(t, y);
title('Signal y'); xlabel('Time'); ylabel('Amplitude of y');
subplot(3, 2, 5);
plot(t, x4);
title('Signal x4 (AWGN Noise)'); xlabel('Time'); ylabel('Amplitude of x4');

%B2.2 Plot the fft of y and analyse the same using Matlab.
yt = (fft(y))/N;
f = linspace(-fs/2, fs/2, N);
fig2 = figure;
plot(f, abs(yt));
title('Fourier Transform of y'); xlabel('Frequency'); ylabel('Magnitude spectrum of y');

%B2.3 Design a lowpass FIR filter to attenuate x3 (Use MATLAB fdatool) .
load lpfir.mat
g = filter(Num, 1, y);
U = length(g);
gf = fft(g)/N;

fig3 = figure;
subplot(3,1,1);
plot(t,y,t,g);
title('Comparison between y and the filtered Signal'); xlabel('Time'); ylabel('Amplitude of y and filtered signal');
subplot(3,1,2);
plot(t,y);
title('Signal y'); xlabel('Time'); ylabel('Amplitude of y');
subplot(3,1,3);
plot(t,g, 'r');
title('Filtered Signal'); xlabel('Time'); ylabel('Amplitude of filtered signal');

%B2.4 Plot the filtered signal in the frequency domain.
fig4 = figure;
plot(f, abs(gf))
title('Filtered Signal in Frequency Domain'); xlabel('Frequency'); ylabel('Magnitude spectrum of Filtered signal');
