function [ IMFs_extracted, nb_iterations_par_IMF, moy_IMFs, residu] = decomposition_IMFs(signal,disp)

IMFs_extracted=[];
nb_iterations_par_IMF=[];

[ res_IMF, nb_iterations_IMF, res_signal ] = find_IMF_X( signal );

IMFs_extracted = [IMFs_extracted; res_IMF];
nb_iterations_par_IMF = [ nb_iterations_par_IMF;nb_iterations_IMF];

residu = res_signal-IMFs_extracted; 

fin_IMF = 0;
if is_Monotone(residu)==1, fin_IMF=1; %si résidu monotone on s'arrête on les a toutes
end

k = 1; %nombre d'IMF min
while fin_IMF == 0
    
    [ res_IMF, nb_iterations_IMF, res_signal ] = find_IMF_X( res_signal );

    IMFs_extracted = [IMFs_extracted; res_IMF];
    nb_iterations_par_IMF = [ nb_iterations_par_IMF;nb_iterations_IMF];
    k=k+1;
    
    residu = res_signal-IMFs_extracted(k,1); %k-eme IMFs
    
    if is_Monotone(residu)==1
        fin_IMF=1;
    end
    
end

moy_IMFs = mean(IMFs_extracted')';
% trend_signal = % allure du signal 
% nb_iterations_per_IMFs

%% MEGA PLOT
[nb_IMFs,N] = size(IMFs_extracted);
x=1:N;
nb_plot = nb_IMFs + 2; %signal original et résidu

avec_signal_et_residu=0;

IMF_decompo_disp=disp;

if IMF_decompo_disp==1
    
    if avec_signal_et_residu==1 %TOUS
        figure,

        h=subplot(nb_plot,1,1);plot(x,signal),title('Signal Original');xlim([0 N/3]);%ylim([-3 3]);

        for i = 1:nb_IMFs      
            a = subplot(nb_plot,1,i+1);plot(x,IMFs_extracted(i,:)),title("IMF"+i+" - "+ nb_iterations_par_IMF(i) +" iterations");xlim([0 N/3]);%ylim([-3 3]);
            h = [ h, a];
        end

        a =subplot(nb_plot,1,nb_plot);plot(x,residu),title('Residu Final');xlim([0 N/3]);%ylim([-3 3]);
        h = [ h, a];
        linkaxes(h); %zoom synchronisé
    %     suptitle('Signal, IMFs et résidu')

    else %JUSTE IMFs
        nb_plot=nb_plot-2;
        figure,
        h=[];
        for i = 1:nb_IMFs      
            a = subplot(nb_plot,1,i);plot(x,IMFs_extracted(i,:)),title("IMF"+i+" - "+ nb_iterations_par_IMF(i) +" iterations");xlim([0 N/3]);%ylim([-3 3]);
            h = [ h, a];
        end

        linkaxes(h); %zoom synchronisé
        
    end

end



