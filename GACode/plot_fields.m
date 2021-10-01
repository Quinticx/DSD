% this code is for convert netcdf into mat
clear
close all
colormap_88D;

time_difference_torlerence = 1;


% output azimuth index 60 ~ 120 ()
% az_out = 125;



file_dir_S = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/mat/RCWF/00.50';
file_name_S = dir([file_dir_S '/*.mat']);

file_dir_C = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/mat/RCMD/00.50';
file_name_C = dir([file_dir_C '/*.mat']);
total = 0;


index_C = 1;
    
load([file_dir_C '/' file_name_C(index_C).name]);
file_name_C(index_C).name

day_C = str2num(file_name_C(index_C).name(8));
hour_C = str2num(file_name_C(index_C).name(10:11));
minute_C = str2num(file_name_C(index_C).name(12:13));

index_S_out = 0;
for index_S = 1:length(file_name_S)
    day_S = str2num(file_name_S(index_S).name(8));
    hour_S = str2num(file_name_S(index_S).name(10:11));
    minute_S = str2num(file_name_S(index_S).name(12:13));
    if (day_C == day_S  & abs(hour_C*60+minute_C-hour_S*60-minute_S) < time_difference_torlerence )
        index_S_out = index_S;
        break;
    end
end
    
    

% load  S band
index_S = index_S_out;   
load([file_dir_S '/' file_name_S(index_S).name]);
file_name_S(index_S).name

Azimuth_S = mat.Azimuth;
GateWidth_S = mat.GateWidth;
dBZ_S = mat.dBZDPQC(:,1:1196);
ZDR_S = mat.ZDRDPQC;
RhoHV_S = mat.RhoHVDPQC;
PhiDP_S = mat.PhiDPDPQC;

dbz_s = dBZ_S;
rhohv_s = RhoHV_S;


ZDR_S(dbz_s < 0 | rhohv_s < 0.9) = nan;
PhiDP_S(dbz_s < 0 | rhohv_s < 0.9) = nan;
dBZ_S(dbz_s < 0 | rhohv_s < 0.9 ) = nan;


[NumAz_S, NumGates_S] = size(RhoHV_S);
RR_S = GateWidth_S(1)/1000:GateWidth_S(1)/1000:GateWidth_S(1)/1000*NumGates_S;

XPLOT_S = sin(Azimuth_S*pi/180)*RR_S;
YPLOT_S = cos(Azimuth_S*pi/180)*RR_S;

[rrr, ccc] = size(RhoHV_S);
XPLOT_S_RhoHV = sin(Azimuth_S*pi/180)*RR_S(1:ccc);
YPLOT_S_RhoHV = cos(Azimuth_S*pi/180)*RR_S(1:ccc);



% load C band
load([file_dir_C '/' file_name_C(index_C).name]);   

Azimuth_C = mat.Azimuth;
GateWidth_C = mat.GateWidth;

dBZ_C = mat.dBZ;
ZDR_C = mat.ZDRDPQC;
RhoHV_C = mat.RhoHVDPQC;
PhiDP_C = mat.PhiDPDPQC;

dbz_c = dBZ_C;
rhohv_c = RhoHV_C;

ZDR_C(dbz_c < 0| rhohv_c < 0) = nan;
PhiDP_C(dbz_c < 0| rhohv_c < 0 ) = nan;
dBZ_C(dbz_c < 0| rhohv_c < 0 ) = nan;


[NumAz_C, NumGates_C] = size(RhoHV_C);
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
plot_TW_RCWF
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid_on;
set(gca,'FontSize',20, 'FontWeight','bold')


subplot('position',[0.55 0.3 0.53 0.53]);
colormap(z_88D);
pcolor(XPLOT_C', YPLOT_C', dBZ_C);
shading flat
colorbar
hold on;
axis image
plot_TW_RCWF
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid_on;
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
plot_TW_RCWF
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid_on;
set(gca,'FontSize',20, 'FontWeight','bold')

subplot('position',[0.55 0.3 0.53 0.53]);
pcolor(XPLOT_C', YPLOT_C', RhoHV_C);
shading flat
caxis([0.9 1])
colorbar
hold on;
axis image
plot_TW_RCWF
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid_on;
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
plot_TW_RCWF
axis([-300 300 -300 300])
hh = title(file_name_S(index_S).name(1:15));
set(hh,'FontSize',20);
grid_on;
set(gca,'FontSize',20, 'FontWeight','bold')

subplot('position',[0.55 0.3 0.53 0.53]);
pcolor(XPLOT_C', YPLOT_C', PhiDP_C);
shading flat
caxis([280 300])
colorbar
hold on;
axis image
plot_TW_RCWF
axis([-300 300 -300 300])
hh = title(file_name_C(index_C).name(1:15));
set(hh,'FontSize',20);
grid_on;
set(gca,'FontSize',20, 'FontWeight','bold')

