% Clearing previous variables, closing plots, and clearing command window
clear all; close all; clc;

% Parameters
f1 = 2.5e3;         % Frequency of message signal 1 (Hz)
f2 = 3.3e3;         % Frequency of message signal 2 (Hz)
Fc = 37e6;           % Carrier frequency (Hz)
Am = 1;             % Amplitude of the message signal
T = 1 / min(f1, f2); % Period of the message signal
Fs = 15 * max(f1, f2); % Sampling frequency
t = 0:1/Fs:15*T;     % Time vector
N = length(t);       % Length of the time vector

% Message signal generation
sig = Am * cos(2*pi*f1*t) + Am * cos(2*pi*f2*t);

% Carrier signal
ct = cos(2*pi*Fc*t);

% SSB-SC modulation
sigm = real(hilbert(sig).*exp(sqrt(-1)*2*pi*Fc*t));

% Coherent demodulation
demod = sigm .* ct;

% Low-pass filtering
fcut = f1; % Cut-off frequency for the low-pass filter
[b, a] = butter(6, fcut/(Fs/2)); % 6th order Butterworth filter
filtered = filter(b, a, demod);

% Plotting
figure
subplot(311)
plot(t, sig, 'r', 'Linewidth', 2)
xlabel('Time'); ylabel('Message Signal Amplitude');title('Message Signal')
grid on
subplot(312)
plot(t, sigm, 'Linewidth', 2)
hold on;
plot(t, ct, 'r', 'Linewidth', 2)
xlabel('Time'); ylabel('Modulated Signal Amplitude'); title('SSB-SC Modulated Signal')
legend('SSB-SC Modulated Signal', 'Carrier Signal')
grid on
subplot(313)
plot(t, filtered, 'Linewidth', 2)
xlabel('Time'); ylabel('Demodulated Signal'); title('Demodulated Signal')
grid on

