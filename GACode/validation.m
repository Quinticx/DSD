% code for plot observation and retrival
clear
close all

load result_25.mat;

plot(observation_dB(1:17, 1), 'r-*', 'LineWidth', 3);
hold on;
plot(retreivel_dB(1:17, 1), 'b-*', 'LineWidth', 3);
hh = legend('corrected observation', 'retrieved');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
hh = xlabel('gate index');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
hh = ylabel('Reflectivity S-band (dB)');
grid
set(hh,'FontSize', 24, 'FontWeight', 'bold');
set(gca,'FontSize', 24, 'FontWeight', 'bold')


% plot(observation_dB(1:17, 2), 'r-*');
% hold on;
% plot(retreivel_dB(1:17, 2), 'b-*');

figure
plot(observation_dB(1:17, 3), 'r-*', 'LineWidth', 3);
hold on;
plot(retreivel_dB(1:17, 3), 'b-*', 'LineWidth', 3);
hh = legend('corrected observation', 'retrieved');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
hh = xlabel('gate index');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
hh = ylabel('KDP S-band (degree/km)');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
set(gca,'FontSize', 24, 'FontWeight', 'bold');
grid;



figure
plot(observation_dB(1:17, 4), 'r-*', 'LineWidth', 3);
hold on;
plot(retreivel_dB(1:17, 4), 'b-*', 'LineWidth', 3);
hh = xlabel('gate index');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
hh = legend('corrected observation', 'retrieved');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
hh = ylabel('KDP C-band (degree/km)');
set(hh,'FontSize', 24, 'FontWeight', 'bold');
set(gca,'FontSize', 24, 'FontWeight', 'bold');
grid

figure
Nw = 6000; %DSD(17,1);
miu = 1.983; %DSD(17,2);
lamuda = 2.93; %DSD(17,3);
D = 0.1:0.1:8;
DSD2 = Nw*D.^miu.*exp(-lamuda*D);
plot(D, DSD2, 'r-')
