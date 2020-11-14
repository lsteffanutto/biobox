function [vars_tot, index_vars_tot,alphas] = decimation(signaux,disp)
% Tu prend un residu et tu decime avec des tailles de N differentes et tu calcul la variance
% N=1:len_sig
% var normale
% tu prend tous les 2 tu decale tu refais puis moyenne
% tu prend tous les 3 tu de cale 2 fois puis moyenne etc
% Var(A), avec A matrix = variance des columns de A

[nb_sig,len_sig]=size(signaux);
% vars = zeros(1,len_sig); 
vars=[];
index_vars=[];

vars_tot=[];
index_vars_tot=[];

for j = 1:nb_sig %Pour chaque signaux
    
signal=signaux(j,:); 

vars=[];
index_vars=[];
for i = 2:len_sig     %Estimer la variance pour differentes tailles de decimation (ici puissance de 2)
N=i;
if mod(len_sig,N)==0

nb_win=fix(len_sig/N);
nb_elements = N*nb_win;
sig_temp  = signal(1:nb_elements);
decimation_colonne=reshape(sig_temp,nb_win,N)';
var_i=var(decimation_colonne);
var_i= mean(var_i');
% vars(1, i) = var_i;
vars = [vars var_i];
index_vars=[index_vars N];

end

end
vars_tot(j,:) = vars;                     %chaque signal une ligne
index_vars_tot(j,:) = index_vars;   %Ou on range ses variances et dans autre matrice taille décimation
end

alphas = zeros(nb_sig,1); %on calcul les alphas et les stocks en colonne


 %on print les délires

x=log10(index_vars_tot);
y=log10(vars_tot);

if disp==1
    figure,
    xlabel('Log_1_0(n)');
    ylabel('Log_1_0(F(n))');
    title('Fonctions de fluctuation'); % PRINT LEGEND DU RéSIDU
end

for sig = 1:nb_sig

    

    p = polyfit(x(sig,:),y(sig,:),1); %p(1) = alpha; p(2) = Beta
    f = polyval(p,x(sig,:)); 
    alphas(sig,1) = p(1);
    
    if disp==1
%         hold on;scatter(x,y,'LineWidth',1);
        hold on;plot(x(sig,:),f,'LineWidth',1);
    end
end

if disp==1
    legend("\alpha_1 = " + alphas(1,1), "\alpha_2 = " + alphas(2,1),"\alpha_3 = " + alphas(3,1),"\alpha_4 = " + alphas(4,1),"\alpha_5 = " + alphas(5,1),"\alpha_6 = " + alphas(6,1),"\alpha_7 = " + alphas(7,1),"\alpha_8 = " + alphas(8,1),"\alpha_9 = " + alphas(9,1));
end

end

%verif
% a = [ 1 2 3 4];
% a=reshape(a,2,2)';
% var_a = var(a);
% mean(var_a');

%N=1 taille de la fenêtre = 1 on prend tous les points
% var_1 = var(signal);
% vars(1,1) = var_1;
% 
% 
% N=2; %taille de la fenêtre = 2 on prend un point sur 2, calcul variance, et on recommence en decalant de 1 ( prenant les autres points)
% nb_win=len_sig/N;
% decimation_colonne=reshape(signal,nb_win,N)'; %chaque colonne = une decimation [N1.1 N2.1;N1.2 N2.2]
% var_2 = var(decimation_colonne); % variance de chaque decimation
% var_2 = mean(var_2');
% vars(1,2) = var_2;
% 
% N=3;
% nb_win=fix(len_sig/N);
% nb_elements = N*nb_win;
% sig_temp  = signal(1:nb_elements);
% decimation_colonne3=reshape(sig_temp,nb_win,N)'; 
% var_3 = var(decimation_colonne3);
% var_3 = mean(var_3');
% vars(1,3) = var_3;
% 
% N=100;
% nb_win=fix(len_sig/N);
% nb_elements = N*nb_win;
% sig_temp  = signal(1:nb_elements);
% decimation_colonne3=reshape(sig_temp,nb_win,N)';
% var_100 = var(decimation_colonne3);
% var_100 = mean(var_100');
% vars(1,100) = var_100;
% 
% N=100;
% nb_win=fix(len_sig/N);
% nb_elements = N*nb_win;
% sig_temp  = signal(1:nb_elements);
% decimation_colonne3=reshape(sig_temp,nb_win,N)';
% var_100 = var(decimation_colonne3);
% var_100 = mean(var_100');
% vars(1,100) = var_100;
% 
% N=1024;
% nb_win=fix(len_sig/N);
% nb_elements = N*nb_win;
% sig_temp  = signal(1:nb_elements);
% decimation_colonne3=reshape(sig_temp,nb_win,N)';
% var_100 = var(decimation_colonne3);
% var_100 = mean(var_100');
% vars(1,100) = var_100;
% 
% N=1024;
% nb_win=fix(len_sig/N);
% nb_elements = N*nb_win;
% sig_temp  = signal(1:nb_elements);
% decimation_colonne3=reshape(sig_temp,nb_win,N)';
% var_100 = var(decimation_colonne3);
% var_100 = mean(var_100');
% vars(1,100) = var_100


