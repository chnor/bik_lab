%debug dir('TrainingImages/FACES/')ComputeFeature(ii_ims, ftype)
%read 100 first images and put all integral images in a list. 
list = dir('TrainingImages/FACES/');
ii_ims = [];
size(ii_ims)
for i = 3:102
    [im , ii_im]= LoadIm(['TrainingImages/FACES/',list(i).name]);
    ii_ims = [ii_ims,ii_im];
end

dinfo3 = load('DebugInfo/debuginfo3.mat');
ftype = dinfo3.ftype;
sum(abs(dinfo3.fs - ComputeFeature(ii_ims, ftype)) > eps)