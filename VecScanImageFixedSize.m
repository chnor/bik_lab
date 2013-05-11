
function dets = VecScanImageFixedSize(Cparams, ImageScanner, im)
    
    [H, ~, c] = size(im);
    if c == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
    dets = [];
    L = 19;
    
    ii_im = cumsum(cumsum(im, 1), 2);
    im_square = cumsum(cumsum(im .* im, 1), 2);
    
    ii_ims = ii_im(ImageScanner.I_gamma);
    
    mu = ImageScanner.T_gamma * ii_im(:);
    mu = mu ./ (L^2);
    sigma = ImageScanner.T_gamma * im_square(:);
    sigma = sqrt((sigma - L^2 .* mu.^2) ./ (L^2 - 1));
    
    responses = VecApplyDetector(Cparams, ii_ims, sigma', mu');
    
    [~, hits] = find(responses > Cparams.thresh);
    i = 0;
    for hit = hits
        i = i + 1;
        x = floor(hit / (H - L + 1));
        y = mod(hit, H - L + 1);
        dets(i, :) = [x, y, x+L-1, y+L-1, responses(hit)];
    end