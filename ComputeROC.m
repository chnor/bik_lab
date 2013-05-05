
function ComputeROC(Cparams, Fdata, NFdata)
    
    face_filenames = dir(Fdata.dirname);
    training_face_indices = setdiff(1:min(length(face_filenames), size(Fdata.ii_ims, 1)), Fdata.fnums);
    nonface_filenames = dir(NFdata.dirname);
    training_nonface_indices = setdiff(1:min(length(nonface_filenames), size(NFdata.ii_ims, 1)), NFdata.fnums);
    
    training_faces = Fdata.ii_ims(training_face_indices, :);
    fc = zeros(size(training_face_indices));
    for i = 1:length(fc)
        fc(i) = ApplyDetector(Cparams, training_faces(i, :));
    end
    training_nonfaces = NFdata.ii_ims(training_nonface_indices, :);
    nfc = zeros(size(training_nonface_indices));
    for i = 1:length(nfc)
        nfc(i) = ApplyDetector(Cparams, training_nonfaces(i, :));
    end
    
    theta = 3:0.01:8;
    ROC = zeros(length(theta), 3);
    for i = 1:length(theta)
        [tpr, fpr] = ApplyThreshold(fc, nfc, theta(i));
        ROC(i, 1) = tpr;
        ROC(i, 2) = fpr;
        ROC(i, 3) = theta(i);
    end
    
    plot(ROC(:, 2), ROC(:, 1));
    
function [tpr, fpr] = ApplyThreshold(fc, nfc, theta)
    
    n_tp = sum(fc > theta);
    n_fn = sum(fc <= theta);
    n_fp = sum(nfc > theta);
    n_tn = sum(nfc <= theta);
    
    tpr = n_tp / (n_tp + n_fn);
    fpr = n_fp / (n_tn + n_fp);
