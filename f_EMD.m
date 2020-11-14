close all, clc, clear all

% Chaque ligne est composee de 50 signaux ayant tous ma meme regularite
% Les signaux de la i-eme ligne ont une regularite de i*0.1
% load('../data_Weierstrass.mat');

%% Parameters
took_number = 3; % designe le nombre de regularite qu'on va tester (ici 0.1,0.5 et 0.9)
% N= 1024;
N=2^14;

% %% signatures des signaux
% Regularity_type = cell(length(data),took_number);
% 
% % Les signaux situes sur la meme colonne ont la meme regularite
% for i=1:took_number
%     for j=1:length(data)
%         Regularity_type {j,i} = ['Signal_' num2str(j,'%01d') '-Regularity_' num2str(i,'%01d') ] ;
%     end
% end

%% signaux
% Etude des signaux de regularite 0.1, 0.2 et 0.3 chaque ligne correspond a
% une regularite ligne 1 -> regularite 0.1
% Matrice_signaux = cell(took_number,1);
% Matrice_signaux_bis = cell(took_number,1);
% 
% for i=1:took_number
%     Matrice_signaux{i,1} = data{1,i}(1:N)'; %signaux différents
%     Matrice_signaux_bis{i,1} = data{i,1}(1:N)'; %même signaux avec alpha differents
% end

% save('./EMD.mat','Matrice_signaux','Regularity_type','Matrice_signaux_bis') ;

%%%%% SAVE LES STRUCTS BIEN dans EMD.mat ,comme ça juste à les charger %%%%%%
load('./EMD.mat')
x=1:N;
%% EMD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Observe les signaux
% figure,
% subplot(3,1,1);plot(x,Matrice_signaux{1,1}),title('s1');xlim([0 N]);
% subplot(3,1,2);plot(x,Matrice_signaux{2,1}),title('s2');xlim([0 N]);
% subplot(3,1,3);plot(x,Matrice_signaux{3,1}),title('s3');xlim([0 N]);
% suptitle('3 signaux differents')
% 
% figure,
% subplot(3,1,1);plot(x,Matrice_signaux_bis{1,1}),title('s1');xlim([0 N]);
% subplot(3,1,2);plot(x,Matrice_signaux_bis{2,1}),title('s2');xlim([0 N]);
% subplot(3,1,3);plot(x,Matrice_signaux_bis{3,1}),title('s3');xlim([0 N]);
% suptitle('Meme signal avec alpha differents')

%% ALGO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_1_alpha_0_1 = Matrice_signaux_bis{1,1}; %signal 1 regularite 0.1 (1ere colonne 1ligne)
signal_1_alpha_0_2 = Matrice_signaux_bis{2,1};%signal 1 regularite 0.2 (1ere colonne 2eme ligne) MEAN_ALPHAS = 0.1737
signal_1_alpha_0_3 = Matrice_signaux_bis{3,1};%signal 1 regularite 0.3 (1ere colonne 3eme ligne) MEAN_ALPHAS = 0.1026

signal_1_alpha_0_1 = Matrice_signaux{1,1};   %signal 1 regularite 0.1 / MEAN_ALPHAS = 0.2108
signal_2_alpha_0_1 = Matrice_signaux{2,1};   %signal 2 regularite 0.1 / MEAN_ALPHAS = 0.0844
signal_3_alpha_0_1 = Matrice_signaux{3,1};   %signal 3 regularite 0.1 / MEAN_ALPHAS = 0.3702


%Input
signal = signal_1_alpha_0_1;

mu=mean(signal);
signal = signal-mu;

%PRINTS
disp_IMFs=0;
disp_caracterisation_IMFs=0;
disp_caracterisation_signal_moins_k_last_IMFs=0;
disp_residus_k_last_IMFs=1;
disp_F_n_par_residu=0;
disp_estimation_variance_approx_pente=0;
%% Enveloppe Moyenne: à partir enveloppe max et enveloppe min

% set(0,'DefaultFigureWindowStyle','docked') 
set(0,'DefaultFigureWindowStyle','normal') 

%% IMFs EXCTRACTION
[ IMFs_extracted, nb_iterations_par_IMF,  moy_IMFs, residu] = decomposition_IMFs(signal,disp_IMFs);
nb_iterations_par_IMF
moy_IMFs
moy_signal=mean(signal)
moy_residu=mean(residu)

%% PLOT LES LAST IMFs / RESIDU / SUM_LAST_IMFS
% k=8; %8 LAST IMFS
% plot_k_last_IMFs_and_residu(k,IMFs_extracted,residu);
% [sum_IMF, nb_IMFs]=sum_k_last_IMF(signal,k,IMFs_extracted,1);
% soustraction_IMF_8=soustraire_IMF(signal,sum_IMF,nb_IMFs,1);
% 
% k=3; %4 LAST IMFS
% plot_k_last_IMFs_and_residu(k,IMFs_extracted,residu);
% [sum_IMF, nb_IMFs]=sum_k_last_IMF(signal,k,IMFs_extracted,1);
% soustraction_IMF_8=soustraire_IMF(signal,sum_IMF,nb_IMFs,1);

% figure,plot(sum(IMFs_extracted(5:end,:)));xlim([0 N]);ylim([-3 3]);

%% ON FAIT UNE MATRICE: [SIGNAL - last IMF ; SIGNAL - 2 last IMF ; ... ; SIGNAL - toutes les IMF]
[signal_moins_k_last_IMFs,moyenne_signal_moins_k_IMF] = signal_moins_k_IMFS(signal,IMFs_extracted,0);

