% Plot GPM Reflectivity
clear
close all
colormap_88D;

mat = load('mat_201857-1813.mat');
Ku_DSD_Params = [36.35; 0.8600];
Ka_DSD_Params = [31.73; 0.9400];
% load Ku Lat and Lon
Longitude_Ku = mat.mat.Longitude_Ku;
Latitude_Ku = mat.mat.Latitude_Ku;

a = [8000 0 2]; % Nw, mu, lambda    - KuBand
[Zh_S_F, Zh_C_F, A_H_S, A_H_C, Zh_Ku_F, Zh_Ka_F, A_h_Ku, A_h_Ka] = calculate_Z_ZDR(a(1), a(2), a(3));

% plot reflectivity
scrsz = get(0,'ScreenSize');
figure('Units','Pixels',...
'Position',[1 scrsz(4)*3/4 scrsz(3)*3/4 scrsz(4)*3/4],...
'PaperPositionMode','Auto');
subplot('position',[0.01 0.3 0.53 0.53]);
colormap(z_88D);
pcolor(Longitude_Ku, Latitude_Ku, Zh_Ku_F);
shading flat
colorbar
hold on;
axis image
plot_TW_RCWF_LL;
axis([118 126 20 28])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')