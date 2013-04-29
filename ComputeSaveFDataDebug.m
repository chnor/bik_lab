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

face_fnames = dir(dirname);
addpath(dirname);
ii_ims = zeros(ni, H*W);

for i=1:ni
    name = face_fnames(dinfo4.fnums(i)).name;
    [im, ii_im] = LoadIm(name);
    ii_ims(i, :) = ii_im(:);
end

assert(all(all(ii_ims == dinfo4.ii_ims)));
