%  this code is for plot the RHI 
clear
% close all
colormap_88D;

input_dir = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/mat/RCWF';
input_dir_name = dir(input_dir);
input_file_name = dir([input_dir '/' input_dir_name(4).name '/*.mat']);
elevation = [0.5 1.4 2.4 3.4 4.3 6.0 9.9 14.6 19.5];

col = 1836;


time_difference_torlerence = 5;
input_index = 50;
input_az = 91;


day_C = str2num(input_file_name(input_index).name(8));
hour_C = str2num(input_file_name(input_index).name(10:11));
minute_C = str2num(input_file_name(input_index).name(12:13));
    
    
ele = 0;
for ii = 4:length(input_dir_name)
    ele = ele+1;
    input_file_name_S = dir([input_dir '/' input_dir_name(ii).name '/*.mat']);
    
    index_S_out = nan;
    for jj = 1:length(input_file_name_S)
        day_S = str2num(input_file_name_S(jj).name(8));
        hour_S = str2num(input_file_name_S(jj).name(10:11));
        minute_S = str2num(input_file_name_S(jj).name(12:13));
        
        if ( day_C == day_S & hour_C == hour_S & abs(minute_S-minute_C) < time_difference_torlerence )
            index_S_out = jj;
            break;
        end
    end
        
        
    input_file_name_S(index_S_out).name
    load([input_dir '/' input_dir_name(ii).name '/' input_file_name_S(index_S_out).name]);
    [junk, az_index] = min(abs(input_az-mat.Azimuth));
    
    % dBZ plot
    dBZ = nan(1, col);
    dBZ(1:length(mat.dBZDPQC(az_index,:))) = nanmean(mat.dBZDPQC(az_index-2:az_index-2,:),1);
    dBZ(dBZ < 0) = nan;
    dBZ_output(ele,:) = dBZ;
    
    % RhoHV plot
    RhoHV = nan(1, col);
    RhoHV(1:length(mat.RhoHVDPQC(az_index,:))) = nanmean(mat.RhoHVDPQC(az_index-2:az_index+2,:),1);
    RhoHV(RhoHV < 0) = nan;
    RhoHV_output(ele,:) = RhoHV;
    
end

r_plot = mat.GateWidth(1)/1000:mat.GateWidth(1)/1000:col*mat.GateWidth(1)/1000;
for ii = 1:length(elevation)
    EL = elevation(ii);
    for jj = 1:length(r_plot)
        R_PLOT = r_plot(jj);
        z_plot(ii,jj) = get_height(R_PLOT,EL);
    end
end

figure
colormap(z_88D);
rr_plot = repmat(r_plot,[9 1]);
pcolor(r_plot,z_plot,dBZ_output)
shading flat
hh = colorbar('vert');
set(hh, 'FontSize',16,'FontName','Helvetica','FontWeight','bold');
set( get(hh,'Title'),'String','K_{DP} (^o/km)' ,'FontSize',16,'FontName','Helvetica','FontWeight','bold');
axis([0 160 0 16]);
set(gca,'FontSize',18,'FontName','Helvetica','FontWeight','bold');
hh = xlabel('Range (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hh = ylabel('ARL (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hold on;


figure
rr_plot = repmat(r_plot,[9 1]);
pcolor(r_plot,z_plot,RhoHV_output)
shading flat
hh = colorbar('vert');
set(hh, 'FontSize',16,'FontName','Helvetica','FontWeight','bold');
set( get(hh,'Title'),'String','K_{DP} (^o/km)' ,'FontSize',16,'FontName','Helvetica','FontWeight','bold');
axis([0 160 0 16]);
set(gca,'FontSize',18,'FontName','Helvetica','FontWeight','bold');
hh = xlabel('Range (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hh = ylabel('ARL (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hold on;
caxis([0.9 1])





%%=========================================================================
% this part is for mean plot