
function dets = ScanImageFixedSize(Cparams, im)
    [~, ~, c] = size(im);
    if c == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
%    im = (im - mean(im(:))) / std(im(:));
    
    dets = [];
    L = 19;
    theta = Cparams.thresh;
    use_explicit_normalization = true;
    
    ii_im = cumsum(cumsum(im, 1), 2);
    im_square = cumsum(cumsum(im .* im, 1), 2);
    
    i = 0;
    for x = 1:(size(im, 2) - L + 1)
        for y = 1:(size(im, 1) - L + 1)
            im_cur = im(y:(y+L-1), x:(x+L-1));
            mu = quick_mean(x, y, L, ii_im);
            sigma = quick_std(x, y, L, mu, im_square);
            if use_explicit_normalization
                im_cur = (im_cur - mu) / sigma;
                ii_im_cur = cumsum(cumsum(im_cur, 1), 2);
                response = ApplyDetector(Cparams, ii_im_cur(:));
            else
                ii_im_cur = cumsum(cumsum(im_cur, 1), 2);
                response = ApplyDetector(Cparams, ii_im_cur(:), sigma, mu);
            end
            if response > theta
                i = i + 1;
                dets(i, :) = [x, y, x+L-1, y+L-1, response];
            end
        end
    end

function mu = quick_mean(x, y, L, ii_im)
    mu = ii_im(y+L-1, x+L-1);
    if x > 1
        mu = mu - ii_im(y+L-1, x-1);
    end
    if y > 1
        mu = mu - ii_im(y-1, x+L-1);
    end
    if x > 1 && y > 1
        mu = mu + ii_im(y-1, x-1);
    end
    mu = mu / (L^2);
    
function sigma = quick_std(x, y, L, mu, ii_im)
    sigma = ii_im(y+L-1, x+L-1);
    if x > 1
        sigma = sigma - ii_im(y+L-1, x-1);
    end
    if y > 1
        sigma = sigma - ii_im(y-1, x+L-1);
    end
    if x > 1 && y > 1
        sigma = sigma + ii_im(y-1, x-1);
    end
    sigma = sqrt((sigma - L^2 * mu^2) / (L^2 - 1));
    
