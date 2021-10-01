function [Zh_S_F, Zh_C_F, A_h_S, A_h_C, KDP_S, KDP_C] = parameter_estimation(DSD)




%==========================================================================
%                         temperature and maximum drop size
%==========================================================================
temp = 20;            % temperature
ROW = 80;             % drop size only to 8.0 mm
lamuda_S = 10;
lamuda_C = 5;




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
% this part is for T-matrix calculation     S band & C band backward
%==========================================================================
[Kw_S, fa_S, fb_S] = load_Tmatrix_S(temp, ROW);
[Kw_C, fa_C, fb_C] = load_Tmatrix_C(temp, ROW);

%==========================================================================
% this part is for T-matrix calculation     S band & C band forward
%==========================================================================
[Kw_S_F, fa_S_F, fb_S_F] = load_Tmatrix_S_Forward(temp, ROW);
[Kw_C_F, fa_C_F, fb_C_F] = load_Tmatrix_C_Forward(temp, ROW);


    
N = DSD;


% mean_fa_S_F = sum( N.*fa_S_F );
% % mean_fb_S_F = sum( N.*0.1.*fb_S_F );
% mean_fa_C_F = sum( N.*fa_C_F );
% % mean_fb_C_F = sum( N.*0.1.*fb_C_F );


           
%==========================================================================           
%%  KDP estimation
%==========================================================================

mean_ff_S = sum( N.*real(fa_S_F-fb_S_F)*0.1);
mean_ff_C = sum( N.*real(fa_C_F-fb_C_F)*0.1);

KDP_S = 10^(-3)*180/pi*lamuda_S*10*mean_ff_S;
KDP_C = 10^(-3)*180/pi*lamuda_C*10*mean_ff_C;


% mean_fa = 0;
% mean_fb = 0;
% 
% for jj = 1:80
%         mean_fa = mean_fa + DSD(jj)*0.1*fa_S_F(jj);
%         mean_fb = mean_fb + DSD(jj)*0.1*fb_S_F(jj);
% end
% 
% KDP_S = 10^(-3)*180/pi*lamuda_S*10*real(mean_fa-mean_fb);

%==========================================================================           
%%  attenuation estimation
%==========================================================================

mean_fa_S_F = sum(N.*imag(fa_S_F)*0.1);
mean_fa_C_F = sum(N.*imag(fa_C_F)*0.1);

A_h_S = 8.686*10^(-3)*lamuda_S*10*mean_fa_S_F;
A_h_C = 8.686*10^(-3)*lamuda_C*10*mean_fa_C_F;


abs_fa_S =  abs(fa_S);
abs_fb_S =  abs(fb_S);
abs_fa_C =  abs(fa_C);
abs_fb_C =  abs(fb_C);


abs_fa_square_S =  (abs(fa_S)).^2;
abs_fb_square_S =  (abs(fb_S)).^2;
abs_fa_square_C =  (abs(fa_C)).^2;
abs_fb_square_C =  (abs(fb_C)).^2;
    
    
Zh_S_F = sum(N.*0.1.*( abs_fa_square_S.*AA + abs_fb_square_S.*BB + 2*CC.*abs_fa_S.*abs_fb_S))*4*(lamuda_S*10)^4/pi^4/(abs(Kw_S))^2;
Zh_C_F = sum(N.*0.1.*( abs_fa_square_C.*AA + abs_fb_square_C.*BB + 2*CC.*abs_fa_C.*abs_fb_C))*4*(lamuda_C*10)^4/pi^4/(abs(Kw_C))^2;


% Zv_S_F = sum(N.*0.1.*( abs_fa_square_S.*BB + abs_fb_square_S.*AA + 2*CC.*abs_fa_S.*abs_fb_S))*4*(lamuda_S*10)^4/pi^4/(abs(Kw_S))^2;
% Zv_C_F = sum(N.*0.1.*( abs_fa_square_C.*BB + abs_fb_square_C.*AA + 2*CC.*abs_fa_C.*abs_fb_C))*4*(lamuda_C*10)^4/pi^4/(abs(Kw_C))^2;

% KDP_S = 10^(-3)*180/pi*lamuda_S*10*real(mean_fa_S_F-mean_fb_S_F)*1/2*(1+exp(-2*var_cita^2)*cos(2*mean_cita))*...
%                exp(-2*var_pha^2)*cos(2*mean_pha);
% 
% KDP_C = 10^(-3)*180/pi*lamuda_C*10*real(mean_fa_C_F-mean_fb_C_F)*1/2*(1+exp(-2*var_cita^2)*cos(2*mean_cita))*...
%                exp(-2*var_pha^2)*cos(2*mean_pha);

% A_h_S = 8.686*10^(-3)*lamuda_S*10*imag(mean_fa_S_F);
% A_v_S = 8.686*10^(-3)*lamuda_S*10*imag(mean_fb_S_F);
% 
% A_h_C = 8.686*10^(-3)*lamuda_C*10*imag(mean_fa_C_F);
% A_v_C = 8.686*10^(-3)*lamuda_C*10*imag(mean_fb_C_F);




%     
% 
% 
% for ii = 1:1
%     Zh_S_att(ii) = 10*log10(Zh_S(ii)) - sum(A_h_S(1:ii) * 10);
%     Zh_C_att(ii) = 10*log10(Zh_C(ii)) - sum(A_h_C(1:ii) * 10);
%     
%     ZDR_S_att(ii) = 10*log10(Zh_S(ii)/Zv_S(ii)) - sum( (A_h_S(1:ii)-A_v_S(1:ii)) * 10);
%     ZDR_C_att(ii) = 10*log10(Zh_C(ii)/Zv_C(ii)) - sum( (A_h_C(1:ii)-A_v_C(1:ii)) * 10);
% end
