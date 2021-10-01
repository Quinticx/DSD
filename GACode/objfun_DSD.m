function value =objfun_DSD(x, observation)


D = 0.1:0.1:8;
DSD = x(1)*D.^x(2).*exp(-x(3)*D);

[Zh_S_F, Zh_C_F, A_h_S, A_h_C, KDP_S, KDP_C] = parameter_estimation(DSD); 



% if observation(2) == 0
%     value = abs(observation(1)-Zh_S_F)  + 5000*abs(observation(3)-KDP_S) + 5000*abs(observation(4)-KDP_C);
% else
%     
%     value = abs(observation(1)-Zh_S_F)  + abs(observation(2)-Zh_C_F) + 5000*abs(observation(3)-KDP_S) + 5000*abs(observation(4)-KDP_C);
% end

% factor = observation(1)/observation(3)/2;

%======= new try
observation(observation < 0) = nan;

comparsion = [abs(observation(1)-Zh_S_F)/observation(1)   abs(observation(2)-Zh_C_F)/observation(2)  abs(observation(3)-KDP_S)/observation(3)  abs(observation(4)-KDP_C)/observation(4)];

value = nansum(comparsion);




% value = abs(observation(1)-Zh_S_F)  + 5000*abs(observation(3)-KDP_S);

% value = abs(observation(3)-KDP_S);
