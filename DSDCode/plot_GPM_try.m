% this code is for plot GPM data
clear
close all
colormap_88D;

% good case: precipitation on north Taiwan, good for RCWF and RCMD
%% we have both radar and GPM data, we can start from this case ******
load mat_201857-1813.mat




%%=========================================================================
%%%% =============== 2014 ============= %%%%%
% load mat_2014618-118.mat	
% load mat_2014810-1933.mat
% load mat_2014723-16.mat  %% good case

	
%%=========================================================================
%%%% =============== 2015 ============= %%%%%
% load mat_2015722-449.mat	%%% OK
% load mat_2015828-1745.mat  %% good case
% load mat_201576-920.mat	%% good case
% load mat_2015831-251.mat   %% good case
% load mat_2015812-824.mat   %% OK


%%=========================================================================
%%%% =============== 2016 ============= %%%%%
% load mat_2016611-540.mat	%% good case
% load mat_2016817-101.mat  %% good case
% load mat_2016613-1446.mat	
% load mat_2016828-647.mat  %% so so
% load mat_201672-917.mat  %% good case



%%=========================================================================
%%%% =============== 2017 ============= %%%%%
% load mat_201733-2355.mat	
% load mat_2017613-1818.mat

%% good case  best for RCWF & RCMD
% load mat_2017421-943.mat	

%% so so case. cover west coast, Maybe RCWF can cover a little bit. (we have data)
% load mat_2017616-322.mat  

% load mat_2017512-1322.mat	

%% good case  at south part of Taiwan, good for RCKT
% load mat_2017716-835.mat  


%%========================================================================
%%%% =============== 2018 ============= %%%%%
%% good case light rain at west coast to north, could be used for RCWF analysis
% load mat_201814-619.mat	

% good case: precipitation on north Taiwan, good for RCWF and RCMD
% load mat_201816-1525.mat 


%%  too far away from Taiwan
% load mat_201857-420.mat  

% good case: precipitation on north Taiwan, good for RCWF and RCMD
%% we have both radar and GPM data, we can start from this case ******
% load mat_201857-1813.mat


% good case: precipitation on north Taiwan, good for RCWF and RCMD
% load mat_201866-936.mat     


%% Ok case. There is an isolated cells on north, could be used for RCWF and RCMD
% load mat_201898-614.mat	





Longitude_Ku = mat.Longitude_Ku;
Latitude_Ku = mat.Latitude_Ku;

Longitude_Ka_MS = mat.Longitude_Ka_MS;
Latitude_Ka_MS = mat.Latitude_Ka_MS;

Longitude_Ka_HS = mat.Longitude_Ka_HS;
Latitude_Ka_HS = mat.Latitude_Ka_HS;



level = 174;
figure
colormap(z_88D);
Ku_NS = double(squeeze(mat.Ku_NS_zFactorCorrected(:,:,:)));
Ku_NS(Ku_NS < 0) = nan;
pcolor(Longitude_Ku, Latitude_Ku, squeeze(Ku_NS(level,:,:)));
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
hh = title('zFactorMeasured --- Ku');
set(hh, 'FontSize',18, 'FontWeight','bold');
plot_disdrometer;
plot_radar;


level = 174;
figure
colormap(z_88D);
Ka_MS = double(squeeze(mat.Ka_MS_zFactorCorrected(:,:,:)));
Ka_MS(Ka_MS < 0) = nan;
pcolor(Longitude_Ka_MS, Latitude_Ka_MS, squeeze(Ka_MS(level,:,:)));
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
hh = title('zFactorMeasured --- Ku');
set(hh, 'FontSize',18, 'FontWeight','bold');
plot_disdrometer;
plot_radar


% level = 173;
% figure
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
% hh = title('zFactorMeasured --- Ku');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% plot_disdrometer;
% 
% 
% level = 166;
% figure
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
% hh = title('zFactorMeasured --- Ku');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% plot_disdrometer;



sel_ll = [25.0396, 121.5067];

[a,b] = find(abs(sel_ll(1,1) - mat.Latitude_Ku) < 0.02 & abs(sel_ll(1,2) - mat.Longitude_Ku) < 0.01);
mat.Latitude_Ku(a, b)
mat.Longitude_Ku(a, b)

ref = squeeze(mat.Ku_NS_zFactorCorrected(:,a, b));
ref(ref < 0 ) = 0;


DSD_Ku = mat.Ku_NS_paramDSD(:, :, a, b);


[a2,b2] = find(abs(sel_ll(1,1) - mat.Latitude_Ka_MS) < 0.02 & abs(sel_ll(1,2) - mat.Longitude_Ka_MS) < 0.01);
mat.Latitude_Ka_MS(a2, b2)
mat.Longitude_Ka_MS(a2, b2)

ref2 = squeeze(mat.Ka_MS_zFactorCorrected(:,a2, b2));
ref2(ref2 < 0 ) = 0;

Height = 176*0.25:-0.25:0.25;

figure
plot(ref, Height, 'b-', 'LineWidth', 3)
hold on;
plot(ref2,Height,'r-', 'LineWidth', 3)




% plot precipitation type 
% figure
% Ku_typePrecip = double(mat.Ku_typePrecip);
% Ku_typePrecip(Ku_typePrecip < 0) = nan;
% pcolor(Longitude_Ku, Latitude_Ku, );
% shading flat
% hold on;
% plot_TW_RCWF_LL;
% axis([120 125 24 28])
% set(gca, 'FontSize',18, 'FontWeight','bold');
% hh = ylabel('Latitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% hh = xlabel('Longitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% colorbar
% hh = title(['Precipiation Type --- Ku']);
% set(hh, 'FontSize',18, 'FontWeight','bold');