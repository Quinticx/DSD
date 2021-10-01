% this code is for fitting the R-KDP relation
clear
% close all

% %%=======================================================================
% Some parameter about the Parsivel
% %%=======================================================================
D_D = [0.062 0.187 0.312 0.437 0.562 0.687 0.812 0.937 1.062 1.187 1.375...
    1.625 1.875 2.125 2.375 2.750 3.250 3.750 4.250 4.750 5.500 6.500 7.500...
    8.500 9.500 11.000 13.000 15.000 17.000 19.000 21.500 24.500];

V_D = [0.050 0.150 0.250 0.350 0.450 0.550 0.650 0.750 0.850 0.950 1.100...
    1.300 1.500 1.700 1.900 2.200 2.600 3.00 3.400 3.800 4.400 5.200 6.000...
    6.800 7.600 8.800 10.400 12.000 13.600 15.200 17.600 20.800];

L = 180;          % length of beam 180 mm (can find from manual)
B = 30;           % width of beam 30 mm (can find from manual)

S_par = 1e-6*L*(B-D_D/2);        % sample area (Raupach & Berne)

delta_T = 60;                    % measurement integration time 60s 

delta_D = [D_D(2:end)-D_D(1:end-1) 3];

% %%=======================================================================
% this part for reading DSD data
% %%=======================================================================

file_dir = './index25';



file_name = dir([file_dir '/*']);

DSD = nan(length(file_name)-4,32);
DSD_length = 0;

for ii = 4:length(file_name)
    
    % this part for read raw Disdrometer data
    fid = fopen([file_dir '/' file_name(ii).name]);
    B = textscan(fid, '%s', 'delimiter', ',');
    fclose(fid);

    if length(B{1}) > 17
        DSD_length = DSD_length + 1;
        DSD_Vel = nan(1,1024);
        for jj = 18:1041
            DSD_Vel(1,jj-17) = str2double(B{1}{jj});
        end
        DSD_Vel(isnan(DSD_Vel) == 1) = 0;


        % %%========================================================
        % this part is for reorganize DSD_Vel data into 32*32 bins (size * vel)
        DSD_inter = nan(32,32);
        count = 0;
        for jj = 1:32
            count = count + 1;
            DSD_inter(count,:) = DSD_Vel((jj-1)*32+1:jj*32);
        end


        % %%========================================================
        % this part coverting the raw number of measurement into per-diameter-class
        % DSD (Raupach & Berne)

        for jj = 1:32
            aaa = squeeze(DSD_inter(:,jj));
            DSD(DSD_length,jj) = ceil(1/(S_par(jj)*delta_D(jj)*delta_T)*sum(aaa'./V_D));
        end
    end
    
end


% figure
plot(D_D, DSD(1,:), 'r*', 'MarkerSize',9,'LineWidth',3);
hold on;
plot(D_D, DSD(2,:), 'k*', 'MarkerSize',9,'LineWidth',3);
axis([0 8 0 600])
plot(D_D, DSD(3,:), 'b*', 'MarkerSize',9,'LineWidth',3);
axis([0 8 0 600])

Disdrometer.size = D_D;
Disdrometer.DSD = DSD;

save DSD_caseIV Disdrometer

