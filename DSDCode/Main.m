% this code for testing my GA method for DSD retrival
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

% % Params = [Nw, Dm]
% Ku_DSD_Params = [36.35 0.8600];
% Ka_DSD_Params = [31.73 0.9400];

% % Index = [Level(bin), Ray, Scan]
% indexKu = [176, 3, 7926];
% indexKa = [81, 1, 7884];

% Load Lat and Lon on Ku and Ka
Longitude_Ku = mat.Longitude_Ku;
Latitude_Ku = mat.Latitude_Ku;
Longitude_Ka_HS = mat.Longitude_Ka_HS;
Latitude_Ka_HS = mat.Latitude_Ka_HS;


%a = [8000 0 10]; % Nw, mu, lambda   - SBand
%a = [8000 0 5]; % Nw, mu, lambda     - CBand
a = [Ku_DSD_Params(1) 0 Ku_DSD_Params(2)]; % Nw, mu, lambda    - KuBand
%a = [8000 0 1]
%a = [Ka_DSD_Params(1) 0 1]; %Nw, mu, lambda     - KaBand
fprintf("Calculating ZDR\n");
[Zh_S_F, Zh_C_F, A_H_S, A_H_C, Zh_Ku_F, Zh_Ka_F, A_h_Ku, A_h_Ka] = calculate_Z_ZDR(a(1), a(2), a(3));



