function all_ftypes = EnumAllFeatures(W, H)
%Sanity check, make sure nf is around 32 746

%pre allocation (might be to small)
all_ftypes = zeros(150000,5);
nf = 0;

% get all Features of type 1
for w = 1:W-2
    for h = 1:floor(H/2)-2
        for x = 2:W-w
            for y = 2:H-2*h
                nf = nf +1;
                all_ftypes(nf,1) = 1;
                all_ftypes(nf,2) = x;
                all_ftypes(nf,3) = y;
                all_ftypes(nf,4) = w;
                all_ftypes(nf,5) = h;
            end
        end
    end
end
% get all Features of type 2
for w = 1:floor(W/2)-2
    for h = 1:H-2
        for x = 2:W-2*w
            for y = 2:H-h
                nf = nf +1;
                all_ftypes(nf,1) = 2;
                all_ftypes(nf,2) = x;
                all_ftypes(nf,3) = y;
                all_ftypes(nf,4) = w;
                all_ftypes(nf,5) = h;
            end
        end
    end
end

% get all Features of type 3
for w = 1:floor(W/3)-2
    for h = 1:H-2
        for x = 2:W-3*w
            for y = 2:H-h
                nf = nf +1;
                all_ftypes(nf,1) = 3;
                all_ftypes(nf,2) = x;
                all_ftypes(nf,3) = y;
                all_ftypes(nf,4) = w;
                all_ftypes(nf,5) = h;
            end
        end
    end
end

% get all Features of type 4
for w = 1:floor(W/2)-2
    for h = 1:floor(H/2)-2
        for x = 2:W-2*w
            for y = 2:H-2*h
                nf = nf +1;
                all_ftypes(nf,1) = 4;
                all_ftypes(nf,2) = x;
                all_ftypes(nf,3) = y;
                all_ftypes(nf,4) = w;
                all_ftypes(nf,5) = h;
            end
        end
    end
end
all_ftypes = all_ftypes(1:nf,5);
end

