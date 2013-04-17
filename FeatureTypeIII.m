function f = FeatureTypeIII(ii_im, x, y, w, h)

f = 2*ComputeBoxSum(ii_im,x+w,y,w,h) - ComputeBoxSum(ii_im,x,y,w*3,h)

end

