% this code is for plot GPM data
clear
close all
colormap_88D;

%%=========================================================================
%% good one
% load mat_201857-1813.mat;
%%=========================================================================
% load mat_201857-420.mat;





load mat_201761-2056.mat;
% load mat_2017531-755.mat
% load mat_2017531-2148.mat
% load mat_201763-652.mat;


% load mat_2015420-744.mat;

Longitude_Ku = mat.Longitude_Ku;
Latitude_Ku = mat.Latitude_Ku;

Longitude_Ka_MS = mat.Longitude_Ka_MS;
Latitude_Ka_MS = mat.Latitude_Ka_MS;

Longitude_Ka_HS = mat.Longitude_Ka_HS;
Latitude_Ka_HS = mat.Latitude_Ka_HS;


Ku_NS_BBtop = double(mat.Ku_NS_BBtop);
Ku_NS_BBtop(Ku_NS_BBtop < 20) = nan;
BB_top_height = (176-Ku_NS_BBtop)*0.25;


Ku_NS_BBHeight = double(mat.Ku_NS_BBHeight)/1000;
Ku_NS_BBHeight(Ku_NS_BBHeight < 0) = nan;


% plot BB top
figure
pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), BB_top_height(:,2577-20:2577+60));
shading flat
hold on;
plot_TW_RCWF_LL;
axis([120 125 24 28])
set(gca, 'FontSize',18, 'FontWeight','bold');
hh = ylabel('Latitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
hh = xlabel('Longitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
colorbar
hh = title(['BB Top --- Ku']);
set(hh, 'FontSize',18, 'FontWeight','bold');



figure
pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), Ku_NS_BBHeight(:,2577-20:2577+60));
shading flat
hold on;
plot_TW_RCWF_LL;
axis([120 125 24 28])
set(gca, 'FontSize',18, 'FontWeight','bold');
hh = ylabel('Latitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
hh = xlabel('Longitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
colorbar
hh = title(['BB height --- Ku']);
set(hh, 'FontSize',18, 'FontWeight','bold');




count = 0;
for ii = 1:49
    for jj = 1:7932
        
        if (Latitude_Ku(ii,jj) > 22 & Latitude_Ku(ii,jj) < 28 & Longitude_Ku(ii,jj) > 118 & Longitude_Ku(ii,jj) < 124)
            count = count + 1;
            count_ii(count) = ii;
            count_jj(count) = jj;
        end
    end
end






%%=========================================================================
%% plot BB information
%%=========================================================================

% plot flag BB
figure
flagBB_Ku = double(mat.Ku_NS_flagBB);
flagBB_Ku(flagBB_Ku < 0) = nan;
pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), flagBB_Ku(:,2577-20:2577+60));
shading flat
hold on;
plot_TW_RCWF_LL;
axis([120 125 24 28])
set(gca, 'FontSize',18, 'FontWeight','bold');
hh = ylabel('Latitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
hh = xlabel('Longitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
colorbar
hh = title(['flag BB --- Ku']);
set(hh, 'FontSize',18, 'FontWeight','bold');




% plot BB top
figure
pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), (176-Ku_NS_BBtop(:,2577-20:2577+60))*0.125);
shading flat
hold on;
plot_TW_RCWF_LL;
axis([120 125 24 28])
set(gca, 'FontSize',18, 'FontWeight','bold');
hh = ylabel('Latitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
hh = xlabel('Longitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
colorbar
hh = title(['BB Top --- Ku']);
set(hh, 'FontSize',18, 'FontWeight','bold');


% plot BB top
figure
Ku_NS_BBtop = double(mat.Ku_NS_BBtop);
Ku_NS_BBtop(Ku_NS_BBtop < 20) = nan;
pcolor(Longitude_Ku, Latitude_Ku, (176-Ku_NS_BBtop)*0.125);
shading flat
hold on;
plot_TW_RCWF_LL;
set(gca, 'FontSize',18, 'FontWeight','bold');
hh = ylabel('Latitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
hh = xlabel('Longitude');
set(hh, 'FontSize',18, 'FontWeight','bold');
colorbar
hh = title(['BB Top --- Ku']);
set(hh, 'FontSize',18, 'FontWeight','bold');
