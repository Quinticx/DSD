% Call General TMatrix Function
TMF = TMatrix('Ku_band_2_F_0.dat');
TMB = TMatrix('Ku_band_2_B_0.dat');

% Call new paramEstimation Function
Nw = 315.4786;
Dm = 0.6501;
mu = 0;

% Call Calculate KW
Kw = calculateKw(0, 2);

% Call CalculateZhAh to find Reflectivity and Attenuation
[Zh, A_h] = calculateZhAh(2, Nw, mu, Dm, TMF, TMB, Kw);

assert(abs(Zh-0.7354) < 0.001, "Zh Calculation is incorrect")
assert(abs(A_h - 0.0020) < 0.0001, "A_h Calculation is incorrect")