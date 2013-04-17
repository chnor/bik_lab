%%

dinfo5 = load('DebugInfo/debuginfo5.mat');
np = dinfo5.np;
nn = dinfo5.nn;
all_ftypes = dinfo5.all_ftypes;
rng(dinfo5.jseed);
GetTrainingData(all_ftypes, np, nn);

%%

Fdata = load('FaceData.mat');
NFdata = load('NonFaceData.mat');
FTdata = load('FeaturesToUse.mat');
