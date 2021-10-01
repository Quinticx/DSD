% Plot Vertical Structure of GPM 
clear
close all
colormap_88D;

%% Load Workspace Variables
fprintf("Loading .mat file\n");
load('mat_201857-1813.mat');
%load('Zh_Ku_Mu3_Test_without10.mat');
ma = load('Zh_Ku_Mu0_GPM_Wang_Att_Ex_Avg2.mat');
test = load('WangAttMu0ExB_Avg2.mat');
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

%% Plotting
fprintf("Plotting...");
Height = 0.25:0.25:176*0.25;
Ku_vertical = double(mat.Ku_NS_zFactorCorrected(end:-1:1,:,2557:2637));
Ku_vertical(Ku_vertical < 0) = nan;
Ku_VV_Given = mean(Ku_vertical,2, 'omitnan');
Ku_Calc = test.Zh_Ku_F_Att(end:-1:1, :, 2557:2637);
Ku_Calc(Ku_Calc < 0) = nan;
Ku_VV_Calc = mean(Ku_Calc, 2, 'omitnan');
[maxZGiven, indexG] = max(squeeze(Ku_VV_Given(:,1,80)));  % max(Red) 
[maxZCalc, indexC] = max(squeeze(Ku_VV_Calc(:,1,80)));   % max(Green)
delta = maxZGiven - maxZCalc;  % max(Red) - max(Green)



% Plot Vert. Structure of Given(Red), Calculated(Green), and deltaZ(Blue)
figure(1)
for i = 80:80
    plot((squeeze(Ku_VV_Calc(:, 1, i))), Height, 'g-', 'LineWidth', 3);   % Calculated
    hold on;
    plot(squeeze(Ku_VV_Given(:,1,i)), Height,'r-','LineWidth',3);   % Given
    hold on;
    deltaZ = squeeze(delta+(squeeze(Ku_VV_Calc(:, 1, i))));   % Delta + Green
    plot(deltaZ, Height, 'b-', 'LineWidth', 3);
    grid;
    legend('Calculated w/Attenuation','GPM Given', 'Delta Z');
    hh = title('Zh Ku F Vertical Calculated');
    set(hh, 'FontSize',18, 'FontWeight','bold');
    %pause;
    %clf;
end

% % Plot the vertical structure of given
% for ii = 1:80
%     figure(2)
%     plot(squeeze(Ku_VV(:,1,ii)), Height,'r-','LineWidth',3);
%     grid;
%     hh = title('Zh Ku Vertical GPM Given');
%     set(hh, 'FontSize',18, 'FontWeight','bold');
% %     pause;
% end

% % Plot GPM Given Reflectivity
% level = 174;
% figure(3)
% colormap(z_88D);
% Ku_NS = double(squeeze(mat.Ku_NS_zFactorCorrected(:,:,:)));
% Ku_NS(Ku_NS < 0) = nan;
% pcolor(Longitude_Ku, Latitude_Ku, squeeze(Ku_NS(level,:,:)));
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
% hh = title('zFactorCorrected GPM --- Ku');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% 
% 
% % Plot Calculated Reflectivity without Attenuation
% figure(4)
% colormap(z_88D);
% Longitude_Ku_C = Longitude_Ku(:, 2557:2737);
% Latitude_Ku_C = Latitude_Ku(:, 2557:2737);
% Ku_NS_C = double(squeeze(Zh_Ku_F(:,:,:)));
% Ku_NS_C(Ku_NS_C < 0) = nan;
% Ku_NS_C = 10*log10(Ku_NS_C);
% Ku_NS_C(Ku_NS_C < 0) = nan;
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
% hh = title('zFactor Calculated --- Ku');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% 
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

