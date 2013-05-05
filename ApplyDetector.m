function score = ApplyDetector(Cparams,ii_im)
     score = sum(Cparams.alphas.*(Cparams.Thetas(:,3).*(ii_im(:)' * Cparams.fmat(:,Cparams.Thetas(:,1)))' < Cparams.Thetas(:,3).*Cparams.Thetas(:,2)));
end