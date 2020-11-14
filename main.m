%% Fonction principale qui appelle les autres fonctions 

close, clc, clear

% Chaque ligne est composee de 50 signaux ayant tous ma meme regularite
% Les signaux de la i-eme ligne ont une regularite de i*0.1
load('../data_Weierstrass.mat')

%% Parameters
took_number = 3; % designe le nombre de regularite qu'on va tester (ici 0.1,0.5 et 0.9)
N= 1000;
%% signatures des signaux
Regularity_type = cell(length(data),took_number);

% Les signaux situes sur la meme colonne ont la meme regularite
for i=1:took_number
    for j=1:length(data)
        Regularity_type {j,i} = ['Signal_' num2str(j,'%01d') '-Regularity_' num2str(i,'%01d') ] ;
    end
end

%% signaux
% Etude des signaux de regularite 0.1, 0.2 et 0.3 chaque ligne correspond a
% une regularite ligne 1 -> regularite 0.1
Matrice_signaux = cell(took_number,1);
for i=1:took_number
    Matrice_signaux{i,1} = data{i,1}(1:N);
end

% Ecoute du son
audiowrite('signal.wav',Matrice_signaux{1},8000);
%soundsc('signal.wav')

%% Integration
Matrice_signaux_Integres = Integration(Matrice_signaux);

%% Passage en frequentiel pur voir les variations de l'energie et 
%%pouvoir estimer une taille de fenetre adequat

%% Decoupage en fenetres de taille 256
recouvrement = 0.5;
n = 5:N/4;
F_n = cell(1,length(n));
D_n = cell(1,length(n));
Matrice_fenetres = cell(1,length(n));

for n = 5:5:fix(N/4)
    Matrice_signaux_Fenetres = Fenetrage(Matrice_signaux_Integres,n,recouvrement);
    Matrice_fenetres{(n-5)/5 + 1} = Matrice_signaux_Fenetres ;

    %% Matrice des residus
    ordre = fix(n/2);
    [Matrice_courbe_Moindres_carrees,Matrice_F] = Estimation_parametre_autosimilation(Matrice_signaux_Fenetres,ordre);
    F_n{(n-5)/5 + 1} = Matrice_F;
    D_n{(n-5)/5 + 1} = Matrice_courbe_Moindres_carrees;
end

%% On passe au log 
%Regularit? 0.1
Mat_res_1 = Matrice_F{1};
%Regularit? 0.2
Mat_res_2 = Matrice_F{2};
%Regularit? 0.3
Mat_res_3 = Matrice_F{3};

% Estilation des alphas
%%->Etape 1 passage au log
alpha_1 = mean(log10((mean(Mat_res_1))));
alpha_2 = mean(log10((mean(Mat_res_2))));
alpha_3 = mean(log10((mean(Mat_res_3))));




%% Graphe 
% Observation des signaux 
legende = cell(1,3);
cc=hsv(6);

for num_type_regularity=1:3
    legende{num_type_regularity} = Regularity_type{1,num_type_regularity};
end

%%On s'interesse juste au premier signal donne pour chaque regularite
figure
clf
hold on
for type = 1:3
    plot(Matrice_signaux{type}(1:1000),'color',cc(type,:));
end

legend(legende,'Location','NorthEastOutside')
title('Signaux de regularite 0.1, 0.5 et 0.9')
xlabel('echantillons')
ylabel('Signaux')

%%j'ai multiplie par .*(hamming(n)).' pour verifier le fenetrage : on a les memes matrices  
figure
clf
hold on
for type = 1:3
    plot(Matrice_signaux_Integres{type}(1:n).*(hamming(n)).','color',cc(type,:));
end

legend(legende,'Location','NorthEastOutside')
title('Signaux integres de regularite 0.1, 0.5 et 0.9')
xlabel('echantillons')
ylabel('Signaux')

% Pour chaque signal, je trace sa premiere trame afin de le compare a la
% courbe precedente pour verifier si j'ai bien fenetrer
figure
clf
hold on
for type = 1:3
    plot(Matrice_signaux_Fenetres{type}(1,:),'color',cc(type,:));
end
legend(legende,'Location','NorthEastOutside')
title('Fenetre de regularite 0.1, 0.5 et 0.9')
xlabel('echantillons')
ylabel('Signaux')

%%Je regarde la courbe estimee pour la trame 1 du premier 
%%signal de regularite 0.1
figure
clf
hold on
for type = 1:1
    plot(Matrice_fenetres{1,10}{1,1}(1,:),'or');
    hold on
    plot(D_n{1,10}{1,1}(1,:),'*');

end

legend('trame de regularite 0.1','courbe estimee','Location','NorthEastOutside')
title('Fenetre de regularite 0.1, 0.5 et 0.9')
xlabel('echantillons')
ylabel('Signaux')

%On trace les graphes log-log pour estimer alpha
[lf,n] = size(F_n{1,10}{1,1});
legende2 = cell(3,1);%lf);
t = 1:n;
for type = 1:1
    figure
    clf
    hold on
    Matrice_F_log = log10(mean(F_n{1,10}{1,1}));
    hold on
    for j=1:1%lf
        legende2{i,j} = ['trame_' num2str(j,'%01d') '-Regularity_' num2str(i,'%01d') ] ;
        plot(log10(t),Matrice_F_log(j,:),'color',cc(j,:));
    end
    legend(legende2{i},'Location','NorthEastOutside')
    title('log des Fenetre de regularite 0.1')
    xlabel('log des echantillons')
    ylabel('Fenetres')
end
