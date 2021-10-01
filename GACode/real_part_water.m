function [real] = real_part_water(t, Lamuda)

eps = eps_water(t);
eps_infit = eps_water_infit(t);
lamuda = lamuda_water(t);
alpha = alpha_water(t);
sigma = sigma_water(t);

real = eps_infit+ (eps-eps_infit)*(1+(lamuda/Lamuda)^(1-alpha)*sin(alpha*pi/2))/...
    ( 1+2*(lamuda/Lamuda)^(1-alpha)*sin(alpha*pi/2)+(lamuda/Lamuda)^(2*(1-alpha)) );