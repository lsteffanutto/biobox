function [res, nb_IMFs_sum] = sum_k_last_IMF(signal,k,IMFs_extracted,disp)
nb_IMFs_sum = k;
[nb_IMFs,N] = size(IMFs_extracted);

if k==1
    res = IMFs_extracted(nb_IMFs-k+1:nb_IMFs,:); %si y'a qu'une IMF on sum pas
else
    res = sum(IMFs_extracted(nb_IMFs-k+1:nb_IMFs,:));
end

x=1:N;

if disp==1
    figure,
    h1=subplot(2,1,1);plot(x,signal),title("Signal");xlim([0 N]);%ylim([-3 3]);
    h2=subplot(2,1,2);plot(x,res),title("Somme des "+k+" last IMFs");xlim([0 N]);%ylim([-3 3]);
    h = [ h1, h2];
    linkaxes(h);
end

end

