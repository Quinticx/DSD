% this code is for reading nasa data
clear
close all

%% ==============  2015 .  ==========
% hdf5_info = hdf5info('2A.GPM.DPR.V8-20180723.20150420-S074426-E091658.006483.V06A.HDF5');



%% ==============  2017 .  ==========

% hdf5_info = hdf5info(['/Users/yadwang/SIUE/Proposal/NASA/code/GPM/2017/2A.GPM.DPR.V8-20180723.20170531-S075526-E092759.018493.V06A.HDF5']);
% hdf5_info = hdf5info(['/Users/yadwang/SIUE/Proposal/NASA/code/GPM/2017/2A.GPM.DPR.V8-20180723.20170601-S205647-E222919.018517.V06A.HDF5']);
% hdf5_info = hdf5info('2A.GPM.DPR.V8-20180723.20170531-S214829-E232102.018502.V06A.HDF5');
% hdf5_info = hdf5info(['/Users/yadwang/SIUE/Proposal/NASA/code/GPM/2017/2A.GPM.DPR.V8-20180723.20170603-S065255-E082528.018539.V06A.HDF5']);


%% ==============  2018 .  ==========
% hdf5_info = hdf5info(['/Users/yadwang/SIUE/Proposal/NASA/code/GPM/2018/2A.GPM.DPR.V8-20180723.20180507-S042028-E055300.023795.V06A.HDF5']);


%hdf5_info = hdf5info(['/Users/yadwang/SIUE/Proposal/NASA/code/GPM/2018/2A.GPM.DPR.V8-20180723.20180507-S181322-E194554.023804.V06A.HDF5']);
hdf5_info = hdf5info(['/Users/bwither/Documents/Wang/Code/NASA/code/GPM/2018/2A.GPM.DPR.V8-20180723.20180507-S181322-E194554.023804.V06A.HDF5']);



% hdf5_info = hdf5info('2A.GPM.DPR.V8-20180723.20150420-S074426-E091658.006483.V06A.HDF5');
% hdf5_info.GroupHierarchy.Groups(1)  -- HS
% hdf5_info.GroupHierarchy.Groups(2)  -- MS
% hdf5_info.GroupHierarchy.Groups(3)  -- NS


% === time information
DayofMonth = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(1));
DayofYear = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(2));
Hour = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(3));
MilliSecond = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(4));
Minute = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(5));
Month = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(6));
Second = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(7));
SecondOfDay = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(8));
Year = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(8).Datasets(9));



% hdf5_info.GroupHierarchy.Groups(3).Groups.Name

% === Latitude & Longitude
Latitude_Ku = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Datasets(1));
Longitude_Ku = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Datasets(2));


Latitude_Ka_MS = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Datasets(1));
Longitude_Ka_MS = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Datasets(2));

Latitude_Ka_HS = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Datasets(1));
Longitude_Ka_HS = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Datasets(2));


%%%========================================================================
% % ============== .   get all the  data   ================================
%%%========================================================================


% Ku_NS = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(5).Datasets(15));
% Ka_MS = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(5).Datasets(15));
% Ka_HS = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(5).Datasets(15));


Ku_NS_paramDSD = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(4));
% Ka_MS_paramDSD = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(4));
Ka_HS_paramDSD = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(4));


Ku_NS_precipRate = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(8));
% Ka_MS_precipRate = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(8));
Ka_HS_precipRate = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(8));

Ku_NS_precipRateESurface = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(10));
Ka_MS_precipRateESurface = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(7));
Ka_HS_precipRateESurface = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(10));


Ku_NS_precipRateNearSurface = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(11));
Ka_MS_precipRateNearSurface = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(8));
Ka_HS_precipRateNearSurface = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(11));


Ku_NS_zFactorCorrected = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(15));
Ka_MS_zFactorCorrected = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(11));
Ka_HS_zFactorCorrected = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(15));



Ku_NS_zFactorNPCorrected = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(9).Datasets(1));
Ka_MS_zFactorNPCorrected = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(10).Datasets(1));
Ka_HS_zFactorNPCorrected = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(9).Datasets(1));


Ku_NS_zFactorMeasured = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(5).Datasets(15));
Ka_MS_zFactorMeasured = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(5).Datasets(15));
Ka_HS_zFactorMeasured = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(9).Datasets(1));





Ku_NS_zFactorCorrectedESurface = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(16));
Ka_MS_zFactorCorrectedESurface = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(12));
Ka_HS_zFactorCorrectedESurface = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(16));


Ku_NS_zFactorCorrectedNearSurface = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(6).Datasets(17));
Ka_MS_zFactorCorrectedNearSurface = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(6).Datasets(13));
Ka_HS_zFactorCorrectedNearSurface = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(6).Datasets(17));



Ku_NS_flagBB = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(1).Datasets(5));
Ka_MS_flagBB = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(1).Datasets(6));
Ka_HS_flagBB = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(1).Datasets(6));



