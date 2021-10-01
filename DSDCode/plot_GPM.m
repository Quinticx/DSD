% this code is for plot GPM data
clear
% close all
colormap_88D;

%%=========================================================================
%% good one
load mat_201857-1813.mat;
%%=========================================================================






% load mat_201761-2056.mat;
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


%%=========================================================================
%%    find the correct location
%%=========================================================================
% count = 0;
% for ii = 1:49
%     for jj = 1:7932
%         
%         if (Latitude_Ku(ii,jj) > 25.21 & Latitude_Ku(ii,jj) < 25.22 & Longitude_Ku(ii,jj) > 121.5 & Longitude_Ku(ii,jj) < 121.6)
%             count = count + 1;
%             count_ii(count) = ii;
%             count_jj(count) = jj;
%         end
%     end
% end
% 
% 
% count = 0;
% for ii = 1:49
%     for jj = 1:7932
%         
%         if (Latitude_Ku(ii,jj) > -5.15 & Latitude_Ku(ii,jj) < -5.1 & Longitude_Ku(ii,jj) > -77.2 & Longitude_Ku(ii,jj) < -77.1)
%             count = count + 1;
%             count_ii_no_typoon(count) = ii;
%             count_jj_no_typoon(count) = jj;
%         end
%     end
% end
% 
% 
% 
% 
% count = 0;
% for ii = 1:25
%     for jj = 1:7932
%         
%         if (Latitude_Ka_MS(ii,jj) > 25.21 & Latitude_Ka_MS(ii,jj) < 25.22 & Longitude_Ka_MS(ii,jj) > 121.5 & Longitude_Ka_MS(ii,jj) < 121.6)
%             count = count + 1;
%             count_ii_ka(count) = ii;
%             count_jj_ka(count) = jj;
%         end
%     end
% end
% 
% 
% count = 0;
% for ii = 1:24
%     for jj = 1:7932
%         
%         if (Latitude_Ka_HS(ii,jj) > -5.15 & Latitude_Ka_HS(ii,jj) < -5.1 & Longitude_Ka_HS(ii,jj) > -77.2 & Longitude_Ka_HS(ii,jj) < -77.1)
%             count = count + 1;
%             count_ii_ka_no_typoon(count) = ii;
%             count_jj_ka_no_typoon(count) = jj;
%         end
%     end
% end



% Figure 1
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
hh = title('zFactorCorrected --- Ku');
set(hh, 'FontSize',18, 'FontWeight','bold');

% Figure 2
level = 174;
figure
colormap(z_88D);
Ku_NS = double(squeeze(mat.Ku_NS_zFactorMeasured(:,:,:)));
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


% Figure 2
%%=========================================================================
%%  plot the truncated figure
%%=========================================================================
figure
colormap(z_88D);
for ii = 1:9
    subplot(3,3, ii)
    
    pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), squeeze(Ku_NS(176-ii*5,:,2577-20:2577+60)) );
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
    hh = title(['zFactorMeasured --- Ku' 176-ii*2]);
    set(hh, 'FontSize',18, 'FontWeight','bold');
end

% Figure 3
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



% Figure 4
% plot BB top
figure
Ku_NS_BBtop = double(mat.Ku_NS_BBtop);
Ku_NS_BBtop(Ku_NS_BBtop < 20) = nan;
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


% Figure 5
% plot precipitation type 
figure
Ku_typePrecip = double(mat.Ku_typePrecip);
Ku_typePrecip(Ku_typePrecip < 0) = nan;
pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), Ku_typePrecip(:,2577-20:2577+60)/1e7);
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
hh = title(['Precipiation Type --- Ku']);
set(hh, 'FontSize',18, 'FontWeight','bold');


% Figure 6
% plot precipitation rate near surface
figure
Ku_NS_precipRateNearSurface = double(mat.Ku_NS_precipRateNearSurface);
Ku_NS_precipRateNearSurface(Ku_NS_precipRateNearSurface < 0) = nan;
pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), Ku_NS_precipRateNearSurface(:,2577-20:2577+60));
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
hh = title(['Precipiation rate near surface']);
set(hh, 'FontSize',18, 'FontWeight','bold');




