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
fprintf("Initializing Gate 1...");
parfor i = 1:176
    for j = 1:49
        for k = 2457:2737
            Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
            Dm(i, j, k) = KUP(2, i, j, k);
%             avgNW(i, j, k) = 10^(KUP(1, i, j, k)/10);
%             avgDM(i, j, k) = KUP(2, i, j, k);
        end
    end
end

% parfor j = 1:49
%     for k = 2457:2737
%         [maxZCalc, indexC] = max(squeeze(Nw(:,1,80)));   % max(Green)

% avgNW = smoothdata(Nw, 'includenan');
% avgDM = smoothdata(Dm, 'includenan');

% Calculate avgNW and avgDM
% fprintf("Calculating average Nw and Dm for Gates 1-175...");
% for i = 2:2:175
%     disp(i)
%     for j = 1:49
%         for k = 2457:2737
% %             if j == 49
% %                 Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
% %                 Dm(i, j, k) = KUP(2, i, j, k);
% %                 avgNW(i, j, k) = 10^(KUP(1, i, j, k)/10);
% %                 avgDM(i, j, k) = KUP(2, i, j, k);
% %             elseif i >= 176
% %                 Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
% %                 Dm(i, j, k) = KUP(2, i, j, k);
% %                 avgNW(i, j, k) = 10^(KUP(1, i, j, k)/10);
% %                 avgDM(i, j, k) = KUP(2, i, j, k);
% %             else
% %                 Nw(i, j, k) = 10^(KUP(1, i, j, k)/10);
% %                 Dm(i, j, k) = KUP(2, i, j, k);
%                 nw = (10^(KUP(1, i, j, k)/10) + 10^(KUP(1, i+1, j, k)/10))/2;
%                 avgNW(i, j, k) = nw;
%                 avgNW(i+1, j, k) = nw;
%                 dm = (KUP(2, i, j, k) + KUP(2, i+1, j, k))/2;
%                 avgDM(i, j, k) = dm;
%                 avgDM(i+1, j, k) = dm;
% %             end
%         end
%     end
% end

fprintf("Calculating Zh_Ku_F...");
parfor ii = 1:176
    disp(ii)
    for jj = 1:49
         for kk = 2457:2737
%           for kk = 2737:2737
            mu = 0; % Seto 2013, Liao 2014 both used mu = 3
            [Zh_Ku_F(ii, jj, kk), A_h_Ku(ii, jj, kk)] = calculate_Z_ZDR(Nw(ii, jj, kk), mu, Dm(ii, jj, kk));
%             [Zh_Ku_F(i, j, k), A_h_Ku(i, j, k)] = calculate_Z_ZDR(Nw, mu, Dm);
        end
    end
end

toc
save('Zh_Ku_Mu0_GPM_Wang_Att_Ex_Avg_smooth','Zh_Ku_F','A_h_Ku');
    