function [im, ii_im] = LoadIm(im_fname)

im = double(imread(im_fname));

% Convert to grayscale if the image is in rgb
if length(size(im)) == 3
    im = rgb2gray(im);
end

stdeviation = std(im(:));
if stdeviation == 0
    stdeviation = 1e-15;
end

im = (im - mean(im(:))) / stdeviation;

ii_im = cumsum(cumsum(im, 1), 2);

end