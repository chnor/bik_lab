% TO GET YOUR FORMATS
% a = imaqhwinfo('winvideo')
%
% a.DeviceInfo.SupportedFormats
%
%
% try picking the lowest for efficency :)

Cparams = load('Classifier.mat')
vid = videoinput('macvideo', 1);
set(vid, 'ReturnedColorSpace', 'RGB');
