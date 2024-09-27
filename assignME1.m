clc; clear all; close all;
% Constants
f0 = 5e9;
c = 3e8;
f = (3e9:1.05e8:7e9);
lambda = c ./ f;
lambda0 = c / f0;
ZL = 200 + 300i;
Z0 = 100;
threshold_dB = -20; % Reflection coefficient magnitude threshold in dB
% Initialize arrays
Z0p = zeros(size(f));
beta = 2 * pi ./ lambda;
L = lambda0 / 4; % Electrical length
% Calculate characteristic impedance of the transmission line
Z0p = sqrt(ZL * Z0);
% Calculate the tangent of the electrical length
t = tan(beta .* L);
% Calculate input impedance
Zin = Z0p .* (ZL + 1i * Z0p .* t) ./ (Z0p + 1i * ZL .* t);
% Calculate reflection coefficient
gamma = (Zin - Z0) ./ (Zin + Z0);
% Calculate absolute value of the reflection coefficient
agamma = abs(gamma);
% Find bandwidth
agamma_dB = 20 * log10(agamma);
below_threshold_indices = find(agamma_dB < threshold_dB);
bandwidth = f(below_threshold_indices(end)) - f(below_threshold_indices(1));
% Plot reflection coefficient magnitude versus frequency
figure;
plot(f / 1e9, (agamma_dB), 'LineWidth', 1.5);
xlabel('Frequency (GHz)');
ylabel('|Γ| (dB)');
title('Reflection Coefficient Magnitude');
grid on;
% Display bandwidth
disp(['Bandwidth: ', num2str(bandwidth / 1e9), ' GHz']);