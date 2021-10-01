function [Zh_S_F, Zh_C_F, A_h_S, A_h_C,  KDP_S, KDP_C] = calculate_Z_ZDR(Nw, miu, lamuda)

D = 0.1:0.1:8;
DSD = Nw*D.^miu.*exp(-lamuda*D);

[Zh_S_F, Zh_C_F, A_h_S, A_h_C, KDP_S, KDP_C] = parameter_estimation(DSD); 