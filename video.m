%im capture

while 1
    tic;
    data = getsnapshot(vid);
    toc;
    
    [h, w, ~] = size(data);
    data = imresize(data, 200/min(w, h));
    data = data(:, end:-1:1, :);
    
    [h, w, ~] = size(data);
    min_s = 20/min(w, h);
    max_s = 0.6;
    step_s = (max_s-min_s)/4;
    tic;

    dets = ScanImageOverScale(Cparams, data, min_s, max_s, step_s);
    %dets = PruneDetections(dets);

    toc;
    figure(2)
    DisplayDetections2(data, dets)
end