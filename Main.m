%Perform standard housekeeping protocol
clc;
close all;
clear all;

%We give values for the resistor, inductor, and capacitor of our second
%order RLC circuit
R = 1;  %Ohms
C = 1; %Farads
L = 1;  %Henrys

%We use g as our scale factor to manipulate the final output audio
g1 = 1;
g2 = 1;
g3 = 1;

%Initialize j,w, and z (function of j and w in the unit circle)
j = sqrt(-1);
w = -pi:.01:pi;
z = exp(j * w);

%Read the wav "Tequila" song file and store the audio samples into a vector
%called capital X
[Tequila, time] = audioread('Output.wav');
seconds = 5;

y = Tequila(1:time * seconds);
H = length(y);
X = y;
 
%--------------------------Laplace Transform Equation---------------------%
%For the Laplace transform, we create a V out transfer function from circuit analysis of each filter. Then, we replace s with j*w

%bandpass 
Lp_bp = R ./(R + (1 ./ (C * j * w)) + (L * j * w));
mag_bp = abs(Lp_bp);

%lowpass 
num_lp = (1 ./ (C * j * w));
den_lp = ((1 ./(C * j * w)) + (L * j * w) + R);
Lp_lp = num_lp ./ den_lp;
mag_lp = abs(Lp_lp);

%highpass 
num_hp = (L * j * w);
den_hp = ((1 ./(C * j * w)) + (L * j * w) + R);
Lp_hp = num_hp ./ den_hp;
mag_hp = abs(L_hp); 

%plot it
figure(1);
plot(w, mag_bp);
hold on;
plot(w, mag_lp);
plot(w, mag_hp);

%graph labels
title('LaPlace Transform Graphs Between -\pi and \pi');
xlabel('-\pi < \omega < \pi');
ylabel('| LaPlace ( j \omega) |');
ax = gca;
ax.FontSize = 13;
legend({'Bandpass Filter','Lowpass Filter', 'Highpass Filter'}, 'Location', 'Southwest');
hold off;
 
 
%-------------------------Z Transform Equation----------------------------%
%In order to retrieve the z transform graph, we perform the bilinear transformation on the laplace equation which simply replaces s with
%(1-1/z)/(1+1/z). This allows us to go into the digitial domain.Once we perform this transform, we simplify the equation to get 
%H(z) = (a1 + a2*z^-1 + a3*z^-2)/(1 + b1*z^-1 + b2*z^-2) = Y(z)/X(z) where a1, a2, a3, b1, b2 are all variables solved using alegbra and
%circuit analysis.
 
%bandpass
a1_bp = R/(R + L + 1/C);
a2_bp = 0;
a3_bp = -R/(R + L + 1/C);
num_b1_bp = 2* ((1/C) - L);
den_b1_bp = R + L + 1/C;
b1_bp = num_b1_bp / den_b1_bp;
num_b2_lp = L - R + 1/C;
den_b2_lp = R + L + 1/C;
b2_bp = num_b2_lp / den_b2_lp;

%lowpass filter variables
a1_lp = 1/(R*C + L*C + 1);
a2_lp = 2/(R*C + L*C +1);
a3_lp = 1/(R*C + L*C + 1);
num_b1_lp = 2* ((1/C) - L);
den_b1_lp = R + L + 1/C;
b1_lp = num_b1_lp / den_b1_lp;
num_b2_lp = L - R + 1/C;
den_b2_lp = R + L + 1/C;
b2_lp = num_b2_lp / den_b2_lp;

%highpass filter variables
a1_hp = L/(R + L + 1/C);
a2_hp = -2/(R + L + 1/C);
a3_hp = L/(R + L + 1/C);
num_b1_hp = 2* ((1/C) - L);
den_b1_hp = R + L + 1/C;
b1_hp = num_b1_hp / den_b1_hp;
num_b2_hp = L - R + 1/C;
den_b2_hp = R + L + 1/C;
b2_hp = num_b2_hp / den_b2_hp;
 
%Set up the for loop wiht arrays of zeros 
Xz = zeros(1,H);
Hz_bp = zeros(1,H);
Y1z = zeros(1,H);
Hz_lp = zeros(1,H);
Y2z = zeros(1,H);
Y3z = zeros(1,H);
Hz_hp = zeros(1,H);
 
dtheta = 2*pi/H;
 
