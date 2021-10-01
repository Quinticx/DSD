clear
close all

load('mat_201857-1813.mat');

% Load Ku_NS_paramDSD. Has shape of (2, 176, 49, 7932) 
% [nDSD, nBin, nRay, nScan]
KUP = mat.Ku_NS_paramDSD;

% Load Ka_HS_paramDSD. Has shape of (2, 88, 24, 7932)
% KAP = mat.Ka_HS_paramDSD;

tic
% parfor i = 1:176
%     disp(i)
%     for j = 1:49
%         for k = 2457:2737
%             Nw = 10^(KUP(1, i, j, k)/10);
%             Dm = KUP(2, i, j, k);
%             mu = 0; % Seto 2013, Liao 2014 both used mu = 3
%             [Zh_Ku_F(i, j, k), A_h_Ku(i, j, k)] = calculate_Z_ZDR(Nw, mu, Dm);
%         end
%     end
% end
% Initialize Sum
for i = 1:1
    for j = 1:1
        for k = 2457:2737
            Nw = 10^(KUP(1, i, j, k)/10);
            Dm = KUP(2, i, j, k);
        end
    end
end

parfor i = 2:176
    disp(i)
    for j = 2:49
        for k = 2457:2737
            Nw = 10^(KUP(1, i, j, k)/10);
            Dm = KUP(2, i, j, k);
%             avgNW = (10^(KUP(1, i, j, k)/10) + 10^(KUP(1, i-1, j-1, k-1)/10))/2;
%             avgDM = (10^(KUP(2, i, j, k)/10) + 10^(KUP(2, i-1, j-1, k-1)/10))/2;
            mu = 0; % Seto 2013, Liao 2014 both used mu = 3
            [Zh_Ku_F(i, j, k), A_h_Ku(i, j, k)] = calculate_Z_ZDR(Nw, mu, Dm);
%             [Zh_Ku_F(i-1, j-1, k-1), A_h_Ku(i-1, j-1, k-1)] = calculate_Z_ZDR(avgNW, mu, avgDM);
%             [Zh_Ku_F(i, j, k), A_h_Ku(i, j, k)] = calculate_Z_ZDR(Nw, mu, Dm);
        end
    end
end
toc
save('Zh_Ku_Mu0_GPM_Wang_Att_Ex_try','Zh_Ku_F','A_h_Ku');

