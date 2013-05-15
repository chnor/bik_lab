
directory = 'TestImages';

test_images = dir(directory);
test_images = test_images(3:length(test_images));

for i=1:length(test_images)
    im_name = test_images(i).name
    im = imread([directory, '/', im_name]);
    [h, w, ~] = size(im);
    dets = ScanImageOverScale(Cparams, im, 19/min(w, h), 1, .05);

    set(gca, 'Position', [0 0 1 1]);
    %dets = PruneDetections(dets)
    DisplayDetections(im, dets);
    print('-dpng','-r100', '-noui', ['Results/',im_name]);
end



