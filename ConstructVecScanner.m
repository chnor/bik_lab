
function ImageScanner = ConstructVecScanner(W, H, L)
    
    ImageScanner = struct( ...
        'W', W, ...
        'H', H, ...
        'T_gamma', sparse(zeros((W - L + 1)*(H - L + 1), W*H)), ...
        'I_gamma', [], ...
        'L', L ...
	);
    
    % XXX Construct summing matrix by brute force
    % TODO vectorize the following similarly to the
    %      construction of I_gamma
    c = 0;
    for x = 1:(W - L + 1)
        for y = 1:(H - L + 1)
            c = c + 1;
            
            ImageScanner.T_gamma(c, (y+L-1) + (x+L-2)*H) = 1;
            if x > 1
                ImageScanner.T_gamma(c, (y+L-1) + (x-2)*H) = -1;
            end
            if y > 1
                ImageScanner.T_gamma(c, (y-1) + (x+L-2)*H) = -1;
            end
            if x > 1 && y > 1
                ImageScanner.T_gamma(c, (y-1) + (x-2)*H) = 1;
            end
        end
    end
    
    % Calculate each index in the subwindow
    w_i =  bsxfun(@plus, H*(0:L-1)',(1:L));
    w_i = w_i';
    w_i = w_i(:);
    % Calculate each starting index
    i_0 = bsxfun(@plus, (0:(H-L))', H*(0:(W-L)));
    i_0 = i_0(:)';
    % Add the subwindow index matrix to
    % each starting index
    ImageScanner.I_gamma = bsxfun(@plus, w_i, i_0);
    