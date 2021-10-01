clear; close all;

% v1 = [1 2 3 4 5 6 7 8 9 10];

load('mat_201857-1813.mat');

% Load Ku_NS_paramDSD. Has shape of (2, 176, 49, 7932) 
% [nDSD, nBin, nRay, nScan]
KUP = mat.Ku_NS_paramDSD;

% Load Ka_HS_paramDSD. Has shape of (2, 88, 24, 7932)
% KAP = mat.Ka_HS_paramDSD;

tic

% Initialize Gate 176 avgNw and avgDm
fprintf("Initializing Gate 176...");
for i = 176:176
    for j = 1:49
        for k = 2457:2737
            Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
            Dm(i, j, k) = KUP(2, i, j, k);
            avgNW(i, j, k) = 10^(KUP(1, i, j, k)/10);
            avgDM(i, j, k) = 10^(KUP(2, i, j, k)/10);
        end
    end
end

% Calculate avgNW and avgDM
fprintf("Calculating average Nw and Dm for Gates 1-175...");
for i = 1:2:176
    disp(i)
    for j = 1:49
        for k = 2457:2737
            if j == 49
                Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
                Dm(i, j, k) = KUP(2, i, j, k);
                avgNW(i, j, k) = 10^(KUP(1, i, j, k)/10);
                avgDM(i, j, k) = 10^(KUP(2, i, j, k)/10);
            elseif i >= 176
                Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
                Dm(i, j, k) = KUP(2, i, j, k);
                avgNW(i, j, k) = 10^(KUP(1, i, j, k)/10);
                avgDM(i, j, k) = 10^(KUP(2, i, j, k)/10);
            else
                Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
                Dm(i, j, k) = KUP(2, i, j, k);
                avgNW(i, j, k) = (10^(KUP(1, i, j, k)/10) + 10^(KUP(1, i+1, j+1, k+1)/10))/2;
                avgDM(i, j, k) = (10^(KUP(2, i, j, k)/10) + 10^(KUP(2, i+1, j+1, k+1)/10))/2;
            end
        end
    end
end

fprintf("Calculating Zh_Ku_F...");
parfor ii = 1:176
    disp(ii)
    for jj = 1:49
        for kk = 2457:2737
            mu = 0; % Seto 2013, Liao 2014 both used mu = 3
            [Zh_Ku_F(ii, jj, kk), A_h_Ku(ii, jj, kk)] = calculate_Z_ZDR(avgNW(ii, jj, kk), mu, avgDM(ii, jj, kk));
%             [Zh_Ku_F(i, j, k), A_h_Ku(i, j, k)] = calculate_Z_ZDR(Nw, mu, Dm);
        end
    end
end

toc
save('Zh_Ku_Mu0_GPM_Wang_Att_Ex_Avg2','Zh_Ku_F','A_h_Ku');
    