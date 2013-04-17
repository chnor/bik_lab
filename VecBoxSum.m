
function b_vec = VecBoxSum(x, y, w, h, W, H)
    
    assert(w >= 0);
    assert(h >= 0);
    
    A = zeros(H, W);
    A(y+h-1, x+w-1) = 1;
    if x > 1
        A(y+h-1, x-1) = -1;
    end
    if y > 1
        A(y-1, x+w-1) = -1;
    end
    if x > 1 && y > 1
        A(y-1, x-1) = 1;
    end
    b_vec = A(:);
    
