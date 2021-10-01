function [Kw_S, fa_S, fb_S] = load_Tmatrix_S_Forward(temp, ROW)

lamuda_S = 10; 

fid = fopen(['S_band_10_F_' num2str(temp) '.dat']);
C = textscan(fid,'%s%s%s%s%s%s');
fclose(fid);
col = length(C);

real_rain = real_part_water(temp,lamuda_S);
image_rain = image_part_water(temp,lamuda_S);
Er = real_rain+j*image_rain;
Kw_S = (abs((Er-1)/(Er+2)))^2;

for ii = 3:6
    tem1 = C{ii};
    switch ii
        case 3
            for rr = 1:ROW
                fa_fwd_real(rr) = str2num(cell2mat(tem1(rr)));
            end
        case 4
            for rr = 1:ROW
                fa_fwd_imag(rr) = str2num(cell2mat(tem1(rr)));
            end
        case 5
            for rr = 1:ROW
                fb_fwd_real(rr) = str2num(cell2mat(tem1(rr)));
            end
        case 6
            for rr = 1:ROW
                fb_fwd_imag(rr) = str2num(cell2mat(tem1(rr)));
            end
        end
end

fa_S = fa_fwd_real + j*fa_fwd_imag;
fb_S = fb_fwd_real + j*fb_fwd_imag;