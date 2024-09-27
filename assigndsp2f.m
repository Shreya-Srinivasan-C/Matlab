clc; 
close all; 
clear all;

% B2.1 Plot the signals x1, x2, x3, y, and noise x4.

fs = 20*90; % Sampling frequency
t = 0:1/fs:1; % Time vector
x1 = 4*sin(2*pi*10*t); % Signal 1
x2 = 3*sin(2*pi*60*t); % Signal 2
x3 = 1*sin(2*pi*95*t); % Signal 3
y1 = x1 + x2 + x3; % Combined signal without noise
SNR = 10; % Signal-to-Noise Ratio
x4 = awgn(zeros(size(y1)), SNR); % Additive white Gaussian noise
y = x1 + x2 + x3 + x4; % Combined signal with noise
N = length(y); % Length of the signal
% Plotting signals
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

% B2.2 Plot the FFT of y

yt = (fft(y))/N; % Compute the FFT of the signal
f = linspace(-fs/2, fs/2, N); % Frequency vector
fig2 = figure;
plot(f, abs(yt));
title('Fourier Transform of y'); xlabel('Frequency'); ylabel('Magnitude spectrum of y');

% B2.3 Design a lowpass FIR filter to attenuate x3 (Use MATLAB fdatool)

load lpfir.mat % Load filter coefficients
g = filter(Num, 1, y); % Apply the filter to the signal
U = length(g); % Length of the filtered signal
gf = fft(g)/N; % Compute the FFT of the filtered signal
% Plotting filtered signal in time domain
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

% B2.4 Plot the filtered signal in the frequency domain

fig4 = figure;
plot(f, abs(gf))
title('Filtered Signal in Frequency Domain'); xlabel('Frequency'); ylabel('Magnitude spectrum of Filtered signal');






