Ku_NS_BBbottome = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(1).Datasets(1));
Ku_NS_BBpeak = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(1).Datasets(2));
Ku_NS_BBtop = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(1).Datasets(3));
Ku_NS_BBHeight = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(1).Datasets(8));




Ku_typePrecip = hdf5read( hdf5_info.GroupHierarchy.Groups(3).Groups(1).Datasets(11));
Ka_MS_typePrecip = hdf5read( hdf5_info.GroupHierarchy.Groups(2).Groups(1).Datasets(12));
Ka_HS_typePrecip = hdf5read( hdf5_info.GroupHierarchy.Groups(1).Groups(1).Datasets(12));


data_new = nan(49,7933);


%%%========================================================================
%  save all the data
%%%========================================================================

mat.Ku_NS_paramDSD = Ku_NS_paramDSD; 
% mat.Ka_MS_paramDSD = Ka_MS_paramDSD;
mat.Ka_HS_paramDSD = Ka_HS_paramDSD;

mat.Ku_NS_precipRate = Ku_NS_precipRate;
% mat.Ka_MS_precipRate = Ka_MS_precipRate;
mat.Ka_HS_precipRate = Ka_HS_precipRate;

mat.Ku_NS_precipRateESurface = Ku_NS_precipRateESurface;
mat.Ka_MS_precipRateESurface = Ka_MS_precipRateESurface;
mat.Ka_HS_precipRateESurface = Ka_HS_precipRateESurface;

mat.Ku_NS_precipRateNearSurface = Ku_NS_precipRateNearSurface;
mat.Ka_MS_precipRateNearSurface = Ka_MS_precipRateNearSurface;
mat.Ka_HS_precipRateNearSurface = Ka_HS_precipRateNearSurface;

mat.Ku_NS_zFactorCorrected = Ku_NS_zFactorCorrected;
mat.Ka_MS_zFactorCorrected = Ka_MS_zFactorCorrected;
mat.Ka_HS_zFactorCorrected = Ka_HS_zFactorCorrected;

mat.Ku_NS_zFactorNPCorrected = Ku_NS_zFactorNPCorrected;
mat.Ka_MS_zFactorNPCorrected = Ka_MS_zFactorNPCorrected;
mat.Ka_HS_zFactorNPCorrected = Ka_HS_zFactorNPCorrected;



mat.Ku_NS_zFactorCorrectedESurface = Ku_NS_zFactorCorrectedESurface;
mat.Ka_MS_zFactorCorrectedESurface = Ka_MS_zFactorCorrectedESurface;
mat.Ka_HS_zFactorCorrectedESurface = Ka_HS_zFactorCorrectedESurface;

mat.Ku_NS_zFactorCorrectedNearSurface = Ku_NS_zFactorCorrectedNearSurface;
mat.Ka_MS_zFactorCorrectedNearSurface = Ka_MS_zFactorCorrectedNearSurface;
mat.Ka_HS_zFactorCorrectedNearSurface = Ka_HS_zFactorCorrectedNearSurface;


mat.Ku_NS_zFactorMeasured = Ku_NS_zFactorMeasured;
mat.Ka_MS_zFactorMeasured = Ka_MS_zFactorMeasured;
mat.Ka_HS_zFactorMeasured = Ka_HS_zFactorMeasured;


mat.Latitude_Ku = Latitude_Ku;
mat.Longitude_Ku = Longitude_Ku;

mat.Latitude_Ka_MS = Latitude_Ka_MS;
mat.Longitude_Ka_MS = Longitude_Ka_MS;

mat.Latitude_Ka_HS = Latitude_Ka_HS;
mat.Longitude_Ka_HS = Longitude_Ka_HS;


mat.Ku_NS_flagBB = Ku_NS_flagBB;
mat.Ka_MS_flagBB = Ka_MS_flagBB;
mat.Ka_HS_flagBB = Ka_HS_flagBB;

mat.Ku_NS_BBbottome = Ku_NS_BBbottome;
mat.Ku_NS_BBpeak = Ku_NS_BBpeak;
mat.Ku_NS_BBtop = Ku_NS_BBtop;

mat.Ku_typePrecip = Ku_typePrecip;
mat.Ka_MS_typePrecip = Ka_MS_typePrecip;
mat.Ka_HS_typePrecip = Ka_HS_typePrecip;
mat.Ku_NS_BBHeight = Ku_NS_BBHeight;



mat.Year = Year(1);
mat.Month = Month(1);
mat.Day = DayofMonth(1);
mat.Hour = Hour(1);
mat.Minute = Minute(1);
mat.Second = Second(1);

filename = (['mat_' num2str(Year(1)) num2str(Month(1)) num2str(DayofMonth(1)) '-' num2str(Hour(1)) num2str(Minute(1))]);
save(filename,'mat', '-v7.3');  
