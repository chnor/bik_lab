
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























%debug dir('TrainingImages/FACES/')ComputeFeature(ii_ims, ftype)
%read 100 first images and put all integral images in a list. 

% list = dir('TrainingImages/FACES/');
% ii_ims = zeros(100,361);
% for i = 3:102
%     [im , ii_im]= LoadIm(['TrainingImages/FACES/',list(i).name]);
%     ii_ims(i-2,:) = ii_im(:);
% end

% Fdata = load('FaceData.mat');
% ii_ims = Fdata.ii_ims;
% ii_ims = ii_ims(1:100,:);

%old working copy
%list = dir('TrainingImages/FACES/');
%ii_ims = zeros(19,19,100);
%for i = 3:102
%    [im , ii_im]= LoadIm(['TrainingImages/FACES/',list(i).name]);
%    ii_ims(:,:,i-2) = ii_im;
%end