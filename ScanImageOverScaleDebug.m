
im = imread('TestImages/big_one_chris.png');
dets = ScanImageOverScale(Cparams, im, .6, 1.3, .06);
DisplayDetections(im, dets)