
dinfo6 = load('DebugInfo/debuginfo6.mat');
T = dinfo6.T;
Cparams = BoostingAlg(Fdata, NFdata, FTdata, T);
sum(abs(dinfo6.alphas - Cparams.alphas) > eps)
sum(abs(dinfo6.Thetas(:) - Cparams.Thetas(:)) > eps)