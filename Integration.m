%% Etape 1 : la s?rie originale est int?gr?e
%%L'integration permet de resoudre le probleme de bornage des series physiologiques dans les limites normales.

function [Matrice_signaux_Integres] = Integration(Matrice_signaux)
    
    % Matrice_Signaux contient un vecteur signal par ligne
    Matrice_signaux_Integres = cell(3,1);
    l = length(Matrice_signaux{1});
    
    % calcul de la moyenne de la serie
    Matrice_moyenne = zeros(1,3);
    
    for i=1:3
        Matrice_signaux_Integres{i} = zeros(1,l);
        Matrice_moyenne(i) = mean(Matrice_signaux{i});

        for j=1:l
            s = 0;
            for k=1:j
                s = s + Matrice_signaux{i}(k);
            end
            Matrice_signaux_Integres{i}(j) = s - Matrice_moyenne(i);
        end
    end
    
end

