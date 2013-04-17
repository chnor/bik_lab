clear all

global fmat

dirname = 'TrainingImages/FACES';

dinfo4 = load('DebugInfo/debuginfo4.mat');
ni = dinfo4.ni;
all_ftypes = dinfo4.all_ftypes;
im_sfn = 'FaceData.mat';
f_sfn = 'FeaturesToMat.mat';
rng(dinfo4.jseed);
LoadSaveImData(dirname, ni, im_sfn);
ComputeSaveFData(all_ftypes, f_sfn);

sum(sum(dinfo4.fmat == fmat)) == size(fmat, 1)*size(fmat, 2)