
function dets = ScanImageFixedSize(Cparams, im)
    [~, ~, c] = size(im);
    if c == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
    dets = [];
    L = 19;
    
    ii_im = cumsum(cumsum(im, 1), 2);
    im_square = cumsum(cumsum(im .* im, 1), 2);
    
    i = 0;
    for x = 1:(size(im, 2) - L + 1)
        for y = 1:(size(im, 1) - L + 1)
            count = count + 1;
            mu = quick_mean(x, y, L, ii_im);
            sigma = quick_std(x, y, L, mu, im_square);
            ii_im_cur = ii_im(y:(y+L-1), x:(x+L-1));
            % Optimization left for when needed: inline ApplyDetector
            response = ApplyDetector(Cparams, ii_im_cur(:), sigma, mu);
            if response > Cparams.thresh
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
    
