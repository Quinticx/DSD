function [Ku_DSD_Params,Ka_DSD_Params, indexKu, indexKa, KUP, KAP] = getDSDParams(filename)
% Get Ku DSD Param
load(filename);
% Load Ku_NS_paramDSD. Has shape of (2, 176, 49, 7932)
KUP = mat.Ku_NS_paramDSD;
% Load Ka_HS_paramDSD. Has shape of (2, 88, 24, 7932)
KAP = mat.Ka_HS_paramDSD;

fprintf("Finding Ku DSD Params...\n");
% Only find positive values of Ku DSD Params. Save them and their index
for i = 1:176
    for j = 1:49
        for a = 2557:2637
            if(KUP(:, i, j, a) > 0)
                Ku_DSD_Params = KUP(:, i, j, a);
                indexKu = [i, j, a];
            end
        end
    end
end

fprintf("Finding Ka DSD Params...\n");
% Only find positive values of Ka DSD Params. Save them and their index
for a= 1:7932
    for i= 1:88
        for j = 1:24
            if(KAP(:, i, j, a) > -9999)
                Ka_DSD_Params = KAP(:, i, j, a);
                indexKa = [i, j, a];
            end
        end
    end
end

end

