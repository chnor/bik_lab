
% Page 18 histograms

function PlotFeatureHistograms(Fdata, NFdata, FTdata, ...
                 feature_num, num_face_samples, num_nonface_samples)
    if nargin < 5
        num_face_samples  = size(Fdata.ii_ims, 1);
        num_nonface_samples  = size(Fdata.ii_ims, 1);
    end

    fs_1 = Fdata.ii_ims(1:num_face_samples, :) * FTdata.fmat(:, feature_num);
    fs_2 = NFdata.ii_ims(1:num_nonface_samples, :) * FTdata.fmat(:, feature_num);

    clf;
    [h1 a1]= hist(fs_1);
    [h2 a2]= hist(fs_2);
    plot(a1,h1/sum(h1));
    hold on;
    plot(a2,h2/sum(h2),'r');
    
% 	
%     x1 = min(fs_1) + (1:length(h1)) * (max(fs_1) - min(fs_1)) / length(h1);
%     x2 = min(fs_2) + (1:length(h2)) * (max(fs_2) - min(fs_2)) / length(h2);
% 
%     plot(x1, h1, 'r-', x1, h1, 'ro', x2, h2, 'b-', x2, h2, 'bo');
