% Parameters
f = 3300;           % Frequency of input signal (3.3 kHz)
fc = 41000000;      % Carrier frequency (41 MHz)
fs = 10 * f;        % Sampling frequency
t = 0:1/fs:1;       % Time vector

% Generate input signal
x = sin(2 * pi * f * t);

% Modulation
carrier = sin(2 * pi * fc * t);
ssbsc_modulated = real(hilbert(x) .* exp(sqrt(-1) * 2 * pi * fc * t));

% Demodulation
ssbsc_demodulated = ssbsc_modulated .* carrier;

% Butterworth filter design
order = 6;          % Filter order
cutoff_freq = 2 * f; % Cutoff frequency for the filter, can be adjusted

% Design the Butterworth filter
[b, a] = butter(order, cutoff_freq / (fs / 2));

% Apply the filter to the demodulated signal
ssbsc_demodulated_filtered = filter(b, a, ssbsc_demodulated);

% Plot input signal
subplot(4, 1, 1);
plot(t, x);
title('Input Signal');
xlabel('Time');
ylabel('Amplitude');
xlim([0 0.01]);

% Plot modulated signal
subplot(4, 1, 2);
plot(t, ssbsc_modulated, 'g');
title('SSBSC Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
xlim([0 0.01]);

% Plot demodulated signal
subplot(4, 1, 3);
plot(t, ssbsc_demodulated, 'm');
title('SSBSC Demodulated Signal (Before Filtering)');
xlabel('Time');
ylabel('Amplitude');
xlim([0 0.01]);

% Plot filtered demodulated signal
subplot(4, 1, 4);
plot(t, ssbsc_demodulated_filtered, 'r');
title('SSBSC Demodulated and Filtered Signal');
xlabel('Time');
ylabel('Amplitude');
xlim([0 0.01]);