% plot BB bottom
% figure
% Ku_NS_BBbottome = mat.Ku_NS_BBbottome;
% Ku_NS_BBbottome(Ku_NS_BBbottome < 20) = 176;
% pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), (176-Ku_NS_BBbottome(:,2577-20:2577+60))*0.25);
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
% hh = title(['BB Bottom --- Ku']);
% set(hh, 'FontSize',18, 'FontWeight','bold');
% 
% 
% % plot BB peak
% figure
% Ku_NS_BBpeak = mat.Ku_NS_BBpeak;
% Ku_NS_BBpeak(Ku_NS_BBpeak < 20) = 176;
% pcolor(Longitude_Ku(:,2577-20:2577+60), Latitude_Ku(:,2577-20:2577+60), (176-Ku_NS_BBpeak(:,2577-20:2577+60))*0.25);
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
% hh = title(['BB peak --- Ku']);
% set(hh, 'FontSize',18, 'FontWeight','bold');


% Figure 7
%%=========================================================================
%%  plot the truncated RHI
%%=========================================================================
Height = 0.125:0.125:176*0.125;
Range = 1:1:81;
Ku_vertical = double(mat.Ku_NS_zFactorCorrected(end:-1:1,:,2577-20:2577+60));
Ku_vertical(Ku_vertical < 0) = nan;
Ku_VV = nanmean(Ku_vertical,2);

z_plot = nan(176,81);
for ii = 1:176
    for jj = 1:81
        z_plot(ii,jj) = Height(ii);
    end
end
r_plot = repmat(Range,[176 1]);


% Figure 8
figure
colormap(z_88D);
pcolor(r_plot, z_plot, squeeze(Ku_VV));
shading flat;

% 
% % Figure 9
% %% . plot the vertical structure
% for ii = 1:80
%     figure(8)
%     plot(squeeze(Ku_VV(:,1,ii)), Height,'r-','LineWidth',3);
%     grid
%     pause
% end


% Figure 10
figure
uuu1 = double(mat.Ku_NS_zFactorCorrected(end:-1:1,count_ii,count_jj));
uuu1(uuu1 < 0) = nan;
plot(uuu1, Height,'r-','LineWidth',3);
hold on;


uuu2 = double(mat.Ku_NS_zFactorCorrected(end:-1:1,count_ii_no_typoon,count_jj_no_typoon));
uuu2(uuu2 < 0) = nan;
plot(uuu2, Height,'r--','LineWidth',3);



aaa1 = double(mat.Ka_MS_zFactorCorrected(end:-1:1,count_ii_ka,count_jj_ka));
aaa1(aaa1 < 0) = nan;
plot(aaa1, Height,'b-','LineWidth',3);

aaa2 = double(mat.Ka_MS_zFactorCorrected(end:-1:1,count_ii_ka_no_typoon,count_jj_ka_no_typoon));
aaa2(aaa2 < 0) = nan;
plot(aaa2, Height,'b--','LineWidth',3);
grid


hh = legend('Ku', 'Ku', 'Ka', 'Ka');
set(hh,'FontSize',20, 'FontWeight', 'bold');
set(gca,'FontSize',20, 'FontWeight', 'bold');


% Figure 11
figure
plot(uuu1-aaa1, Height,'r-','LineWidth',3);
grid;
hold on
plot(uuu2-aaa2, Height,'b-','LineWidth',3);















% (176-Ku_NS_BBbottome(36,2590))*0.25
% (176-Ku_NS_BBtop(36,2590))*0.25





% ref_vertical = mat.Ku_NS_zFactorCorrected(:,count_ii, count_jj);


% figure
% Ku_NS = squeeze(mat.Ku_NS_zFactorCorrected(level,:,:));
% Ku_NS(Ku_NS < 0) = nan;
% pcolor(Longitude_Ku(count_ii, count_jj), Latitude_Ku(count_ii, count_jj), Ku_NS(count_ii, count_jj));
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








