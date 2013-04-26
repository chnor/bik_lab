
function cpic = MakeClassifierPic(all_ftypes, chosen_f, alphas, ps, W, H)
    
    cpic = zeros(H, W);
    for i = 1:length(chosen_f)
        feature = all_ftypes(chosen_f(i), :);
        alpha = alphas(i);
        p = ps(i);
        cpic = cpic + p * alpha * MakeFeaturePic(feature, W, H);
    end
