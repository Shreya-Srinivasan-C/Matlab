clc;
clear all;
close all;
x=input('Enter the x sequence = ');
y=input('Enter the y sequence = ');
nx=length(x);
ny=length(y);
Rxy=xcorr(x,y);
disp(Rxy);
Ryx=xcorr(y,x);
subplot(2,1,1);
n = -(nx-1):1:(nx-1);
stem(n,Rxy);
title('Rxy sequence'); xlabel('n'); ylabel("Rxy");
subplot(2,1,2);
stem(n,Ryx);
title('Ryx sequence'); xlabel('n'); ylabel("Ryx");
energy = ((sum(x.^2)+sum(y.^2))/2)
c0 = ceil(length(Rxy)/2);
Rxy_0=Rxy(c0);
if (Rxy_0)<=energy
    disp('Energy property is proved');
else
    disp("Energy Property is not proved");
end
a=fliplr(Ryx);
if a==Rxy
    disp('Rxy(n)=Ryx(-n) is proved');
else
    disp('Property 2 is not proved');
end
center_index = ceil(length(Rxy)/2);
Rxy_right=Rxy(center_index+1:1:length(Rxy));
Rxy_left=Rxy(center_index-1:-1:1);
if (Rxy_right)==(Rxy_left)
    disp('Property 3 is not proved: Rxy is an even sequence');
else
    disp('Property 3 is proved: Rxy is not an even sequence');
end