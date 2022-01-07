function [Kw] = calculateKw(temp,lambda)
real_rain = real_part_water(temp,lambda);
image_rain = image_part_water(temp,lambda);
Er = real_rain+j*image_rain;
Kw = (abs((Er-1)/(Er+2)))^2;
end

