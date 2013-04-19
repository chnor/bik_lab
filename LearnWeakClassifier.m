
function [theta, p, err] = LearnWeakClassifier(ws, fs, ys)
    
    [n, d] = size(fs);
    
	W = zeros(1, n);
    W(1, :) = ws;
	W = W / sum(sum(ws));
	
	T = 3;
	
	theta = zeros(2, T);
	err = inf*ones(1, T);
	
    epsilon =@(f, p, w, y) @(x) sum(w * abs((p*f < p*x) - y));
    
	positive = ys == 1;
	negative = ys == 0;
	
    for t = 1:T
        for j = 1:d
			
			% disp(['Iteration: ', num2str(j)]);
			
            f = fs(:, j);
            f_pos = f(positive);
            f_neg = f(negative);
			
            mu_f_pos = mean(f_pos);
            mu_f_neg = mean(f_neg);
			
			step_length = abs(mu_f_pos - mu_f_neg) / 200;
            if mu_f_pos > mu_f_neg
				theta_potential = mu_f_neg:step_length:mu_f_pos;
            else
				theta_potential = mu_f_pos:step_length:mu_f_neg;
            end
			
            epsilon_1 = epsilon(f, 1, W(t, :), ys);
			epsilon_pontential_1 = zeros(size(epsilon_1));
			epsilon_2 = epsilon(f, -1, W(t, :), ys);
			epsilon_pontential_2 = zeros(size(epsilon_2));
			for i = 1:length(theta_potential)
				epsilon_potential_1(i) = epsilon_1(theta_potential(i));
				epsilon_potential_2(i) = epsilon_2(theta_potential(i));
			end
			
            [min_epsilon, i] = min(epsilon_potential_1);
			if min_epsilon > min(epsilon_potential_2)
				[min_epsilon, i] = min(epsilon_potential_2);
				parity = -1;
			else
				parity = 1;
			end
			if (min_epsilon < err(t))
				err(t) = min_epsilon;
				theta(:, t) = [j, theta_potential(i)];
				p(t) = parity;
				
				% disp(['Best so far: ', num2str(min_epsilon)]);
			end
        end
		if t ~= T
			beta_t = err(t) / (1 - err(t));
			f_t = fs(:, theta(1, t));
			theta_t = theta(2, t);
			w_next = W(t, :).*beta_t.^(1 - abs((p(t)*f_t < p(t)*theta_t) - ys))';
			w_next = w_next / sum(w_next);
			W(t+1, :) = w_next;
		end
    end
    
