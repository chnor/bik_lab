clear all

dirname = 'TrainingImages/FACES';

dinfo4 = load('DebugInfo/debuginfo4.mat');
ni = dinfo4.ni;
all_ftypes = dinfo4.all_ftypes;
im_sfn = 'FaceData.mat';
f_sfn = 'FeaturesToMat.mat';
rng(dinfo4.jseed);
LoadSaveImData(dirname, ni, im_sfn);
ComputeSaveFData(all_ftypes, f_sfn);

W = 19;
H = 19;
fmat = VecAllFeatures(all_ftypes, W, H);

assert(all(all(fmat == dinfo4.fmat)));
