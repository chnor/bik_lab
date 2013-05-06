function score = ApplyDetector2(Cparams,ii_im,sig,mu)

    if(nargin<4)
        score = sum(Cparams.alphas.*(Cparams.Thetas(:,3).*(ii_im(:)' * Cparams.fmat(:,Cparams.Thetas(:,1)))' < Cparams.Thetas(:,3).*Cparams.Thetas(:,2)));
    else
        score = sum(Cparams.alphas.*(Cparams.Thetas(:,3).*(ii_im(:)'*Cparams.fmat(:,Cparams.Thetas(:,1)))'<Cparams.Thetas(:,3).*Cparams.Thetas(:,2)))/sig - (mu*Cparams.all_ftypes(Cparams.Thetas(:,1),4).*Cparams.all_ftypes(Cparams.Thetas(:,1),5)/sig);
    end
end