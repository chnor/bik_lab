
list = dir('TrainingImages/FACES/');
ii_ims = zeros(100,361);
for i = 3:102
    [im , ii_im]= LoadIm(['TrainingImages/FACES/',list(i).name]);
    ii_ims(i-2,:) = ii_im(:);
end

dinfo3 = load('DebugInfo/debuginfo3.mat');
ftype = dinfo3.ftype;
sum(abs(dinfo3.fs - ComputeFeature(ii_ims, ftype)) > eps)
sum(abs(dinfo3.fs - ComputeFeature(ii_ims, ftype)))
