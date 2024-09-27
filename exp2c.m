load chirp;
sound(y,Fs)
xn = y;
N=length(xn);
Ts=1/Fs;
t=0:Ts:(N-1)*Ts;
Xf=fftshift(fft(xn))/N;
f=linspace(-Fs/2,Fs/2,N);
figure
stem(t,xn);
title('Chirp Signal');
xlabel('Time(sec)');
ylabel('Amplitudes');
grid on

figure
plot(f,abs(Xf));
title('Spectrum of Chirp Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on