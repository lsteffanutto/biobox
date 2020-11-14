function [ res_IMF, nb_iterations_IMF, res_signal ] = find_IMF_X(signal)

% 1 INPUT: signal
% 3 OUTPUT: extracted_IMF ; nb_iterations for IMF; res_signal = env_moyenne(signal original)
x = 1:length(signal);
nb_iterations_IMF = 1;

[mean_envelope_signal] = enveloppe_moyenne_spline(signal); %enveloppe moyenne du signal

res_IMF = signal-mean_envelope_signal; % On la soustrait une fois

res_signal = mean_envelope_signal; %le signal devient la première enveloppe moyenne (r=e doc)

%On vérifie si c'est une IMF, 
conditions_IMF = 0;                         % A METTRE A 0 POUR ENLEVER VERIF CONDITIONS IMF               
if is_IMF(res_IMF) == 1, conditions_IMF=1;
end

% si non, on continue le sifting-process pour trouver la vrai IMF
while conditions_IMF == 0
    
    [mean_envelope_signal] = enveloppe_moyenne_spline(res_IMF); %enveloppe moyenne du signal
    res_IMF = res_IMF - mean_envelope_signal;
    nb_iterations_IMF = nb_iterations_IMF +1;
    
    if is_IMF(res_IMF) == 1, conditions_IMF=1 ;
    end
 
end

% si oui, retourne l'IMF et nb d'itérations qu'on a fait pour l'extraire et
% le résidu quand on a soustrait l'IMF au signal

% res_signal = res_signal - res_IMF; % au final on soustrait l'IMF trouvé à l'enveloppe moyenne du signal initial

disp_IMF=0;
if disp_IMF==1
    figure,
    subplot(2,1,1),plot(x,res_IMF),title("IMF found for "+nb_iterations_IMF+"iterations");xlim([0 1024]);ylim([-3 3]);
    subplot(2,1,2),plot(x,res_signal),title('résidu restant');xlim([0 1024]);ylim([-3 3]);

end


end