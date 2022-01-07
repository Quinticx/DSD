% Load GPM data
load('mat_201857-1813.mat');

TMF = TMatrix('Ku_band_2_F_0.dat');
TMB = TMatrix('Ku_band_2_B_0.dat');
Kw = calculateKw(0, 2);

% Load Ku_NS_paramDSD. Has shape of (2, 176, 49, 7932) 
% [nDSD, nBin, nRay, nScan]
KUP = mat.Ku_NS_paramDSD;


tic
[zh, ah] = calculateRawZhAh(2, TMF, TMB, Kw, KUP(:,:,:,2457:2737));
%[zh, ah] = calculateRawZhAh(2, TMF, TMB, Kw, KUP(:,:,:,:));
size(zh)
size(ah)
toc

save('zhahGeneral.mat', 'zh', 'ah');