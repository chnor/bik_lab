dinfo4 = load('DebugInfo/debuginfo4.mat');
ni = dinfo4.ni;
all_ftypes = dinfo4.allftypes;
im_sfn = 'FaceData.mat';
fs_fn = 'FeaturesToMat.mat';
rng(dinfo4.jseed);
LoadSaveImData(dirname, ni, im_sfn);
ComputeSaveFData(all_ftypes, fs_fn);