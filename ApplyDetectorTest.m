{\rtf1\ansi\ansicpg1252\cocoartf1187\cocoasubrtf370
{\fonttbl\f0\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720

\f0\fs24 \cf0 function sc = ApplyDetectorTest(Cparams,ii_im);\
\
[im, ii_im] = LoadIm('face00001.bmp');\
sc= ApplyDetector(Cparams,ii_im);\
\
end\
\
}