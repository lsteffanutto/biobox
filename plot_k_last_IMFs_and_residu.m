function [res] = plot_k_last_IMFs_and_residu(k,IMFs_extracted,residu)

res=1;
[nb_IMFs,N] = size(IMFs_extracted);
x=1:N;

nb_plot = k + 1;


figure,
h=[];
for i = nb_IMFs-k+1:nb_IMFs   
    a = subplot(nb_plot,1,i-(nb_IMFs-k));plot(x,IMFs_extracted(i,:)),title("IMF"+i);xlim([0 N]);%ylim([-3 3]);
    h = [ h, a];
end

a = subplot(nb_plot,1,nb_plot);plot(x,residu),title('Residu Final');xlim([0 N]);%ylim([-3 3]);
h = [ h, a];
linkaxes(h);
    
    
end

