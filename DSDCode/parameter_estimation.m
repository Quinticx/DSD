%function [Zh_S_F, Zh_C_F, A_h_S, A_h_C, Zh_Ku_F, Zh_Ka_F, A_h_Ku, A_h_Ka] = parameter_estimation(DSD)
function [Zh_Ku_F, A_h_Ku, Zh_Ka_F, A_h_Ka] = parameter_estimation(DSD, GDSD)
persistent Kw_Ku;
persistent fa_Ku;
persistent fb_Ku;
persistent loaded_Ku;
persistent Kw_Ku_F;
persistent fa_Ku_F;
persistent fb_Ku_F;
persistent loaded_Ku_F;


persistent Kw_Ka;
persistent fa_Ka;
persistent fb_Ka;
persistent Kw_Ka_F;
persistent fa_Ka_F;
persistent fb_Ka_F;


%==========================================================================
%                         temperature and maximum drop size
%==========================================================================
for i= 1:1
temp = 0;            % temperature
ROW = 80;             % drop size only to 8.0 mm
lamuda_S = 10;
lamuda_C = 5;
lamuda_Ku = 2;
lamuda_Ka = 1;

% fprintf("The temperature is ")
% disp(temp)


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
% this part is for T-matrix calculation     Ku band & Ka band backward
%==========================================================================
% [Kw_S, fa_S, fb_S] = load_Tmatrix_S(temp, ROW);
% [Kw_C, fa_C, fb_C] = load_Tmatrix_C(temp, ROW);

if isempty(loaded_Ku)
    try
        load("ku.mat", "Kw_Ku", "fa_Ku", "fb_Ku");
    catch
        [Kw_Ku, fa_Ku, fb_Ku] = load_Tmatrix_Ku(temp, ROW);
        [Kw_Ka, fa_Ka, fb_Ka] = load_Tmatrix_Ka(temp, ROW);
        save("ku.mat", "Kw_Ku", "fa_Ku", "fb_Ku", "ka.mat", "Kw_Ka", "fa_Ka", "fb_Ka");
    end
    loaded_Ku = 1;
end

%==========================================================================
% this part is for T-matrix calculation     Ku band & Ka band forward
%==========================================================================
% [Kw_S_F, fa_S_F, fb_S_F] = load_Tmatrix_S_Forward(temp, ROW);
% [Kw_C_F, fa_C_F, fb_C_F] = load_Tmatrix_C_Forward(temp, ROW);

if isempty(loaded_Ku_F)
    try
        load("ku_forward.mat", "Kw_Ku_F", "fa_Ku_F", "fb_Ku_F");
    catch
        [Kw_Ku_F, fa_Ku_F, fb_Ku_F] = load_Tmatrix_Ku_Forward(temp, ROW);
        [Kw_Ka_F, fa_Ka_F, fb_Ka_F] = load_Tmatrix_Ka_Forward(temp, ROW);
        save("ku_forward.mat", "Kw_Ku_F", "fa_Ku_F", "fb_Ku_F", "ka_forward.mat", "Kw_Ka_F", "fa_Ka_F", "fb_Ka_F");
    end
    loaded_Ku_F = 1;
end

    
N = DSD;
NG = GDSD;


% mean_fa_S_F = sum( N.*fa_S_F );
% mean_fb_S_F = sum( N.*0.1.*fb_S_F );
% mean_fa_C_F = sum( N.*fa_C_F );
% mean_fb_C_F = sum( N.*0.1.*fb_C_F );

mean_fa_Ku_F = sum(NG.*fa_Ku_F );
mean_fb_Ku_F = sum(NG.*0.1.*fb_Ku_F);
mean_fa_Ka_F = sum(N.*fa_Ka_F );
mean_fb_Ka_F = sum(N.*0.1.*fb_Ka_F);

           
%==========================================================================           
%%  KDP estimation
%==========================================================================
% 
% mean_ff_S = sum( N.*real(fa_S_F-fb_S_F));
% mean_ff_C = sum( N.*real(fa_C_F-fb_C_F));

