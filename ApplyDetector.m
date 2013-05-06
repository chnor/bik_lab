function score = ApplyDetector2(Cparams,ii_im,sig,mu)

    if(nargin<4)
        score = sum(Cparams.alphas.*(Cparams.Thetas(:,3).*(ii_im(:)' * Cparams.fmat(:,Cparams.Thetas(:,1)))' < Cparams.Thetas(:,3).*Cparams.Thetas(:,2)));
    else
        index = find(Cparams.all_ftypes(:,1)==3);
        del = (mu*Cparams.all_ftypes(index,4).*Cparams.all_ftypes(index,5)/sig);
        score = sum(Cparams.alphas.*(Cparams.Thetas(:,3).*(ii_im(:)'*Cparams.fmat(:,Cparams.Thetas(:,1)))'<Cparams.Thetas(:,3).*Cparams.Thetas(:,2)))/sig;
    end
end