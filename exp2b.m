xn=[ones(1,10) zeros(1,1000)];
N=length(xn);
Fs=2000;
Ts=1/Fs;
t=0:Ts:(N-1)*Ts;
Xf=fftshift(fft(xn))/N;
f=linspace(-Fs/2,Fs/2,N);
figure;
stem(t,xn);
title('Rectangular Pulse Signal');
xlabel('Time (sec)');
ylabel('Amplitudes');
grid on
xlim([0, 0.01]);
figure;
plot(f,abs(Xf));
title('Spectrum of Rectangular Pulse Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitudes');
grid on