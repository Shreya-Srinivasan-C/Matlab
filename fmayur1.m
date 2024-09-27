% Parameters
f1 = 3300;  % Frequency of first input signal (3.3 kHz)
f2 = 2500;  % Frequency of second input signal (2.5 kHz)
fc = 41000000;  % Carrier frequency (41 MHz)
fs = 10*max(f1, f2); % Sampling frequency
% Generate input signals
x1 = sin(2 * pi * f1 * t);
x2 = sin(2 * pi * f2 * t);
x3 = x1 + x2;
t = 0:1/fs:1;  % Time vector

% Modulation
carrier = sin(2 * pi * fc * t);
ssbsc_modulated = real(hilbert(x3).*exp(sqrt(-1)*2*pi*fc*t));
% Demodulation
ssbsc_demodulated = ssbsc_modulated .* carrier;

% Plot input signals
subplot(3, 1, 1);
plot(t, x3);
title('Input Signals');
xlabel('Time');
ylabel('Amplitude');
legend('Input Signal 1 (3.3 kHz)', 'Input Signal 2 (2.5 kHz)');
xlim([0 0.01]);
% Plot modulated signal
subplot(3, 1, 2);
plot(t, ssbsc_modulated, 'g');
title('SSBSC Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
xlim([0 0.01]);
% Plot demodulated signal
subplot(3, 1, 3);
plot(t, ssbsc_demodulated, 'm');
title('SSBSC Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');
xlim([0 0.01]);
title('SSBSC Demodulation');