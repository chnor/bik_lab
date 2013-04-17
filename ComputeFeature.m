function fs = ComputeFeature(ii_ims,ftype)

n = length(ii_ims);
fs = zeros(1,n);

type = ftype(1);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

for i=1:n
    if(type ==1)
        fs(i) = FeatureTypeI(ii_ims(:,:,i),x,y,w,h);
    elseif(type == 2)
        fs(i) = FeatureTypeII(ii_ims(:,:,i),x,y,w,h);
    elseif(type == 3)
        fs(i) = FeatureTypeIII(ii_ims(:,:,i),x,y,w,h);
    elseif(type == 4)
        fs(i) = FeatureTypeIV(ii_ims(:,:,i),x,y,w,h);
    end
end
end