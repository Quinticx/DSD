clear
close all
load('Zh_Ku_Mu0_GPM_Wang_Att_Ex_Avg2.mat');



Zh_Ku_F_Att = Zh_Ku_F;
sum = zeros(176, 49, 2637);

% Initialize Sum
for i = 1:1
    for j = 1:1
        for k = 2457:2737
            sum(i,j,k) = A_h_Ku(i,j,k);
        end
    end
end

% Calculate All Attenuation
for i = 2:175
    for j = 2:49
        for k = 2457:2737
            sum(i,j,k) = sum(i-1,j-1,k-1) + A_h_Ku(i,j,k);
        end
    end
end


% Get Attenuated Zh
parfor x = 1:175
    disp(x);
    for j = 1:49
        for k = 2457:2737
            Zh_Ku_F_Att(x,j,k) = (10*log10(Zh_Ku_F(x,j,k)) - sum(x,j,k)*0.25);
        end
    end
end

if Zh_Ku_F_Att == Zh_Ku_F
    fprintf("They are the same");
end

save('WangAttMu0ExB_Avg2', 'Zh_Ku_F_Att');