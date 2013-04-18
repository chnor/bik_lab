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

%%

face_fnames = dir(dirname);

files = cell(1, length(face_fnames));
for i=1:length(face_fnames)
    name = face_fnames(i).name;
    files(1, i) = {name};
end

for i=1:5%length(face_fnames)
    files(1, i)
end
%%

fnums = randi([3,length(files)], 1, ni);

ii_ims = zeros(100, 19*19);

for i=1:ni
    name = files(1, fnums(i))
    im_fname = strcat(dirname, '/', name)
    [im, ii_im] = LoadIm(im_fname);
    ii_ims(i, :) = ii_im(:);
end

sum(sum(ii_ims == dinfo4.ii_ims))