function ComputeSaveFData(all_ftypes, f_sfn)

W = 19;
H = 19;

global fmat; % In order to access it from the debug checkpoint
fmat = VecAllFeatures(all_ftypes, W, H);

save(f_sfn, 'fmat', 'all_ftypes', 'W', 'H');

end