
function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
    [~, ~, c] = size(im);
    if c == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
    ss = min_s:step_s:max_s;
    dets = [];
    parfor i = 1:length(ss)
        s = ss(i);
        im_cur = imresize(im, s);
%         new_dets = ScanImageFixedSize(Cparams, im_cur);
        [H, W, ~] = size(im_cur);
        ImageScanner = ConstructVecScanner(W, H, 19);
        new_dets = VecScanImageFixedSize(Cparams, ImageScanner, im_cur);
        dets = [dets; new_dets/s];
    end
    