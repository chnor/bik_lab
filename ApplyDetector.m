function score = ApplyDetector(Cparams,ii_im,sig,mu)

    if(nargin<4)
        sig = 1;
        mu = 0;
    end
    alpha = Cparams.alphas;
    j = Cparams.Thetas(:, 1);
    theta = Cparams.Thetas(:, 2);
    p = Cparams.Thetas(:, 3);
    
    is_type_3 = Cparams.all_ftypes(j, 1) == 3;
    w = Cparams.all_ftypes(j, 4);
    h = Cparams.all_ftypes(j, 5);

    f = ii_im(:)' * Cparams.fmat(:, j);
    f = (f' + is_type_3.*w.*h.*mu) / sig;
    
    score = sum(alpha .* (p .* f < p .* theta));
end