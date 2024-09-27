A=[1 2 1.5];
f1=[100 200 500];
T=1/min(f1);
Fs=1*max(f1);
Ts=1/Fs;
t=0:Ts:3*T;
xt=0;
for ind=1:length(f1)
    xt=xt+A(ind)*sin(2*pi*f1(ind)*t);
end
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
xlim([-600 600])