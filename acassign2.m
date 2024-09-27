clc; clear all; close all;
% Parameters
fm1 = 2.5e3;    % Frequency of message signal 1
fm2 = 3.3e3;    % Frequency of message signal 2
Fc = 1e6;       % Carrier frequency
Am = 1;         % Amplitude of message signal
T = 1 / min(fm1, fm2);  % Minimum period between message signals
Fs = 15 * max(fm1, fm2); % Sampling frequency
t = 0:1/Fs:10*T; % Time vector
N = length(t);  % Length of the signal
% Message signal generation
sigx = Am * cos(2*pi*fm1*t) + Am * cos(2*pi*fm2*t);
% Carrier signal
ct = cos(2*pi*Fc*t);
% DSB-SC modulation
dsbsc = sigx .* ct;
% Butterworth bandpass filter design
[b, a] = butter(6, [fm1,fm2]/(Fs/2)); % 6th order Butterworth filter
% Filter the DSB-SC modulated signal
filtered_signal = filter(b, a, dsbsc);
% Plotting
figure;
subplot(3,1,1);
plot(t, sigx, 'r', 'Linewidth', 2);
xlabel('Time'); ylabel('Message Signal Amplitude'); title('Original Message Signal'); grid on;
subplot(3,1,2);
plot(t, dsbsc, 'Linewidth', 2);
xlabel('Time'); ylabel('DSB-SC Signal Amplitude'); title('DSB-SC Modulated Signal'); grid on;
subplot(3,1,3);
plot(t, filtered_signal, 'Linewidth', 2);
xlabel('Time'); ylabel('SSB-SC Signal Amplitude'); title('SSB-SC Modulated Signal after Bandpass filter'); grid on;
% Frequency Domain Analysis
SigX = (1/N) * fftshift(fft(filtered_signal));
fr = linspace(-Fs/2, Fs/2, N);
figure
plot(fr/1000, abs(SigX), 'Linewidth', 2);
xlabel('Frequency (kHz)'); ylabel('Magnitude Spectrum'); title('Frequency Spectrum of SSB-SC Modulated Signal'); grid on