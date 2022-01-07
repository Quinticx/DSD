% Call General TMatrix Function
tm = TMatrix('Ka_band_1_B_1.dat');

% Load old TMatrix Function
load("fafborig.mat")

% Compare that the two are equal
assert(isequal(tm.fa, fa_Ka), "General TMatrix Incorrect");
assert(isequal(tm.fb, fb_Ka), "General TMatrix Incorrect");
