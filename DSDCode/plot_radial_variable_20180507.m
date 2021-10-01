% this code is for convert netcdf into mat
clear
% close all
colormap_88D;


%================== 00.50 ==================
% ii = 69;  %11
% load INDEX_20180507_05_2diff;
% 
% index_S = INDEX_20180507_05.Sband(ii); 
% index_C = INDEX_20180507_05.Cband(ii);
% 
% file_dir_S = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/new/RCWF/20180507/00.50';
% 
% file_name_S = dir([file_dir_S '/*.mat']);
% 
% file_dir_C = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/new/RCMD/20180507/CDD/00.50';
% file_name_C = dir([file_dir_C '/*.mat']);




%================== 06.00 ==================
% ii = 69;  %11
% load INDEX_20180507_6_2diff;
% 
% index_S = INDEX_20180507_6.Sband(ii); 
% index_C = INDEX_20180507_6.Cband(ii);
% 
% file_dir_S = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/new/RCWF/20180507/06.00';
% 
% file_name_S = dir([file_dir_S '/*.mat']);
% 
% file_dir_C = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/new/RCMD/20180507/CDD/06.00';
% file_name_C = dir([file_dir_C '/*.mat']);


%================== 09.90 ==================
load INDEX_20180507_9_2diff;

ii = 68;  %11

index_S = INDEX_20180507_9.Sband(ii); 
index_C = INDEX_20180507_9.Cband(ii);

% file_dir_S = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/new/RCWF/20180507/09.90';
file_dir_S = '/Users/bwither/Documents/Wang/Code/Radar_mat/RCWF/20180507/09.90';

file_name_S = dir([file_dir_S '/*.mat']);

% file_dir_C = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/new/RCMD/20180507/CDD/09.90';
file_dir_C = '/Users/bwither/Documents/Wang/Code/Radar_mat/RCMD/20180507/CDD/09.90';
file_name_C = dir([file_dir_C '/*.mat']);





% load  S band   
file_name_S(index_S).name
load([file_dir_S '/' file_name_S(index_S).name]);
Azimuth_S = mat.Azimuth;
GateWidth_S = mat.GateWidth;

dBZ_S = mat.Reflectivity;
ZDR_S = mat.ZDR;
PhiDP_S = mat.PhiDP;
ZDR_S(ZDR_S < -4) = nan;
ZDR_S(ZDR_S > 4) = nan;
RhoHV_S = mat.RhoHV;
RhoHV_S(RhoHV_S < 0) = nan;
PhiDP_S(PhiDP_S < 0) = nan;

dBZ_S(dBZ_S < 0) = nan;
[NumAz_S, NumGates_S] = size(dBZ_S);
RR_S = GateWidth_S(1)/1000:GateWidth_S(1)/1000:GateWidth_S(1)/1000*NumGates_S;

XPLOT_S = sin(Azimuth_S*pi/180)*RR_S;
YPLOT_S = cos(Azimuth_S*pi/180)*RR_S;

[rrr, ccc] = size(RhoHV_S);
XPLOT_S_RhoHV = sin(Azimuth_S*pi/180)*RR_S(1:ccc);
YPLOT_S_RhoHV = cos(Azimuth_S*pi/180)*RR_S(1:ccc);




% load C band
file_name_C(index_C).name
load([file_dir_C '/' file_name_C(index_C).name]);   

Azimuth_C = mat.Azimuth;
GateWidth_C = mat.GateWidth;

dBZ_C = mat.Reflectivity;
ZDR_C = mat.ZDR;
PhiDP_C = mat.uPhiDP;

ZDR_C(ZDR_C < -4) = nan;
ZDR_C(ZDR_C > 4) = nan;

RhoHV_C = mat.RhoHV;
RhoHV_C(RhoHV_C < 0) = nan;
dBZ_C(dBZ_C < 0) = nan;
PhiDP_C(PhiDP_C<0) = nan;

[NumAz_C, NumGates_C] = size(dBZ_C);
RR_C = GateWidth_C(1)/1000:GateWidth_C(1)/1000:GateWidth_C(1)/1000*NumGates_C;

XPLOT_C = RR_C'*sin(Azimuth_C*pi/180)';
YPLOT_C = RR_C'*cos(Azimuth_C*pi/180)';


%%=================================================================
% plot reflectivity
scrsz = get(0,'ScreenSize');
figure('Units','Pixels',...
'Position',[1 scrsz(4)*3/4 scrsz(3)*3/4 scrsz(4)*3/4],...
'PaperPositionMode','Auto');

