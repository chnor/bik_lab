
function ftype_vec = VecFeature(ftype, W, H)
    
    type    = ftype(1);
    x       = ftype(2);
    y       = ftype(3);
    w       = ftype(4);
    h       = ftype(5);
    switch type
    case 1
        ftype_vec = VecBoxSum(x, y, w, h, W, H) - VecBoxSum(x, y+h, w, h, W, H);
    case 2
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) - VecBoxSum(x, y, w, h, W, H);
    case 3
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) - VecBoxSum(x, y, w, h, W, H) - VecBoxSum(x+2*w, y, w, h, W, H);
    case 4
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) + VecBoxSum(x, y+h, w, h, W, H) - VecBoxSum(x, y, w, h, W, H) - VecBoxSum(x+w, y+h, w, h, W, H);
    end
    
