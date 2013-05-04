{\rtf1\ansi\ansicpg1252\cocoartf1187\cocoasubrtf370
{\fonttbl\f0\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720

\f0\fs24 \cf0 function score = ApplyDetector(Cparams,ii_im)\
     score = sum(Cparams.alphas.*(Cparams.Thetas(:,3).*(ii_im(:)' * Cparams.fmat(:,Cparams.Thetas(:,1)))' < Cparams.Thetas(:,3).*Cparams.Thetas(:,2)));\
end \
}