% figure
% Ka_MS = squeeze(mat.Ka_MS_zFactorCorrected(level,:,:));
% Ka_MS(Ka_MS < 0) = nan;
% pcolor(Longitude_Ka_MS, Latitude_Ka_MS, Ka_MS);
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
% hh = title('zFactorMeasured --- Ka');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% 
% 
% figure
% subplot(121)
% Ku_NS_flagPrecip = squeeze(mat.Ku_NS_precipRateNearSurface);
% pcolor(Longitude_Ku, Latitude_Ku, Ku_NS_flagPrecip);
% shading flat
% hold on;
% plot_TW_RCWF_LL;
% axis([118 123 23 26])
% set(gca, 'FontSize',18, 'FontWeight','bold');
% hh = ylabel('Latitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% hh = xlabel('Longitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% colorbar
% hh = title('precipRateNearSurface');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% 
% 
% subplot(122)
% Ka_MS_flagPrecip = squeeze(mat.Ka_MS_precipRateNearSurface);
% pcolor(Longitude_Ka_MS, Latitude_Ka_MS, Ka_MS_flagPrecip);
% shading flat
% hold on;
% plot_TW_RCWF_LL;
% axis([118 123 23 26])
% set(gca, 'FontSize',18, 'FontWeight','bold');
% hh = ylabel('Latitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% hh = xlabel('Longitude');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% colorbar
% hh = title('precipRateNearSurface');
% set(hh, 'FontSize',18, 'FontWeight','bold');
% 
% % 
% % figure
% % subplot(121)
% % Ku_NS_zFactorCorrectedNearSurface = squeeze(mat.Ku_NS_zFactorCorrectedNearSurface);
% % Ku_NS_zFactorCorrectedNearSurface(Ku_NS_zFactorCorrectedNearSurface < 0) = nan;
% % pcolor(Longitude_Ku, Latitude_Ku, Ku_NS_zFactorCorrectedNearSurface);
% % shading flat
% % hold on;
% % plot_TW_RCWF_LL;
% % axis([118 123 23 26])
% % set(gca, 'FontSize',18, 'FontWeight','bold');
% % hh = ylabel('Latitude');
% % set(hh, 'FontSize',18, 'FontWeight','bold');
% % hh = xlabel('Longitude');
% % set(hh, 'FontSize',18, 'FontWeight','bold');
% % colorbar
% % hh = title('precipRateNearSurface');
% % set(hh, 'FontSize',18, 'FontWeight','bold');
% % 
% % 
% % subplot(122)
% % Ka_MS_zFactorCorrectedNearSurface = squeeze(mat.Ka_MS_zFactorCorrectedNearSurface);
% % Ka_MS_zFactorCorrectedNearSurface(Ka_MS_zFactorCorrectedNearSurface < 0) = nan;
% % pcolor(Longitude_Ka_MS, Latitude_Ka_MS, Ka_MS_zFactorCorrectedNearSurface);
% % shading flat
% % hold on;
% % plot_TW_RCWF_LL;
% % axis([118 123 23 26])
% % set(gca, 'FontSize',18, 'FontWeight','bold');
% % hh = ylabel('Latitude');
% % set(hh, 'FontSize',18, 'FontWeight','bold');
% % hh = xlabel('Longitude');
% % set(hh, 'FontSize',18, 'FontWeight','bold');
% % colorbar
% % hh = title('precipRateNearSurface');
% % set(hh, 'FontSize',18, 'FontWeight','bold');
% 
% 
% 
% 
% % 
% % 
% % % subplot(133)
% % % Ka_HS = squeeze(mat.Ka_HS(175,:,:));
% % % Ka_HS(Ka_HS < 0) = nan;
% % % pcolor(Longitude_Ka_HS, Latitude_Ka_HS, Ka_HS);
% % % shading flat
% % % hold on;
% % % plot_TW_RCWF_LL;
% % % axis([118 123 23 26])
% % 
% % 
% % % figure
% % % aa = squeeze(mat.data(174,:,:));
% % % aa(aa < 0) = nan;
% % % pcolor( aa);
% % % pcolor(Longitude, Latitude, aa);
% % % shading flat
% % % hold on;
% % % plot_TW_RCWF_LL;
% % % axis([110 145 0 30])