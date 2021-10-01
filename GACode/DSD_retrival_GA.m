% this code for testing my GA method for DSD retrival
clear
close all

% load Simu_DSD_466950_index23_halfdegree_single.mat;
load Simu_DSD_466950_index25_halfdegree.mat;

lb=[100 -2 0];
ub=[1e8 15 20];



gaDat.Objfun='objfun_DSD';
gaDat.FieldD=[lb; ub];


count = 0;
r = 4;


fileID = fopen('results.txt','w');
gaDat.fileID = fileID;

for index = 2:17 %N
    index
    if index == 2
        
        Z_S_dB = double(Simu_DSD.Z_S(index)); 
        Z_C_dB = double(Simu_DSD.Z_C(index)); 
        KDP_S = double(Simu_DSD.KDP_S(index));
        KDP_C = double(Simu_DSD.KDP_C(index));
        Zh_S = 10.^(Z_S_dB/10);
        Zh_C = 10.^(Z_C_dB/10);
        
%         observation = [Zh_S Zh_C KDP_S KDP_C]; 
        
        observation = [Zh_S nan KDP_S nan];
        gaDat.ObjfunPar = observation;
        gaDat=ga(gaDat);
        
        a = gaDat.xmin;
        
        [Zh_S_F, Zh_C_F, A_H_S, A_H_C, KDP_S_F, KDP_C_F] = calculate_Z_ZDR(a(1), a(2), a(3));
        
        observation_dB(index,:) = [Z_S_dB Z_C_dB KDP_S KDP_C];
        retreivel_dB(index,:) = [10*log10(Zh_S_F) 10*log10(Zh_C_F) KDP_S_F KDP_C_F];
        
        DSD(index,:) = a;
        
        Z_C_cali = 10*log10(Zh_C_F) - Z_C_dB;

    else
        
        count = count + 1;
        Nw = DSD(index-1,1);
        miu = DSD(index-1,2);
        lamuda = DSD(index-1,3);

        [Zh_S_F, Zh_C_F, A_H_S, A_H_C, KDP_S_F, KDP_C_F] = calculate_Z_ZDR(Nw, miu, lamuda);
        
        Z_S_dB = double(Simu_DSD.Z_S(index)); 
        Z_C_dB = double(Simu_DSD.Z_C(index)) + Z_C_cali; 
        
        A_h_S(count) = A_H_S;
        A_h_C(count) = A_H_C;
        


        for ii = 1:count
            Z_S_dB = Z_S_dB + A_h_S(ii) * r;
            Z_C_dB = Z_C_dB + A_h_C(ii) * r;

        end
        
        Zh_S = 10.^(Z_S_dB/10);
        Zh_C = 10.^(Z_C_dB/10);
        KDP_S = double(Simu_DSD.KDP_S(index));
        KDP_C = double(Simu_DSD.KDP_C(index));
        
        
%         observation = [Zh_S Zh_C KDP_S KDP_C]; 
        observation = [Zh_S nan KDP_S KDP_C]; 
        gaDat.ObjfunPar = observation;
        gaDat=ga(gaDat);

        a = gaDat.xmin;
        
        [Zh_S_F, Zh_C_F, A_S,  A_C, KDP_S_F, KDP_C_F] = calculate_Z_ZDR(a(1), a(2), a(3));
        
        observation_dB(index,:) = [Z_S_dB Z_C_dB KDP_S KDP_C];
        retreivel_dB(index,:) = [10*log10(Zh_S_F) 10*log10(Zh_C_F) KDP_S_F KDP_C_F];
        
        DSD(index,:) = a;

    end
   


end

fclose(fileID);

% save result_466950_index24_halfdegree_new.mat
% PhiDP_S_fit(1) = 68.4479;
% PhiDP_C_fit(1) = 0.7361;
% 
% for ii = 2:10
%     PhiDP_S_fit(ii) = PhiDP_S_fit(ii-1) + kdp_s(ii-1)*r*2;
%     PhiDP_C_fit(ii) = PhiDP_C_fit(ii-1) + kdp_c(ii-1)*r*2;
% end
% 
% 
% figure
% plot(1:10, double(Simu_DSD.PhiDP_S(1:10)), 'r-*');
% hold on;
% plot(1:10, PhiDP_S_fit, 'k-*');
% 
% 
% figure
% plot(1:10, double(Simu_DSD.PhiDP_C(1:10)), 'r-*');
% hold on;
% plot(1:10, PhiDP_C_fit, 'k-*');
% 
    
 
