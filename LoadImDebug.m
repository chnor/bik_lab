[im, ii_im] = LoadIm('TestImages/big_one_chris.png');
ii_im(105, 106) == sum(sum(im(1:105, 1:106)))

%%

[im, ii_im] = LoadIm('TrainingImages/FACES/face00001.bmp');

dinfo1 = load('DebugInfo/debuginfo1.mat');
eps = 1e-6;
s1 = sum(abs(dinfo1.im(:) - im(:)) > eps)
s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps)

%%

close all
imshow(im)
figure()
imshow(ii_im)