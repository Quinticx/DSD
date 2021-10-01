% this code is for hw2
clear
% frequence = [3 10 35]*10^9;
% Lamuda = 3*10^10./frequence;

Lamuda = 2; 
% 5 cm for C band
% 10 cm for S band
% 2 cm for Ku band
% 1 cm for Ka band

% this part for question (1)
Tem_water = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];

for ll = 1:21
    real_water(ll) = real_part_water(Tem_water(ll), Lamuda);
    image_water(ll) = image_part_water(Tem_water(ll), Lamuda);
end

for ii = 1:21
    x(ii) = sqrt(real_water(ii)+j*image_water(ii))
end