mean_ff_Ku = sum(NG.*real(fa_Ku_F-fb_Ku_F));
mean_ff_Ka = sum( N.*real(fa_Ka_F-fb_Ka_F));
% 
% KDP_S = 10^(-3)*180/pi*lamuda_S*10*mean_ff_S;
% KDP_C = 10^(-3)*180/pi*lamuda_C*10*mean_ff_C;

KDP_Ku = 10^(-3)*180/pi*lamuda_Ku*10*mean_ff_Ku;
KDP_Ka = 10^(-3)*180/pi*lamuda_Ka*10*mean_ff_Ka;
% 
% 
% A_h_S = 8.686*10^(-3)*lamuda_S*10*imag(mean_fa_S_F);
% A_h_C = 8.686*10^(-3)*lamuda_C*10*imag(mean_fa_C_F);

A_h_Ku = 8.686*10^(-3)*lamuda_Ku*10*imag(mean_fa_Ku_F);
A_h_Ka = 8.686*10^(-3)*lamuda_Ka*10*imag(mean_fa_Ka_F);
% 
% abs_fa_S =  abs(fa_S);
% abs_fb_S =  abs(fb_S);
% abs_fa_C =  abs(fa_C);
% abs_fb_C =  abs(fb_C);

abs_fa_Ku =  abs(fa_Ku);
abs_fb_Ku =  abs(fb_Ku);
abs_fa_Ka =  abs(fa_Ka);
abs_fb_Ka =  abs(fb_Ka);
% 
% 
% abs_fa_square_S =  (abs(fa_S)).^2;
% abs_fb_square_S =  (abs(fb_S)).^2;
% abs_fa_square_C =  (abs(fa_C)).^2;
% abs_fb_square_C =  (abs(fb_C)).^2;

abs_fa_square_Ku =  (abs(fa_Ku)).^2;
abs_fb_square_Ku =  (abs(fb_Ku)).^2;
abs_fa_square_Ka =  (abs(fa_Ka)).^2;
abs_fb_square_Ka =  (abs(fb_Ka)).^2;  
% 
% Zh_S_F(i) = sum(N.*0.1.*( abs_fa_square_S.*AA + abs_fb_square_S.*BB + 2*CC.*abs_fa_S.*abs_fb_S))*4*(lamuda_S*10)^4/pi^4/(abs(Kw_S))^2;
% Zh_C_F(i) = sum(N.*0.1.*( abs_fa_square_C.*AA + abs_fb_square_C.*BB + 2*CC.*abs_fa_C.*abs_fb_C))*4*(lamuda_C*10)^4/pi^4/(abs(Kw_C))^2;

