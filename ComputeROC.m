
function ComputeROC(Cparams, Fdata, NFdata)
    
    face_filenames = dir(Fdata.dirname);
    training_face_indices = setdiff(1:length(face_filenames), Fdata.fnums);
    nonface_filenames = dir(NFdata.dirname);
    training_nonface_indices = setdiff(1:length(nonface_filenames), NFdata.fnums);
    
    %detect = @(ii_im) ApplyDetector(Cparams, ii_im);
    detect = @(ii_im) sum(sum(ii_im)) - floor(sum(sum(ii_im)));
    
    fc = arrayfun(detect, Fdata.ii_ims(training_face_indices));
    nfc = arrayfun(detect, NFdata.ii_ims(training_nonface_indices));
    
    theta = 0:0.01:1;
    ROC = zeros(length(theta), 2);
    for i = 1:length(theta)
        [tpr, fpr] = ApplyThreshold(fc, nfc, theta(i));
        ROC(i, 1) = tpr;
        ROC(i, 2) = fpr;
    end
    
    plot(ROC(:, 1), ROC(:, 2));
    

function [tpr, fpr] = ApplyThreshold(fc, nfc, theta)
    
    n_tp = sum(fc < theta);
    n_fn = sum(fc >= theta);
    n_fp = sum(nfc < theta);
    n_tn = sum(nfc >= theta);
    
    tpr = n_tp / (n_tp + n_fn);
    fpr = n_fp / (n_tn + n_fp);
