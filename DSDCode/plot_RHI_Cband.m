%  this code is for plot the RHI 
clear
close all
colormap_88D;

%input_dir = '/Users/yadwang/SIUE/Paper/Dual_Frequency/data/mat/RCMD';
% input_dir = '/Users/bwither/Documents/Wang/Code/Radar_mat/RCMD';
input_dir = '/Users/bwither/Documents/Wang/Code/Radar_mat/RCMD/20180507/CDD';
input_dir_name = dir(input_dir);
input_file_name = dir([input_dir '/' input_dir_name(4).name '/*.mat']);
elevation = [0.5 1.4 2.4 3.4 4.3 6.0 9.9 14.6 19.5];

col = 635;


time_difference_torlerence = 5;
input_index = 33;
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
    
    % dBZ
    dBZ = nan(1, col);
%     dBZ(1:length(mat.dBZ(az_index,:))) = mat.dBZ(az_index,:);
    dBZ(1:length(mat.dBZDPQC(az_index,:))) = nanmean(mat.dBZ(az_index-1:az_index+1,:),1);
    dBZ(dBZ < 0) = nan;
    dBZ_output(ele,:) = dBZ;
    
    % RhoHV
    RhoHV = nan(1, col);
    RhoHV(1:length(mat.RhoHVDPQC(az_index,:))) = nanmean(mat.RhoHV(az_index-1:az_index+1,:),1);
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
axis([0 160 0 15]);
set(gca,'FontSize',18,'FontName','Helvetica','FontWeight','bold');
hh = xlabel('Range (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hh = ylabel('ARL (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hold on;


figure
pcolor(r_plot,z_plot,RhoHV_output)
shading flat
hh = colorbar('vert');
set(hh, 'FontSize',16,'FontName','Helvetica','FontWeight','bold');
set( get(hh,'Title'),'String','K_{DP} (^o/km)' ,'FontSize',16,'FontName','Helvetica','FontWeight','bold');
axis([0 160 0 15]);
set(gca,'FontSize',18,'FontName','Helvetica','FontWeight','bold');
hh = xlabel('Range (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hh = ylabel('ARL (km)');
set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
hold on;
caxis([0.9 1])





% %%%%%%%   from 61 to 70   %%%%%%%%%%%%%%%
% 
% for input_index = input_index_start:input_index_end
%     time = time+1;
%     ele = 0;
%     for ii = 3:length(input_dir_name)
%         ele = ele+1;
%         input_file_name = dir([input_dir '/' input_dir_name(ii).name '/*.mat']);
%         input_file_name(input_index).name
%         load([input_dir '/' input_dir_name(ii).name '/' input_file_name(input_index).name]);
%         az = 0;
%         for az_output = 80:80
%             az = az+1;
%             [junk az_index] = min(abs(az_output-mat.Azimuth));
%             KDP = mat.KDP(az_index,:);
%             KDP(find(KDP < 0)) = nan;
%             KDP_output(time, az, ele,:) = KDP;
%         end
%     end
% end
% KDP_out = squeeze(nanmean(KDP_output, 1));
% r_plot = mat.GateWidth(1)/1000:mat.GateWidth(1)/1000:col*mat.GateWidth(1)/1000;
% % z_plot = tan(elevation*pi/180)'*r_plot;
% for ii = 1:length(elevation)
%     EL = elevation(ii);
%     for jj = 1:length(r_plot)
%         R_PLOT = r_plot(jj);
%         z_plot(ii,jj) = get_height(R_PLOT,EL);
%     end
% end
% r_plot = repmat(r_plot,[7 1]);
% pcolor(r_plot,z_plot,KDP_out)
% shading flat
% hh = colorbar('vert');
% set(hh, 'FontSize',16,'FontName','Helvetica','FontWeight','bold');
% set( get(hh,'Title'),'String','K_{DP} (^o/km)' ,'FontSize',16,'FontName','Helvetica','FontWeight','bold');
% axis([0 160 0 15]);
% set(gca,'FontSize',18,'FontName','Helvetica','FontWeight','bold');
% hh = xlabel('Range (km)');
% set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
% hh = ylabel('ARL (km)');
% set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
% hold on;












% [c h] = contour(r_plot,z_plot,KDP_out,5,'LineWidth',1.5, 'LineColor', 'k');
% clabel(c,h)
% set(h, 'LevelList',[0.7747 1.1613 1.5449 1.9344])


% v1 = 0.7;
% [c h] = contour(r_plot,z_plot,KDP_out,v1,'LineWidth',1.5, 'LineColor', 'k');
% clabel(c,h,'FontSize',15)
% set(h,'linestyle',':');
% 
% 
% v2 = 1.1;
% [c h] = contour(r_plot,z_plot,KDP_out,v2,'LineWidth',1.5, 'LineColor', 'k');
% clabel(c,h,'FontSize',15)
% set(h,'linestyle','-.');
% 
% 
% v3 = 1.5;
% [c h] = contour(r_plot,z_plot,KDP_out,v3,'LineWidth',1.5, 'LineColor', 'k');
% clabel(c,h,'FontSize',15)
% set(h,'linestyle','--');
% 
% 
% v4 = 1.9;
% [c h] = contour(r_plot,z_plot,KDP_out,v4,'LineWidth',1.5, 'LineColor', 'k');
% clabel(c,h,'FontSize',15)
% set(h,'linestyle','-');
% hold on;



%%%%  for reflectivity plot
% for input_index = input_index_start:input_index_end
%     time = time+1;
%     ele = 0;
%     for ii = 3:length(input_dir_name)
%         ele = ele+1;
%         input_file_name = dir([input_dir '/' input_dir_name(ii).name '/*.mat']);
%         input_file_name(input_index).name
%         load([input_dir '/' input_dir_name(ii).name '/' input_file_name(input_index).name]);
%         az = 0;
%         for az_output = 80:80
%             az = az+1;
%             [junk az_index] = min(abs(az_output-mat.Azimuth));
%             dBZ = mat.dBZ(az_index,:);
%             dBZ(find(dBZ < 0)) = nan;
%             dBZ_output(time, az, ele,:) = dBZ;
%         end
%     end
% end
% dBZ_out = squeeze(nanmean(dBZ_output, 1));
% r_plot = mat.GateWidth(1)/1000:mat.GateWidth(1)/1000:col*mat.GateWidth(1)/1000;
% z_plot = tan(elevation*pi/180)'*r_plot;
% r_plot = repmat(r_plot,[7 1]);
% figure
% pcolor(r_plot,z_plot,dBZ_out)
% shading flat
% colorbar
% hold on
% axis([0 160 0 15]);
% set(gca,'FontSize',18,'FontName','Helvetica','FontWeight','bold');
% hh = xlabel('Range (km)');
% set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
% hh = ylabel('ARL (km)');
% set(hh,'FontSize',20,'FontName','Helvetica','FontWeight','bold');
% [c h] = contour(r_plot,z_plot,dBZ_out,5,'LineWidth',1.5, 'LineColor', 'k');
% clabel(c,h)