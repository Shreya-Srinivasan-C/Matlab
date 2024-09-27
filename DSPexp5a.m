clc;
close all;
clear;

x=input('Enter the x sequence =');
nx=length(x);

Rxx=xcorr(x,x);
disp(Rxx);
nRxx=-(nx-1):1:(nx-1);
stem(nRxx,Rxx);
title('Rxx sequence');
xlabel('n');
ylabel("Rxx");

energy=sum(x.^2);
center_index=ceil(length(Rxx)/2);
Rxx_0=Rxx(center_index);

if Rxx_0 == energy
    fprintf('Rxx(0)has max energy:%d\n',energy);
    disp('Property 1is proved:maximum energy of Rxx is stored at origin');
else
    disp('Property 1 is not proved');
end

Rxx_right=Rxx(center_index+1:1:length(Rxx));
Rxx_left=Rxx(center_index-1:-1:1);

if (Rxx_right)==(Rxx_left)
    disp('property 2 is proved:Rxx is an even sequence');
else
    disp("Rxx is not an even sequence, property 2 is not proved");
end