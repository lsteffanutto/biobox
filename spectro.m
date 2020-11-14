function [res] = spectro(signal)

res=1;

fech = 8000;
Tech=1/fech;
t = 0:Tech:length(signal)*Tech-Tech;
fs = 10000;
win  = 2048;
spectro_noverlap = 0.5*win; 
spectrogram(signal,win,spectro_noverlap,[],fech,'yaxis')
title('Spectrogramme');


end

