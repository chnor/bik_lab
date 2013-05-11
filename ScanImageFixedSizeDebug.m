
im = imread('TestImages/one_chris.png');
Cparams.thresh = 6.5;
% dets = ScanImageFixedSize(Cparams, im);
[H, W, ~] = size(im);
ImageScanner = ConstructVecScanner(W, H, 19);
dets = VecScanImageFixedSize(Cparams, ImageScanner, im);
DisplayDetections(im, dets)
