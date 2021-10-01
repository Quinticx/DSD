% Plot Vertical Structure of GPM 
clear
close all
colormap_88D;

fprintf("Loading .mat file\n");
load('mat_201857-1813.mat');
% filename = 'mat_201857-1813.mat';
% [Ku_DSD_Params, Ka_DSD_Params, indexKu, indexKa, KUP, KAP] = getDSDParams(filename);

% Load Ku_NS_paramDSD. Has shape of (2, 176, 49, 7932) 
% [nDSD, nBin, nRay, nScan]
KUP = mat.Ku_NS_paramDSD;

% Load Ka_HS_paramDSD. Has shape of (2, 88, 24, 7932)
KAP = mat.Ka_HS_paramDSD;

% Load Lat and Lon on Ku and Ka
Longitude_Ku = mat.Longitude_Ku;
Latitude_Ku = mat.Latitude_Ku;
Longitude_Ka_HS = mat.Longitude_Ka_HS;
Latitude_Ka_HS = mat.Latitude_Ka_HS;

fprintf("Calculating ZDR\n");
for i = 1:176
    disp(i)
    for j = 1:49
        disp(j)
        for k = 1:7932
            disp(k)
            %a = [8000 0 10]; % Nw, mu, lambda   - SBand
            %a = [8000 0 5]; % Nw, mu, lambda     - CBand
            a = [KUP(1, i, j, k) 0 2]; % Nw, mu, lambda    - KuBand
            %a = [KAP(1, i, j, k) 0 1]; %Nw, mu, lambda     - KaBand
            [Zh_S_F, Zh_C_F, A_H_S, A_H_C, Zh_Ku_F(i), Zh_Ka_F, A_h_Ku, A_h_Ka] = calculate_Z_ZDR(a(1), a(2), a(3));
        end
    end

end
fprintf("Plotting...");
Height = 0.125:0.125:176*0.125;
Range = 1:1:81;
Ku_vertical = double(mat.Ku_NS_zFactorCorrected(end:-1:1,:,2577-20:2577+60));
KuVertCheck = Ku_vertical(1,:, :);
Ku_vertical(Ku_vertical < 0) = nan;
Ku_VV = mean(Ku_vertical,2, 'omitnan');
Ku = squeeze(Ku_VV(:,1,:));

% Figure 1
%% . plot the vertical structure of given
for ii = 1:80
    figure(1)
    plot(squeeze(Ku_VV(:,1,ii)), Height,'r-','LineWidth',3);
    grid
    %pause
end

% Figure 2
%% . plot the vertical structure of calculated
figure(2)
Height2 = 0.125:0.125:21*0.125;
for i = 1:21
    plot(Zh_Ku_F(end:-1:1), Height2, 'r-', 'LineWidth', 3);
    grid;
end

