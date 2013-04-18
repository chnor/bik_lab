
% Page 18 histograms

function PlotFeatureHistograms(Fdata, NFdata, FTdata, ...
                 feature_num, num_face_samples, num_nonface_samples)
    if nargin < 5
        num_face_samples  = min(size(Fdata.ii_ims, 2), size(NFdata.ii_ims, 2));
        num_nonface_samples  = num_face_samples;
    end

    fs_1 = Fdata.ii_ims(1:num_face_samples, :) * FTdata.fmat(:, feature_num);
    fs_2 = NFdata.ii_ims(1:num_nonface_samples, :) * FTdata.fmat(:, feature_num);

    h1 = hist(fs_1)
    h2 = hist(fs_2);

    x1 = min(fs_1) + (1:length(h1)) * (max(fs_1) - min(fs_1));
    x2 = min(fs_2) + (1:length(h2)) * (max(fs_2) - min(fs_2));

    plot(x1, h1, 'r-', x1, h1, 'ro', x2, h2, 'b-', x2, h2, 'bo');
