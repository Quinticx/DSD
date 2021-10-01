function [image] = image_part_water(t, Lamuda);

eps = eps_water(t);
eps_infit = eps_water_infit(t);
lamuda = lamuda_water(t);
alpha = alpha_water(t);
sigma = sigma_water(t);

image = (eps-eps_infit)*(lamuda/Lamuda)^(1-alpha)*cos(alpha*pi/2)/...
    ( 1+2*(lamuda/Lamuda)^(1-alpha)*sin(alpha*pi/2)+(lamuda/Lamuda)^(2*(1-alpha)) )+...
    sigma*lamuda/(18.8496*10^10);