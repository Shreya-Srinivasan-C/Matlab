wc=0.5*pi;
M=25;
alpha=(M-1)/2;
eps=.001;
n=0:1:M-1;
hd=(sin(pi*(n-alpha+eps))-sin(wc*(n-alpha+eps)))./(pi*(n-alpha+eps));
wr=boxcar(M);
hn=hd.*wr';
w=0:0.01:pi;
h=freqz(hn,1,w);
plot(w/pi,abs(h));
hold on
wh=hamming(M);
hn=hd.*wh';
w=0:0.01:pi;
h=freqz(hn,1,w);
plot(w/pi,abs(h),'r-.');grid;
xlabel('Normalized frequency\omega/\pi');
ylabel('Magnitude');
legend('Rectangle', 'Hamming')
hold off