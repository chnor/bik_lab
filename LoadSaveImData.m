function LoadSaveImData(dirname, ni, im_sfn)

face_fnames = dir(dirname);
fnums = randi([3,length(face_fnames)], 1, ni);

ii_ims = zeros(100, 19*19);

for i=1:ni
    im_fname = [dirname, '/', face_fnames(fnums(i)).name];
    [im, ii_im] = LoadIm(im_fname);
    ii_ims(i, :) = ii_im(:);
end

size(ii_ims)
save(im_sfn, 'dirname', 'fnums', 'ii_ims');

end


