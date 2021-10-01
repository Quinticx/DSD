clear
close all

Nw = 30;
mu = 3;
Dm = 3;
D = 0.1:0.1:8;

GDSD = Nw*(6/(4^4))*(((4+mu)^(mu+4))/gamma(mu+4))*((D/Dm).^mu).*exp(-(4+mu)*(D/Dm));


DSD = Nw*(D.^mu).*exp((-(4+mu)*D)/Dm);

if (GDSD == DSD)
    fprintf("Yes");
end

if (GDSD ~= DSD)
    fprintf("No");
end
