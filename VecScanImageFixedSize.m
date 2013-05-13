
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
    
    % Add padding zeros to avoid having to treat edges
    % as a special case (x == 1 or y == 1) when constructing.
    % This makes the code a bit messier but the speed gains
    % are massive.
    
    ii_im(2:end+1, 2:end+1) = ii_im(1:end, 1:end);
    im_square(2:end+1, 2:end+1) = im_square(1:end, 1:end);
    
    mu = ii_im(ImageScanner.T_gamma(1, :)) ...
       - ii_im(ImageScanner.T_gamma(2, :)) ...
       - ii_im(ImageScanner.T_gamma(3, :)) ...
       + ii_im(ImageScanner.T_gamma(4, :));
    mu = mu ./ (L^2);
    sigma = im_square(ImageScanner.T_gamma(1, :)) ...
          - im_square(ImageScanner.T_gamma(2, :)) ...
          - im_square(ImageScanner.T_gamma(3, :)) ...
          + im_square(ImageScanner.T_gamma(4, :));
    sigma = sqrt((sigma - L^2 .* mu.^2) ./ (L^2 - 1));
    
    responses = VecApplyDetector(Cparams, ii_ims, sigma, mu);
    
    [~, hits] = find(responses > Cparams.thresh);
    i = 0;
    for hit = hits
        i = i + 1;
        x = floor(hit / (H - L + 1));
        y = mod(hit, H - L + 1);
        dets(i, :) = [x, y, x+L-1, y+L-1, responses(hit)];
    end