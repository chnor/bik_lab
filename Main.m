
already_loaded = false;

face_fnames = dir('TrainingImages/FACES');
non_face_fnames = dir('TrainingImages/NFACES');
np = length(face_fnames) - 2;
nn = length(non_face_fnames) - 2;
T = 100;

if exist('FaceData.mat', 'file') == 2 && ...
        exist('NonFaceData.mat', 'file') == 2 && ...
        exist('FeaturesToUse.mat', 'file') == 2
    disp(['Data found. Loading to workspace...']);
    Fdata = load('FaceData.mat');
    NFdata = load('NonFaceData.mat');
    FTdata = load('FeaturesToUse.mat');
end

if exist('Fdata') == 1 && exist('NFdata') == 1 && exist('FTdata') == 1
    if length(Fdata.fnums) ~= np || length(NFdata.fnums) ~= nn
        disp('Dataset size mismatch');
        already_loaded = false;
    else
        disp(['Data appears to be up to date']);
        already_loaded = true;
    end
end

if already_loaded == false
    disp(['Reconstructing data:']);
    
    disp(['Enumerating all 19x19 features']);
    all_ftypes = EnumAllFeatures(19, 19);
    disp(['Loading ', num2str(np), ' faces and ', num2str(nn), ' non faces...']);
    GetTrainingData(all_ftypes, np, nn);
    disp('Done')
    disp('Loading to workspace...')

    Fdata = load('FaceData.mat');
    NFdata = load('NonFaceData.mat');
    FTdata = load('FeaturesToUse.mat');
end

disp('Boosting...');
Cparams = BoostingAlg(Fdata, NFdata, FTdata, T);
disp('Done')

directory = 'Testing/Images';

test_images = dir(directory);
test_images = test_images(3:length(test_images));

for i=1:length(test_images)
    im_name = test_images(i).name;
    im = imread([directory, '/', im_name]);
    [h, w, ~] = size(im);
    dets = ScanImageOverScale(Cparams, im, 19/min(w, h), 0.6, .05);
    set(gca, 'Position', [0 0 1 1]);
    %dets = PruneDetections(dets)
    DisplayDetections(im, dets);
    drawnow;
%     print('-dpng','-r100', '-noui', ['Results/',im_name]);
end