Zh_Ku_F(i) = sum(NG.*0.1.*( abs_fa_square_Ku.*AA + abs_fb_square_Ku.*BB + 2*CC.*abs_fa_Ku.*abs_fb_Ku))*4*(lamuda_Ku*10)^4/pi^4/(abs(Kw_Ku))^2;
Zh_Ka_F(i) = sum(N.*0.1.*( abs_fa_square_Ka.*AA + abs_fb_square_Ka.*BB + 2*CC.*abs_fa_Ka.*abs_fb_Ka))*4*(lamuda_Ka*10)^4/pi^4/(abs(Kw_Ka))^2;
% 
% Zv_S_F = sum(N.*0.1.*( abs_fa_square_S.*BB + abs_fb_square_S.*AA + 2*CC.*abs_fa_S.*abs_fb_S))*4*(lamuda_S*10)^4/pi^4/(abs(Kw_S))^2;
% Zv_C_F = sum(N.*0.1.*( abs_fa_square_C.*BB + abs_fb_square_C.*AA + 2*CC.*abs_fa_C.*abs_fb_C))*4*(lamuda_C*10)^4/pi^4/(abs(Kw_C))^2;
% 
% Zv_Ku_F = sum(N.*0.1.*( abs_fa_square_Ku.*BB + abs_fb_square_Ku.*AA + 2*CC.*abs_fa_Ku.*abs_fb_Ku))*4*(lamuda_Ku*10)^4/pi^4/(abs(Kw_Ku))^2;
% Zv_Ka_F = sum(N.*0.1.*( abs_fa_square_Ka.*BB + abs_fb_square_Ka.*AA + 2*CC.*abs_fa_Ka.*abs_fb_Ka))*4*(lamuda_Ka*10)^4/pi^4/(abs(Kw_Ka))^2;
% 
% KDP_S = 10^(-3)*180/pi*lamuda_S*10*real(mean_fa_S_F-mean_fb_S_F)*1/2*(1+exp(-2*var_cita^2)*cos(2*mean_cita))*...
%                exp(-2*var_pha^2)*cos(2*mean_pha);
% 
% KDP_C = 10^(-3)*180/pi*lamuda_C*10*real(mean_fa_C_F-mean_fb_C_F)*1/2*(1+exp(-2*var_cita^2)*cos(2*mean_cita))*...
%                exp(-2*var_pha^2)*cos(2*mean_pha);
%            
% KDP_Ku = 10^(-3)*180/pi*lamuda_Ku*10*real(mean_fa_Ku_F-mean_fb_Ku_F)*1/2*(1+exp(-2*var_cita^2)*cos(2*mean_cita))*...
%                exp(-2*var_pha^2)*cos(2*mean_pha);
% 
% KDP_Ka = 10^(-3)*180/pi*lamuda_Ka*10*real(mean_fa_Ka_F-mean_fb_Ka_F)*1/2*(1+exp(-2*var_cita^2)*cos(2*mean_cita))*...
%                exp(-2*var_pha^2)*cos(2*mean_pha);
% 
% A_h_S(i) = 8.686*10^(-3)*lamuda_S*10*imag(mean_fa_S_F);
% A_v_S = 8.686*10^(-3)*lamuda_S*10*imag(mean_fb_S_F);
% 
% A_h_C(i) = 8.686*10^(-3)*lamuda_C*10*imag(mean_fa_C_F);
% A_v_C = 8.686*10^(-3)*lamuda_C*10*imag(mean_fb_C_F);
% 
A_h_Ku(i) = 8.686*10^(-3)*lamuda_Ku*10*imag(mean_fa_Ku_F);
A_v_Ku = 8.686*10^(-3)*lamuda_Ku*10*imag(mean_fb_Ku_F);
% 
A_h_Ka(i) = 8.686*10^(-3)*lamuda_Ka*10*imag(mean_fa_Ka_F);
A_v_Ka = 8.686*10^(-3)*lamuda_Ka*10*imag(mean_fb_Ka_F);


    

% 
% for ii = 1:1
% %     Zh_S_att(ii) = 10*log10(Zh_S_F(ii)) - sum(A_h_S(1:ii) * 10);
% %     Zh_C_att(ii) = 10*log10(Zh_C_F(ii)) - sum(A_h_C(1:ii) * 10);
% %     
% %     ZDR_S_att(ii) = 10*log10(Zh_S_F(ii)/Zv_S_F(ii)) - sum( (A_h_S(1:ii)-A_v_S(1:ii)) * 10);
% %     ZDR_C_att(ii) = 10*log10(Zh_C_F(ii)/Zv_C_F(ii)) - sum( (A_h_C(1:ii)-A_v_C(1:ii)) * 10);
%     
%     Zh_Ku_att(ii) = 10*log10(Zh_Ku_F(ii)) - sum(A_h_Ku(1:ii) * 10);
% %     Zh_Ka_att(ii) = 10*log10(Zh_Ka_F(ii)) - sum(A_h_Ka(1:ii) * 10);
%     
%     ZDR_Ku_att(ii) = 10*log10(Zh_Ku_F(ii)/Zv_Ku_F(ii)) - sum( (A_h_Ku(1:ii)-A_v_Ku(1:ii)) * 10);
% %     ZDR_Ka_att(ii) = 10*log10(Zh_Ka_F(ii)/Zv_Ka_F(ii)) - sum( (A_h_Ka(1:ii)-A_v_Ka(1:ii)) * 10);
% end
end
