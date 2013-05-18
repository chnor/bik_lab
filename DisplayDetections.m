
function DisplayDetections(im, dets, real_dets)
    imagesc(im);
    axis image;
    hold on;
    for det = dets'
        x = det(1);
        y = det(2);
        w = det(3) - x;
        h = det(4) - y;
        plot(x + [0 w w 0 0], ...
             y + [0 0 h h 0], 'r');
    end
    for det = real_dets'
        x = det(1);
        y = det(2);
        w = det(3) - x;
        h = det(4) - y;
        plot(x + [0 w w 0 0], ...
             y + [0 0 h h 0], 'g');
    end
    hold off;
    
