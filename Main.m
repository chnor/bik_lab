
already_loaded = false;

face_fnames = dir('TrainingImages/FACES');
non_face_fnames = dir('TrainingImages/NFACES');
%np = length(face_fnames) - 2;
%nn = length(non_face_fnames) - 2;
np = 4000;
nn = 6000;
T = 40;

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
%Cparams = BoostingAlg(Fdata, NFdata, FTdata, T);
disp('Done')

fid = fopen('Testing/faces_bbs.txt');

tline = fgets(fid);
while ischar(tline)
    disp(tline)
    tline = tline(1:end-1);
    im = imread([directory, '/', tline]);
    tline = fgets(fid);
    disp(tline)
    real_dets = sscanf(tline, '%f');
    real_dets = [real_dets(1) real_dets(2) real_dets(1)+real_dets(3) real_dets(2)+real_dets(4)];
    d1 = min(real_dets(1), real_dets(3));
    d2 = min(real_dets(2), real_dets(4));
    d3 = max(real_dets(1), real_dets(3));
    d4 = max(real_dets(2), real_dets(4));
    real_dets = [d1 d2 d3 d4];
    %[h, w, ~] = size(im);
    %im = imresize(im, 250/min(w, h));
    [h, w, ~] = size(im);
    min_s = 19/min(w, h);
    max_s = 0.6;
    step_s = (max_s-min_s)/4;
    dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s);
    [~, i] = find((dets(:, 3) < real_dets(1)) & ...
                  (dets(:, 4) < real_dets(2)) & ...
                  (dets(:, 1) > real_dets(3)) & ...
                  (dets(:, 2) > real_dets(4)));
    i
    
    %DisplayDetections(im, dets, real_dets);
    %drawnow;
    %pause(1);
    for det = dets'
        sub_im = im(det(2):det(4), det(1):det(3), :);
        imagesc(sub_im);
        axis image;
        drawnow;
        pause(1);
    end
    
    tline = fgets(fid);
end

