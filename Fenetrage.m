%% Etape 2 : la s?rie int?gr?e est ensuite divis?e en fen?tres ind?pendantes de longueur ?quivalente n.

function [Matrice_signaux_Fenetres] = Fenetrage(Matrice_signaux_Integres,n,recouvrement)

    % Decoupage du signal en fenetres de taille n et recouvrement est soit O % soit 50%
    
    Matrice_signaux_Fenetres = cell(3,1);
    l = length(Matrice_signaux_Integres{1});
    for i=1:3
        if recouvrement == 0 
            Matrice_signaux_Fenetres{i} = reshape(Matrice_signaux_Integres{i}, l/n, n);
        end
        if recouvrement == 0.5
            Matrice_signaux_Fenetres{i} = zeros(fix((l*2)/n-1),n);
            for j = 1:fix(((l*2)/n-1))
                Matrice_signaux_Fenetres{i}(j,:) = Matrice_signaux_Integres{i}(fix((j-1)*(n/2)+1):((j-1)*(n/2)+n));           
            end
            Matrice_signaux_Fenetres{i} = Matrice_signaux_Fenetres{i}.*(hamming(n)).';
        end
    end
end

