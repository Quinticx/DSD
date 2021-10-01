%function [Zh_S_F, Zh_C_F, A_h_S, A_h_C, Zh_Ku_F, Zh_Ka_F, A_h_Ku, A_h_Ka] = calculate_Z_ZDR(Nw, miu, lamuda)
function [Zh_Ku_F, A_h_Ku] = calculate_Z_ZDR(Nw, mu, Dm)

% For C and S Bands
D = 0.1:0.1:8;
DSD = Nw*D.^mu.*exp(-Dm*D);

% For Ku and Ka Bands
% Using Ryu 2021 
% GDSD = Nw*(6/(4^4))*(((4+mu)^(mu+4))/gamma(mu+4))*((D/Dm).^mu).*exp(-(4+mu)*(D/Dm));

% Using GPM Manual 2018
GDSD = Nw*(D.^mu).*exp((-(4+mu)*D)/Dm);

%[Zh_S_F, Zh_C_F, A_h_S, A_h_C, Zh_Ku_F, Zh_Ka_F, A_h_Ku, A_h_Ka] = parameter_estimation(DSD); 
[Zh_Ku_F, A_h_Ku] = parameter_estimation(DSD, GDSD); 