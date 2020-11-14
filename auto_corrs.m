function [R_xx_biaised, R_xx_unbiaised] = auto_corrs(signal,disp)
% R_xx_biaised pour étude asymptotique
% R_xx_unbiaised pour étude vers 0
N=length(signal);

R_xx_biaised = xcorr(signal,signal,'biased'); %Nombre fini d'échantillon => Auto-corr théorique et auto-corr biasé sont les mêmes avec un facteur 1/N près
R_xx_unbiaised = xcorr(signal,signal,'unbiased');

if disp ==1
    
    t=-N:1:N-2;
    
    figure,
    subplot(2,1,1);
    plot(t,R_xx_biaised);
    title('R_x_x Biased');
    xlabel('échantillons');
    ylabel('Amplitude');
    xlim([-N-150 N+150])
%     ylim([-0.2 1.3])

    subplot(2,1,2);
    plot(t,R_xx_unbiaised);
    title('R_x_x Unbiased');
    xlabel('échantillons');
    ylabel('Amplitude');
    xlim([-N-150 N+150])
%     ylim([-1.3 1.3])
    
    
end
end