%% CARACTERISATION: PLOT, POWERSPECTRE, SPECTRO, AUTOCORR

%SIGNAL ET IMFS
if disp_caracterisation_IMFs ==1
caracterisation(signal,1);suptitle('Signal');
caracterisation(IMFs_extracted(1,:),1);suptitle('IMF1');
caracterisation(IMFs_extracted(2,:),1);suptitle('IMF2');
caracterisation(IMFs_extracted(3,:),1);suptitle('IMF3');
caracterisation(IMFs_extracted(4,:),1);suptitle('IMF4');
caracterisation(IMFs_extracted(5,:),1);suptitle('IMF5');
caracterisation(IMFs_extracted(6,:),1);suptitle('IMF6');
caracterisation(IMFs_extracted(7,:),1);suptitle('IMF7');
caracterisation(IMFs_extracted(8,:),1);suptitle('IMF8');
caracterisation(IMFs_extracted(9,:),1);suptitle('IMF9');
caracterisation(residu,1);suptitle('Residu');
end

% RESIDUS SELON NOMBRE D'IMFs SOUSTRAIT AU SIGNAL
if disp_caracterisation_signal_moins_k_last_IMFs==1
caracterisation(signal_moins_k_last_IMFs(1,:),1);suptitle('Signal moins 1 last IMF');
caracterisation(signal_moins_k_last_IMFs(2,:),1);suptitle('Signal moins 2 last IMF');
caracterisation(signal_moins_k_last_IMFs(3,:),1);suptitle('Signal moins 3 last IMF');
caracterisation(signal_moins_k_last_IMFs(4,:),1);suptitle('Signal moins 4 last IMF');
caracterisation(signal_moins_k_last_IMFs(5,:),1);suptitle('Signal moins 5 last IMF');
caracterisation(signal_moins_k_last_IMFs(6,:),1);suptitle('Signal moins 6 last IMF');
caracterisation(signal_moins_k_last_IMFs(7,:),1);suptitle('Signal moins 7 last IMF');
caracterisation(signal_moins_k_last_IMFs(8,:),1);suptitle('Signal moins 8 last IMF');
caracterisation(signal_moins_k_last_IMFs(9,:),1);suptitle('Signal moins 9 last IMF');
end

%% PRINT ensembles
if disp_residus_k_last_IMFs==1
%     figure('Position', get(0, 'Screensize'));
figure,
[nb_sig,~] = size(signal_moins_k_last_IMFs);
h=[];
    for i = 1:5      
        a = subplot(5,1,i);plot(x,signal_moins_k_last_IMFs(i,:)),title("Signal moins "+i+" last IMFs ");xlim([0 N/3]);%ylim([-3 3]);
        h = [ h, a];
    end
    
    figure,
    for j = 6:nb_sig      
        
        a = subplot(nb_sig-5,1,j-5);plot(x,signal_moins_k_last_IMFs(j,:)),title("Signal moins "+j+" last IMFs ");xlim([0 N/3]);%ylim([-3 3]);
        h = [ h, a];
    end

linkaxes(h); %zoom synchronisé
    
end

%% ESTIMATION VARIANCE POUR CHACUN DES RESIDUS obtenus en soustrayant les IMFs

var_sig = var(signal)

% signal_moins_k_last_IMFs = [ signal_moins_k_last_IMFs ; residu]
[var_de_N,index_vars,alphas]=decimation(signal_moins_k_last_IMFs,disp_F_n_par_residu); 
title('Fonctions de fluctuation des residus en enlevant les k last IMFs');drawnow;
mean_alphas=mean(alphas)
% [var_de_N_IMFs,index_vars_IMFs,alphas_IMFs]=decimation(IMFs_extracted,1);
% title('Fonctions de fluctuation IMFs');drawnow;

% Estimation variance résidu normal
% [~,~,alpha_Residu_Decompo_IMFs]=decimation(residu,1);

if disp_estimation_variance_approx_pente==1
    [alpha4] = print_Fluctuation(index_vars(4,:),var_de_N(4,:))
    title('Fonctions de fluctuation Signal moins 4 dernières IMFs');drawnow;

    [alpha8] = print_Fluctuation(index_vars(8,:),var_de_N(8,:))
    title('Fonctions de fluctuation Signal moins 8 dernières IMFs');drawnow;
end

% var_de_N(1,1:4)









IMF_disp=0;

if IMF_disp==1
    figure,
    subplot(5,1,1);plot(x,signal),title('Signal');xlim([0 1024]);ylim([-3 3]);
    subplot(5,1,2);plot(x,IMFs_extracted(1,:)),title("IMF1 - "+ nb_iterations_par_IMF(1) +" iterations");xlim([0 1024]);ylim([-3 3]);
    subplot(5,1,3);plot(x,IMFs_extracted(3,:)),title("IMF3 - "+ nb_iterations_par_IMF(3) +" iterations");xlim([0 1024]);ylim([-3 3]);
    subplot(5,1,4);plot(x,IMFs_extracted(5,:)),title("IMF5 - "+ nb_iterations_par_IMF(5) +" iterations");xlim([0 1024]);ylim([-3 3]);
    subplot(5,1,5);plot(x,residu),title('Residu restant');xlim([0 1024]);ylim([-3 3]);
end





