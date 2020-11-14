function [ res ] = mean_enveloppes_moyennes( signal, window, nb_enveloppes_moyennes )
% fais la moyenne de nb_enveloppes_moyennes de fenetre de taille window

np = window; %repère les min/max dans des fenetres de cette taille
%mais garde N points en interpolant
N = length(signal);

res = zeros(1,N); %pour stocker toutes les enveloppes moyennes

for i = 1:nb_enveloppes_moyennes
   
    [yupper,ylower] = envelope(signal,np,'peak'); %envelopes min/max
    mean_env = (yupper+ylower)/2;                      %%envelope moyenne
    res = res + mean_env;
end

res = res / nb_enveloppes_moyennes;

hold on;
plot(res,'g-');xlim([0 1024]);
end

