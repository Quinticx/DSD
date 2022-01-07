function [zh, ah] = calculateRawZhAh(lambda, TMF, TMB, Kw, paramDSD)
    % Calculates Zh and Ah for each sample in data
    zh_temp = size(paramDSD);
    zh = zeros(zh_temp(2:end));
    ah_temp = size(paramDSD);
    ah = zeros(ah_temp(2:end));
    for i = 1:size(paramDSD, 2)
        disp(i)
        for j = 1:size(paramDSD, 3)
            for k = 1:size(paramDSD, 4)
                [Zh, A_h] = calculateZhAh(lambda, paramDSD(1, i, j, k), 0, paramDSD(2, i, j, k), TMF, TMB, Kw);
                zh(i, j, k) = Zh;
                ah(i, j, k) = A_h;
            end
        end
    end
end

