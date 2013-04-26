function fpic = MakeFeaturePic(ftype, W, H)

fpic = zeros(H, W);

type    = ftype(1);
x       = ftype(2);
y       = ftype(3);
w       = ftype(4);
h       = ftype(5);
switch type
case 1
    fpic(y:y+h-1, x:x+w-1) = -1;
    fpic(y+h:y+2*h-1, x:x+w-1) = 1;
case 2
    fpic(y:y-1, x+w:x+2*w-1) = 1;
    fpic(y:y+h-1, x:x+w-1) = -1;
case 3
    fpic(y:y+h-1, x:x+3*w-1) = 1;
    fpic(y:y+h-1, x+w:x+2*w-1) = -1;
case 4
    fpic(y:y+h-1, x+w:x+2*w-1) = -1;
    fpic(y+h:y+2*h-1, x:x+w-1) = -1;
    fpic(y:y+h-1, x:x+w-1) = 1;
    fpic(y+h:y+2*h-1, x+w:x+2*w-1) = 1;
end

end

