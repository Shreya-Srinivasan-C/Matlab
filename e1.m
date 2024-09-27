fs = 100e3; % sample frequency in Hz
t = 0:1/fs:0.1-1/fs; % time vector
f = 2.5e3; % message signal frequency component 1
m = sin(2*pi*f*t) + sin(2*pi*3.3e3*t); % message signal

% Create the analytic signal using the Hilbert transform
mc = hilbert(m);

% Shift the spectral content to the desired center frequency
fo = 1e6; % carrier frequency in Hz
mcm = mc .* exp(1j * 2 * pi * fo * t);

% Take the real part of the result to get the SSB-SC modulated signal
y = real(mcm);

% Generate the local carrier
fc = fo; % local carrier frequency
local_carrier = cos(2 * pi * fc * t);

% Multiply the modulated signal by the local carrier
detected_signal = y .* local_carrier;

% Low-pass filter the result to recover the original message signal
h = fir1(100, [0 10e3]); % low-pass filter with cutoff frequency 10 kHz
recovered_signal = filter(h, 1, detected_signal);