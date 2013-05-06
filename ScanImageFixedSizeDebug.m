
im = imread('TestImages/one_chris.png');
Cparams.thresh = 6.5;
dets = ScanImageFixedSize(Cparams, im);
DisplayDetections(im, dets)
