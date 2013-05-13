% Construct an ImageScanner object to scan on subwindows
% of size L*L over an image of size W*H.

function ImageScanner = ConstructVecScanner(W, H, L)
    
    assert(W >= L);
    assert(H >= L);

    N = (W - L + 1)*(H - L + 1);
    
    ImageScanner = struct( ...
        'W', W, ...
        'H', H, ...
        'T_gamma', zeros(4, N), ...
        'I_gamma', [], ...
        'L', L ...
	);
    
    % ~~~~~~ Calculate T_gamma ~~~~~~
    
    C = (1:N)';
    x = 2:(W - L + 2);
    y = 2:(H - L + 2);
    
    % Calculate indices for the lower right corner
    T_11 = bsxfun(@plus, (x'+L-2)*(H+1), y+L-1);
    T_11 = T_11';
    ImageScanner.T_gamma(4, :) = T_11(:);
    
    % Calculate indices for the lower left corner
    T_01 = bsxfun(@plus, (x'-2)*(H+1), y+L-1);
    T_01 = T_01';
    ImageScanner.T_gamma(2, :) = T_01(:);
    
    % Calculate indices for the upper right corner
    T_10 = bsxfun(@plus, (x'+L-2)*(H+1), y-1);
    T_10 = T_10';
    ImageScanner.T_gamma(3, :) = T_10(:);
    
    % Calculate indices for the upper left corner
    T_00 = bsxfun(@plus, (x'-2)*(H+1), y-1);
    T_00 = T_00';
    ImageScanner.T_gamma(1, :) = T_00(:);
    
    % ~~~~~~ Calculate I_gamma ~~~~~~
    
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