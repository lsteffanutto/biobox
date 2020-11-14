function [powerscpectre] = powerspectre_normalized(signal)

N=length(signal);
fech=1;
f=-(fech/2):1/N:(fech/2) -1/N; %-fech/2 à fech/2 %fréquence normalisée, 

powerscpectre = (fftshift(abs(fft(signal))).^2)/N;
%Spectre de puissance

plot(f,powerscpectre);
title('Spectre de puissance du signal')
xlabel('Fréquence normalisée')
ylabel('Puissance') % en puissance

end

