function [Kw_Ku, fa_Ku, fb_Ku] = load_Tmatrix_Ku(temp, ROW)

lamuda_Ku = 2; 

fid = fopen([ 'Ku_band_2_B_' num2str(temp) '.dat']);
C = textscan(fid,'%s%s%s%s%s%s%s%s%s');
fclose(fid);
col = length(C);

real_rain = real_part_water(temp,lamuda_Ku);
image_rain = image_part_water(temp,lamuda_Ku);
Er = real_rain+j*image_rain;
Kw_Ku = (abs((Er-1)/(Er+2)))^2;

for ii = 3:6
    tem1 = C{ii};
    switch ii
        case 3
            for rr = 2:ROW+1
                fa_fwd_real(rr-1) = str2num(cell2mat(tem1(rr)));
            end
        case 4
            for rr = 2:ROW+1
                fa_fwd_imag(rr-1) = str2num(cell2mat(tem1(rr)));
            end
        case 5
            for rr = 2:ROW+1
                fb_fwd_real(rr-1) = str2num(cell2mat(tem1(rr)));
            end
        case 6
            for rr = 2:ROW+1
                fb_fwd_imag(rr-1) = str2num(cell2mat(tem1(rr)));
            end
        end
end

fa_Ku = fa_fwd_real + j*fa_fwd_imag;
fb_Ku = fb_fwd_real + j*fb_fwd_imag;
end