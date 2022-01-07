% Plot Vertical Structure of GPM 
clear
close all
colormap_88D;

%% Load Workspace Variables
fprintf("Loading .mat file\n");
load('mat_201857-1813.mat');

gen = load('zhahGeneral.mat');
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




% Plot Calculated Reflectivity without Attenuation
figure()
colormap(z_88D);
Longitude_Ku_C = Longitude_Ku(:, 2557:2737);
Latitude_Ku_C = Latitude_Ku(:, 2557:2737);
Ku_NS_C = double(squeeze(gen.zh(:,:,:)));
Ku_NS_C(Ku_NS_C < 0) = nan;
Ku_NS_C = 10*log10(Ku_NS_C);
Ku_NS_C(Ku_NS_C < 0) = nan;
pcolor(Longitude_Ku_C, Latitude_Ku_C, (squeeze(Ku_NS_C(174,:,:))));
shading flat
hold on;
plot_TW_RCWF_LL;
axis([118 126 20 28])
set(gca, 'FontSize',18, 'FontWeight','bold');
hh = ylabel('Latitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
hh = xlabel('Longitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
colorbar
caxis([0 60])
hh = title('zFactor Calculated --- Ku');
set(hh, 'FontSize',18, 'FontWeight','bold');

% % Plot Calculated Reflectivity with Attenuation
% figure(5)
% colormap(z_88D);
% Longitude_Ku_C = Longitude_Ku(:, 2557:2737);
% Latitude_Ku_C = Latitude_Ku(:, 2557:2737);
% Ku_NS_C = double(squeeze(test.Zh_Ku_F_Att(:,:,:)));
% Ku_NS_C(Ku_NS_C < 0) = nan;
% % Ku_NS_C = 10*log10(Ku_NS_C);
% % Ku_NS_C(Ku_NS_C < 0) = nan;
% pcolor(Longitude_Ku_C, Latitude_Ku_C, (squeeze(Ku_NS_C(level,:,2557:2737))));
% shading flat
% hold on;
% plot_TW_RCWF_LL;
% axis([118 126 20 28])
% set(gca, 'FontSize',18, 'FontWeight','bold');
% hh = ylabel('Latitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% hh = xlabel('Longitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% colorbar
% caxis([0 60])
% hh = title('zFactorCalc With Attenuation --- Ku');
% set(hh, 'FontSize',18, 'FontWeight','bold');