
function new_dets = PruneDetections(dets)
    
    D = sparse(rectint(dets, dets));
    [S, C] = graphconncomp(D);
    
    for i = 1:S
        x_0 = mean(dets(C == i, 1));
        y_0 = mean(dets(C == i, 2));
        x_1 = mean(dets(C == i, 1) + dets(C == i, 3));
        y_1 = mean(dets(C == i, 2) + dets(C == i, 4));
        new_dets(i, :) = [x_0, y_0, x_1 - x_0, y_1 - y_0];
    end