for n = 1:H
    
   %IMPORTANT ---> because we know H(z) = Y(z)/X(z), we first create a
   %function of H(z), then we multiply H(z) by X(z) to acquire Y(z) which
   %is our output!
   
   %we make Z into increments of the unit circle 
   theta = dtheta*(n-1);
   Z = exp(j*theta);   
   
   %Bandpass Filter
   Hz_bp(n) = ((Z*Z*a1_bp) + (a2_bp*Z) + a3_bp)/((Z*Z) + (b1_bp*Z) + b2_bp);
   Y1z(n) = Hz_hp(n) * Xz(n);
   
   %Lowpass Filter
   Hz_lp(n) = ((Z*Z*a1_lp) + (a2_lp*Z) + a3_lp)/((Z*Z) + (b1_lp*Z) + b2_lp);
   Y2z(n) = Hz_lp(n) * Xz(n);
   
   %Highpass Filter
   Numerator_HP = (L*(1-1/Z)*(1-1/Z)); 
   Denominator_HP = (R*(1-1/Z)*(1+1/Z)+L*(1-1/Z)*(1-1/Z)+(1/C)*(1+1/Z)*(1+1/Z));
   Hz_hp(n) = ((Z*Z*a1_hp) + (a2_hp*Z) + a3_hp)/((Z*Z) + (b1_hp*Z) + b2_hp);
   Y3z(n) = Hz_hp(n) * Xz(n);
   
end
 
%plot it
figure(2);
plot(abs(Hz_bp));
hold on;
plot(abs(Hz_lp));
plot(abs(Hz_hp));

%add title,x&y axis title, add label for filters to bottom left
title('Z-Transform Graph of Filters');
xlabel('Real Frequency');
ylabel('Magnitude');
ax = gca;
ax.FontSize = 13;

legend({'Bandpass Filter','Lowpass Filter','Highpass Filter'}, 'Location', 'Southwest');
hold off;
 
 
 
 

                    
%----------------------Difference Eq and DFT------------------------------%
%Now for the difference equation, we cross multiply (a1 + a2*z^-1 + a3*z^-2)/(1 + b1*z^-1 + b2*z^-2) = Y(z)/X(z). Then, we
%find the inverse Z transform to get the difference equation in terms of n. Once we do so,then we solve for y and get the equation:
% y(n)=a1*x(n) + a2*x(n-1) + a3*x(n-2) - b1*y(n-1) - b2*y(n-2)

x_de = zeros(H,1);
y1_de = zeros(H,1);
y2_de = zeros(H,1);
y3_de = zeros(H,1);
x_de(3,1) = 1;
Y_de = zeros(H,1);
 
 for n=3:H
     
    %bandpass 
    y1_de(n) = a1_bp*x_de(n) + a2_bp*x_de(n-1) + a3_bp*x_de(n-2) - b1_bp*y1_de(n-1) - b2_bp*y1_de(n-2);
    
    %lowpass
    y2_de(n) = a1_lp*x_de(n) + a2_lp*x_de(n-1) + a3_lp*x_de(n-2) - b1_lp*y2_de(n-1) - b2_lp*y2_de(n-2); 
    
    %highpass
    y3_de(n) = a1_hp*x_de(n) + a2_hp*x_de(n-1) + a3_hp*x_de(n-2) - b1_hp*y3_de(n-1) - b2_hp*y3_de(n-2); 
    
 end
 
%The impulse response above was generated from the difference equation in which we find the FFT using the demands below

figure(3);
plot(abs(fft(y1_de)));
hold on

plot(abs(fft(y2_de)));
plot(abs(fft(y3_de)));
hold off

%add title,x&y axis title, add label for filters to bottom left
title('DFT Graph of Filters');
xlabel('Frequency');
ylabel('Amplitude');
ax = gca;
ax.FontSize = 13;

legend({'Bandpass Filter','Lowpass Filter','Highpass Filter'}, 'Location', 'Southwest');
hold off;




 
%-------------------------------------------------------------------------%
%-----------------------FINAL OUTPUT OF AUDIO-----------------------------%
%-------------------------------------------------------------------------%            
%What we do here is use the difference equation and multiply it by the  sample values of the Tequila song we stored into variable capital X. Then,
%we multiple each difference equation by their corresponding g1, g2, g3 and then combine all 3 into one final output Y

Y1 = zeros(H,1);
Y2 = zeros(H,1);
Y3 = zeros(H,1);
X(3,1) = 1;
Y = zeros(H,1);

 for n=3:H
     
    %bandpass 
    Y1(n) = a1_bp*X(n) + a2_bp*X(n-1) + a3_bp*X(n-2) - b1_bp*Y1(n-1) - b2_bp*Y1(n-2);
    
    %lowpass
    Y2(n) = a1_lp*X(n) + a2_lp*X(n-1) + a3_lp*X(n-2) - b1_lp*Y2(n-1) - b2_lp*Y2(n-2); 
    
    %highpass
    Y3(n) = a1_hp*X(n) + a2_hp*X(n-1) + a3_hp*X(n-2) - b1_hp*Y3(n-1) - b2_hp*Y3(n-2); 
    
    %FINAL OUTPUT
    Y(n) = g1*Y1(n) + g2*Y2(n) + g3*Y3(n);
    
 end
 
%sound(Y,time*1);

figure(4);
plot(Y);

title('Final Output');
ax = gca;
ax.FontSize = 13;
