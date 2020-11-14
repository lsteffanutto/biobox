function [res] =soustraire_IMF(signal,sum_IMF,nb_IMFs,disp);

res = signal - sum_IMF;
[~,N] = size(sum_IMF);
x=1:N;

if disp==1
    figure,
    h1=subplot(3,1,2);plot(x,signal),title("Signal");xlim([0 N]);%ylim([-3 3]);
    h2=subplot(3,1,1);plot(x,sum_IMF),title("Sum des "+nb_IMFs+" last IMFs");xlim([0 N]);%ylim([-3 3]);
    h3=subplot(3,1,3);plot(x,res),title("Signal moins Sum des "+nb_IMFs+" last IMFs");xlim([0 N]);%ylim([-3 3]);
    h = [ h1, h2, h3];
    linkaxes(h);
end

end

