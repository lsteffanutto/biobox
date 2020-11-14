function [p_Welch,Rxx_unbiaised] = caracterisation(signal,disp)

N=length(signal);
x=1:N;

[p_Welch] = periodogrammes(signal,0);
[~,Rxx_unbiaised] = auto_corrs(signal,0);

save=0;
if disp ==1
    if save ==1
        FigH = figure('Position', get(0, 'Screensize'));
    else
        figure,
    end
    subplot(2,2,1); %signal
    plot(x,signal),title('Signal');xlim([0 N]);

    subplot(2,2,2); %pWelch
    fech=1;
    f=-(fech/2):1/N:(fech/2) -1/N;
    plot(f,p_Welch);
    title('Periodogramme de Welch');
    xlabel('Fréquence normalisée')
    ylabel('Puissance') % en puissance

    subplot(2,2,3); %spectro
    spectro(signal);

    subplot(2,2,4); %Autocorr
    t=-N:1:N-2;
    plot(t,Rxx_unbiaised);
    title('Auto-correlation');
    xlabel('échantillons');
    ylabel('Amplitude');
    xlim([-N-150 N+150])
    
    if save ==1
        saveas(FigH, 'Foo.png','png');
    else
end


end

