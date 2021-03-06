function fs = ComputeFeature(ii_ims,ftype)
n = size(ii_ims,1);
fs = zeros(1,n);

type = ftype(1);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

for i=1:n
    if(type ==1)
        fs(i) = FeatureTypeI(reshape(ii_ims(i,:),19,19),x,y,w,h);
    elseif(type == 2)
        fs(i) = FeatureTypeII(reshape(ii_ims(i,:),19,19),x,y,w,h);
    elseif(type == 3)
        fs(i) = FeatureTypeIII(reshape(ii_ims(i,:),19,19),x,y,w,h);
    elseif(type == 4)
        fs(i) = FeatureTypeIV(reshape(ii_ims(i,:),19,19),x,y,w,h);
    end
end
end

