
function dets = ScanImageFixedSize(Cparams, im)
    [~, ~, c] = size(im);
    if c == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
    dets = [];
    L = 19;
    theta = 6.5;
    
    ii_im = cumsum(cumsum(im, 1), 2);
    im_square = cumsum(cumsum(im .* im, 1), 2);
    
    i = 0;
    for x = 1:(size(im, 2) - L + 1)
        for y = 1:(size(im, 1) - L + 1)
            im_cur = im(y:(y+L-1), x:(x+L-1));
%             mu = (ii_im(y+L-1, x+L-1) - ii_im(y, x)) / L^2;
            mu = mean(im_cur(:));
%             sigma = sqrt((im_square(y+L-1, x+L-1) - im_square(y, x) - L^2*mu^2) / (L^2 - 1));
            sigma = std(im_cur(:));
            im_cur = (im_cur - mu) / sigma;
            ii_im_cur = cumsum(cumsum(im_cur, 1), 2);
            response = ApplyDetector(Cparams, ii_im_cur(:));
            if response > theta
                i = i + 1;
                dets(i, :) = [x, y, x+L-1, y+L-1, response];
            end
        end
    end
    