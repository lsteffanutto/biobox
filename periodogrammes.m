function [p_Welch,p_Daniell,p_Bartlett] = periodogrammes(signal,disp)

N=length(signal);
nfft = N;
noverlap = nfft/2;
noverlapnul=0;

%WELCH
p_Welch = pwelch(signal,nfft,noverlap, 'centered')*10;

%DANIELL
%On estime la DSP de chaque segment de m points pour lisser la courbe
p_Daniell = PDaniell(signal);

%BARTLETT
p_Bartlett = pwelch(signal,nfft,noverlapnul,'centered')*10;

if disp==1
    fech=1;
    f=-(fech/2):1/N:(fech/2) -1/N;
    figure,
    subplot(3,1,1);
    plot(f,p_Welch);
    title('Pwelch');
    xlabel('Fréquence normalisée')
    ylabel('Puissance') % en puissance

    subplot(3,1,2);
    plot(f,p_Daniell);
    title('PDaniell');
    xlabel('Fréquence normalisée')
    ylabel('Puissance') % en puissance

    subplot(3,1,3);
    plot(f,p_Bartlett');
    title('PBarlett');
    xlabel('Fréquence normalisée')
    ylabel('Puissance') % en puissance

end

end

