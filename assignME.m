clc; clear all; close all;
Z0 = 100;
f_desired = 5e9;
f_start = 3e9;
f_end = 7e9;
num_points = 100;

Z_L_real = 200;
Z_L_imag = 300;

f = linspace(f_start, f_end, num_points);

Z_L = Z_L_real + 1i * Z_L_imag;

reflection_coefficient = zeros(size(f));

for i = 1:length(f)
    normalized_freq = f(i) / f_desired;
    Z_transform = Z_L / (1 + Z_L / Z0 * normalized_freq);
    reflection_coefficient(i) = (Z_transform - Z0) / (Z_transform + Z0);
end

figure;
plot(f/1e9, abs(reflection_coefficient), 'b', 'LineWidth', 2);
xlabel('Frequency (GHz)');
ylabel('Reflection Coefficient Magnitude');
title('Reflection Coefficient vs. Frequency');
grid on;

bandwidth = f_end - f_start;
disp(['Bandwidth of the design: ', num2str(bandwidth/1e9), ' GHz']);
