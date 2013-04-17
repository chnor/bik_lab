
function fmat = VecAllFeatures(all_ftypes, W, H)
    
    [nf, d] = size(all_ftypes);
    assert(d == 5);
    fmat = zeros(W*H, nf);
    for i = 1:nf
        ftype = all_ftypes(i, :);
        assert(length(ftype) == 5);
        fmat(:, i) = VecFeature(ftype, W, H);
    end
    
    
