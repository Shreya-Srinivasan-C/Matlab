xn=[0 1 zeros(1,498)];
N=length(xn);
Fs=2000;
Ts=1/Fs;
t=0:Ts:(N-1)*Ts;
Xf=fftshift(fft(xn))/N;
f=linspace(-Fs/2,Fs/2,N);
figure;
stem(t,xn);
title('Impulse Signal');
xlabel('Time (sec)');
ylabel('Amplitudes');
grid on
figure;
plot(f,abs(Xf));
title('Spectrum of Impulse Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitudes');
grid on