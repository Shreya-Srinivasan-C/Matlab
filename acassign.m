clc; clear all; close all;
% Parameters
fm1 = 2.5e3;         % Frequency of message signal 1 (Hz)
fm2 = 3.3e3;         % Frequency of message signal 2 (Hz)
Fc = 001e6;          % Carrier frequency (Hz)
Am = 1;              % Amplitude of the message signal
T = 1 / min(fm1, fm2); % Period of the message signal
Fs = 15 * max(fm1, fm2); % Sampling frequency
t = 0:1/Fs:15*T;     % Time vector
N = length(t);       % Length of the time vector
% Message signal generation
sigx = Am * cos(2*pi*fm1*t) + Am * cos(2*pi*fm2*t);
% Carrier signal
ct = cos(2*pi*Fc*t);
% SSB-SC modulation
sigxm = real(hilbert(sigx).*exp(sqrt(-1)*2*pi*Fc*t));
% Coherent demodulation
demodulated_signal = sigxm .* ct;
% Low-pass filtering
fcut = 2*fm1; % Cut-off frequency for the low-pass filter
[b, a] = butter(6, fcut/(Fs/2)); % 6th order Butterworth filter
filtered_signal = filter(b, a, demodulated_signal);
% Plotting
figure
subplot(311)
plot(t, sigx, 'r', 'Linewidth', 2)
xlabel('Time'); ylabel('Message Signal Amplitude');title('Message Signal')
grid on
subplot(312)
plot(t, sigxm, 'Linewidth', 2)
hold on;
plot(t, ct, 'r', 'Linewidth', 2)
xlabel('Time'); ylabel('Modulated Signal Amplitude'); title('SSB-SC Modulated Signal')
legend('SSB-SC Modulated Signal', 'Carrier Signal')
grid on
subplot(313)
plot(t, filtered_signal, 'Linewidth', 2)
xlabel('Time'); ylabel('Demodulated Signal'); title('Demodulated Signal')
grid on
% Frequency Domain Analysis
SigX = (1/N) * fftshift(fft(sigxm));
f = linspace(-Fs/2, Fs/2, N);
figure
plot(f, abs(SigX), 'Linewidth', 2);
xlabel('Frequency (Hz)'); ylabel('Magnitude Spectrum'); title('Magnitude Spectrum of Modulated Signal')
grid on