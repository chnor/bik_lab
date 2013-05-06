

T = 100;

GetTrainingDataDebug;

'after training'

Cparams = BoostingAlg(Fdata, NFdata, FTdata, T);

'after boosting'


%%
close all

directory = 'TestImages';

test_images = dir(directory);
test_images = test_images(3:length(test_images));

for i=1:length(test_images)
    im_name = test_images(i).name
    im = imread([directory, '/', im_name]);
    dets = ScanImageOverScale(Cparams, im, .2, 0.8, .06);

    set(gca, 'Position', [0 0 1 1]);
    %dets = PruneDetections(dets)
    DisplayDetections(im, dets);
    print('-dpng','-r100', '-noui', ['Results/',im_name]);
end



