function score = VecApplyDetector(Cparams, ii_im, sigma, mu)

    alpha = Cparams.alphas;
    j = Cparams.Thetas(:, 1);
    theta = Cparams.Thetas(:, 2);
    p = Cparams.Thetas(:, 3);
    
    is_type_3 = Cparams.all_ftypes(j, 1) == 3;
    w = Cparams.all_ftypes(j, 4);
    h = Cparams.all_ftypes(j, 5);
    
    f = ii_im' * Cparams.fmat(:, j);
    f = bsxfun(@rdivide, bsxfun(@plus, f', bsxfun(@times, is_type_3.*w.*h, mu)), sigma);
    
    score = sum(bsxfun(@times, bsxfun(@lt, bsxfun(@times, f, p), p .* theta), alpha));
end