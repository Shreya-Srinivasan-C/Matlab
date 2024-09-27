A=1;
f1=100;
T=1/f1;
Fs=30*f1;
Ts=1/Fs;
t=0:Ts:3*T;
xt=A*sin(2*pi*f1*t);
N=length(xt);
Xf=fftshift(fft(xt))/N;
f=linspace(-Fs/2,Fs/2,N);
figure;
subplot(211)
plot(t,xt);
xlabel('Time(sec)')
ylabel('Amplitudes')
title('CT signal')
grid on
subplot(212)
stem(t,xt);
xlabel('Time(sec)')
ylabel('Amplitudes')
title('DT signal')
grid on
figure;
plot(f,abs(Xf))
xlabel('frequency(Hz)')
ylabel('Magnitudes')
title('Magnitude Spectrum')
grid on