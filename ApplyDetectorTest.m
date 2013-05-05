
function sc = ApplyDetectorTest(Cparams,ii_im)
    [im, ii_im] = LoadIm('TrainingImages/FACES/face00001.bmp');
    sc= ApplyDetector(Cparams,ii_im);
    assert(abs(sc - 9.1409) < 1e-5);
end