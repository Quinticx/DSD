function [height] = get_height(PLOT_RANGE,elevation)

eradius = 6371;
frthrde = (4.*eradius/3.);
eighthre = (8.*eradius/3.);
fthsq = (frthrde*frthrde);
deg2rad = (3.14592654/180.);
elvrad = deg2rad*elevation;

height = sqrt(PLOT_RANGE.*PLOT_RANGE + fthsq + eighthre*PLOT_RANGE*sin(elvrad)) - frthrde;