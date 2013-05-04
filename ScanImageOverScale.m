
function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
    [~, ~, c] = size(im);
    if c == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
    s = max_s;
    dets = [];
    while s >= min_s
        im_cur = imresize(im, s);
        new_dets = ScanImageFixedSize(Cparams, im_cur);
        dets = [dets; new_dets/s];
        s = s - step_s;
    end
    