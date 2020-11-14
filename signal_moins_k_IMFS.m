function [signal_moins_k_last_IMFs,moyenne_signal_moins_k_IMF] = signal_moins_k_IMFS(signal,IMFs_extracted,disp)
[k,~]=size(IMFs_extracted);
N=length(signal);
moyenne_signal_moins_k_IMF=zeros(k,N);
signal_moins_k_last_IMFs=zeros(k,N);


    
    for index = 1:k
 
    % plot_k_last_IMFs_and_residu(k,IMFs_extracted,residu);       %plot les k dernieres IMFs et le residus
    [sum_IMF, nb_IMFs]=sum_k_last_IMF(signal,index,IMFs_extracted,0);  %plot sum des k dernieres IMFs et le residus

    signal_moins_k_last_IMFs(index,:)=soustraire_IMF(signal,sum_IMF,nb_IMFs,0);
    
%     caracterisation(signal_moins_k_last_IMFs(index,1),disp);suptitle("Signal - "+k+" last IMF");drawnow;

    end
moyenne_signal_moins_k_IMF = mean(signal_moins_k_last_IMFs')'

end