subplot('position',[0.01 0.3 0.53 0.53]);
colormap(z_88D);
pcolor(XPLOT_S', YPLOT_S', dBZ_S');
shading flat
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')


subplot('position',[0.55 0.3 0.53 0.53]);
colormap(z_88D);
pcolor(XPLOT_C', YPLOT_C', dBZ_C);
shading flat
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')

%%=================================================================
% plot RhoHV
scrsz = get(0,'ScreenSize');
figure('Units','Pixels',...
'Position',[1 scrsz(4)*3/4 scrsz(3)*3/4 scrsz(4)*3/4],...
'PaperPositionMode','Auto');

subplot('position',[0.01 0.3 0.53 0.53]);
pcolor(XPLOT_S_RhoHV', YPLOT_S_RhoHV', RhoHV_S');
shading flat
caxis([0.9 1])
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')

subplot('position',[0.55 0.3 0.53 0.53]);
pcolor(XPLOT_C', YPLOT_C', RhoHV_C);
shading flat
caxis([0.9 1])
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')


%%=================================================================
% plot ZDR
scrsz = get(0,'ScreenSize');
figure('Units','Pixels',...
'Position',[1 scrsz(4)*3/4 scrsz(3)*3/4 scrsz(4)*3/4],...
'PaperPositionMode','Auto');

subplot('position',[0.01 0.3 0.53 0.53]);
pcolor(XPLOT_S_RhoHV', YPLOT_S_RhoHV', ZDR_S');
shading flat
caxis([-2 2])
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')

subplot('position',[0.55 0.3 0.53 0.53]);
pcolor(XPLOT_C', YPLOT_C', ZDR_C);
shading flat
caxis([-2 2])
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')



%%=================================================================
% plot PhiDP
scrsz = get(0,'ScreenSize');
figure('Units','Pixels',...
'Position',[1 scrsz(4)*3/4 scrsz(3)*3/4 scrsz(4)*3/4],...
'PaperPositionMode','Auto');

subplot('position',[0.01 0.3 0.53 0.53]);
pcolor(XPLOT_S_RhoHV', YPLOT_S_RhoHV', PhiDP_S');
shading flat
caxis([50 80])
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')

subplot('position',[0.55 0.3 0.53 0.53]);
pcolor(XPLOT_C', YPLOT_C', PhiDP_C);
shading flat
caxis([280 300])
colorbar
hold on;
axis image
plot_TW_RCWF_LL
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid on;
set(gca,'FontSize',20, 'FontWeight','bold')


% az1 = 0;
% az2 = 150;
% 
% 
% [a1,b1] = min(abs(Azimuth_C - az1));
% [a1,b2] = min(abs(Azimuth_C - az2));
% 
% [c,d1] = min(abs(Azimuth_S - az1));
% [c,d2] = min(abs(Azimuth_S - az2));
% 
% 
% if b2 > b1
%     b = b1:b2;
% else
%     b = [b1:360 1:b2];
% end
% 
% if d2 > d1
%     d = d1:d2;
% else
%     d = [d1:360 1:d2];
% end
% 
% figure
% subplot(221)
% plot(RR_C, nanmean(PhiDP_C(:,:),1),'r-');
% hold on;
% plot(RR_S(1:ccc), nanmean(PhiDP_S(:,:),1)+206,'b-');
% grid
% axis([10 40 260 275])
% title('PhiDP')
% 
% 
% subplot(222)
% plot(RR_C, nanmean(ZDR_C(:,:),1)+0.44,'r-');
% hold on;
% plot(RR_S(1:ccc), nanmean(ZDR_S(:,:),1),'b-');
% grid
% axis([10 40 0 1.5])
% title('ZDR')
% 
% 
% 
% subplot(223)
% plot(RR_C, nanmean(dBZ_C(:,:),1)+4,'r-');
% hold on;
% plot(RR_S(1:ccc), nanmean(dBZ_S(:,:),1),'b-');
% grid
% axis([10 40 20 35])
% title('dBZ')
% 
% subplot(224)
% plot(RR_C, nanmean(RhoHV_C(:,:),1),'r-');
% hold on;
% plot(RR_S(1:ccc), nanmean(RhoHV_S(:,:),1),'b-');
% grid
% axis([10 40 0.9 1])
% title('RhoHV')
