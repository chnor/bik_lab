
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
    
    % Add padding zeros to avoid having to treat edges
    % as a special case (x == 1 or y == 1) when constructing.
    % This makes the code a bit messier but the speed gains
    % are massive.
    
    ii_im2 = zeros(size(ii_im) + [1, 1]);
    im_square2 = zeros(size(im_square) + [1, 1]);
    ii_im2(2:end, 2:end) = ii_im(1:end, 1:end);
    im_square2(2:end, 2:end) = im_square(1:end, 1:end);
    
    mu = ii_im2(ImageScanner.T_gamma(1, :)) ...
       - ii_im2(ImageScanner.T_gamma(2, :)) ...
       - ii_im2(ImageScanner.T_gamma(3, :)) ...
       + ii_im2(ImageScanner.T_gamma(4, :));
    mu = mu ./ (L^2);
    sigma = im_square2(ImageScanner.T_gamma(1, :)) ...
          - im_square2(ImageScanner.T_gamma(2, :)) ...
          - im_square2(ImageScanner.T_gamma(3, :)) ...
          + im_square2(ImageScanner.T_gamma(4, :));
    sigma = sqrt((sigma - L^2 .* mu.^2) ./ (L^2 - 1));
    
    n = length(mu);
    xs = floor((1:n) / (H - L + 1));
    ys = mod(1:n, H - L + 1);
    
    % Cascade step 1
    % Only consider subwindows where mu and sigma lie
    % within sigma_window and mu_window and where mu
    % is greater than mu_min
    % If set judiciously, these values will both speed
    % up the scanning immensely and cull a large number
    % of false negatives. If set too aggressively it will
    % also cull true positives.
    
    sigma_window = [0.25, 0.8];
    mu_window = [0.1, 0.95];
    mu_min = 60; % Cull subwindow close to black
    mu_max = 200; % Cull subwindow close to white
    
    sigma_sorted = sort(sigma);
    sigma_threshold1 = sigma_sorted(floor(sigma_window(1)*n+1));
    sigma_threshold2 = sigma_sorted(floor(sigma_window(2)*n));
    mu_sorted = sort(mu);
    mu_threshold1 = max(mu_sorted(floor(mu_window(1)*n)+1), mu_min);
    mu_threshold2 = min(mu_sorted(floor(mu_window(2)*n)), mu_max);
    
    [~, sigma_culled1] = find(sigma > sigma_threshold1);
    [~, sigma_culled2] = find(sigma < sigma_threshold2);
%     disp(['Sigma culling 1: ', num2str(100 - 100*length(sigma_culled1)/n), '%']);
%     disp(['Sigma culling 2: ', num2str(100 - 100*length(sigma_culled2)/n), '%']);
    [~, mu_culled1] = find(mu > mu_threshold1);
    [~, mu_culled2] = find(mu < mu_threshold2);
%     disp(['Mu culling 1: ', num2str(100 - 100*length(mu_culled1)/n), '%']);
%     disp(['Mu culling 2: ', num2str(100 - 100*length(mu_culled2)/n), '%']);
    
    interesting = intersect(sigma_culled1, sigma_culled2);
    interesting = intersect(interesting, mu_culled1);
    interesting = intersect(interesting, mu_culled2);
%     disp(['Overlap: ', num2str(100*length(intersect(mu_culled, sigma_culled))/n), '%']);
    disp(['Considered: ', num2str(100*length(interesting)/n), '%']);
    
    mu = mu(interesting);
    sigma = sigma(interesting);
    xs = xs(interesting);
    ys = ys(interesting);
    
    % Cascade step 2
    % Viola-Jones
    
    ii_ims = ii_im(ImageScanner.I_gamma(:, interesting));
    
    responses = VecApplyDetector(Cparams, ii_ims, sigma, mu);
    
    [~, hits] = find(responses > Cparams.thresh);
    i = 0;
    for hit = hits
        i = i + 1;
        x = xs(hit);
        y = ys(hit);
        dets(i, :) = [x, y, x+L-1, y+L-1, responses(hit)];
    end
    