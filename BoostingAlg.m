
function Cparams = BoostingAlg(Fdata, NFdata, FTdata, T)
    
	Cparams = struct('alphas', [], ...
                     'Thetas', [], ...
                     'fmat', FTdata.fmat, ...
                     'all_ftypes', FTdata.all_ftypes);
	samples = [Fdata.ii_ims; NFdata.ii_ims];
    
    %fs = samples * FTdata.fmat(:, 1:1000);
    %fs = samples * FTdata.fmat(:, 12028);
    fs = samples * FTdata.fmat;
	ys = [ones(1, length(Fdata.ii_ims)), zeros(1, length(NFdata.ii_ims))]';
	m = sum(ys == 0);
	n = length(ys);
    
    ws = zeros(1, n);
 	ws(ys == 0) = 1/(2*m);
 	ws(ys == 1) = 1/(2*(n-m));
    ws = ws / sum(ws);
	
    for t = 1:T
        disp(['Starting iteration: ', num2str(t)]);
        [theta_t, p_t, err_t] = LearnWeakClassifier(ws, fs, ys);
        beta_t = err_t / (1 - err_t);
		f_t = fs(:, theta_t(1));
		if t ~= T
			w_next = ws.*beta_t.^(1 - abs((p_t*f_t < p_t*theta_t(2)) - ys))';
			w_next = w_next / sum(w_next);
			ws = w_next;
        end
        Cparams.alphas(t, 1) = log(1 / beta_t);
        Cparams.Thetas(t, 1:2) = theta_t;
        Cparams.Thetas(t, 3) = p_t;
    end
end
