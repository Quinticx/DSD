function [Zh, A_h] = calculateZhAh(lambda, Nw, mu, Dm, TMF, TMB, Kw)
% Call new paramEstimation Function
D = 0.1:0.1:8;

% Using GPM Manual 2018
GDSD = Nw*(D.^mu).*exp((-(4+mu)*D)/Dm);
[Zh, A_h] = paramEstimation(lambda, GDSD, TMF, TMB, Kw);

end

function [Zh, A_h] = paramEstimation(lambda, Nd, TMF, TMB, Kw)

%==========================================================================
%                         CANTING ANGLE
%==========================================================================
Phi = 0*pi/180;
Std = 0*pi/180;

var_cita = 0;
mean_cita = 0*pi/180;
var_pha = 0;
mean_pha = 0;


AA = 1/8*(3 + 4*cos(2*Phi)*exp(-2*Std^2) + cos(4*Phi)*exp(-8*Std^2));
BB = 1/8*(3 - 4*cos(2*Phi)*exp(-2*Std^2) + cos(4*Phi)*exp(-8*Std^2));
CC = 1/8*(1-cos(4*Phi)*exp(-8*Std^2));

%==========================================================================
%                         Zh and Ah Calculations
%==========================================================================
mean_fa = sum(Nd.*TMF.fa);
mean_fb = sum(Nd.*0.1.*TMF.fb);

abs_fa_square =  (abs(TMB.fa)).^2;
abs_fb_square =  (abs(TMB.fb)).^2;
 
Zh = sum(Nd.*0.1.*( abs_fa_square.*AA + abs_fb_square.*BB + 2*CC.*abs(TMF.fa).*abs(TMF.fb)))*4*(lambda*10)^4/pi^4/(abs(Kw))^2;
A_h = 8.686*10^(-3)*lambda*10*imag(mean_fa);

end