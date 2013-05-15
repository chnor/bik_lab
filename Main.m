
already_loaded = false;

face_fnames = dir('TrainingImages/FACES');
non_face_fnames = dir('TrainingImages/NFACES');
np = length(face_fnames) - 2;
nn = length(non_face_fnames) - 2;

if exist('FaceData.mat', 'file') == 2 && ...
        exist('NonFaceData.mat', 'file') == 2 && ...
        exist('FeaturesToUse.mat', 'file') == 2
    Fdata = load('FaceData.mat');
    NFdata = load('NonFaceData.mat');
    FTdata = load('FeaturesToUse.mat');
    disp(['Data found. Loading to workspace...']);
    if length(Fdata.fnums) ~= np || length(NFdata.fnums) ~= nn
        disp('Dataset size mismatch');
        alread_loaded = false;
    else
        alread_loaded = true;
    end
end

if ~already_loaded
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
Cparams = BoostingAlg(Fdata, NFdata, FTdata, 100);
disp('Done')

Task5;