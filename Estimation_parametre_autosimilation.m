%% Etape 4 : estimation de alpha le parametre d'auto-similation

function [Matrice_courbe_Moindres_carrees,Matrice_F] = Estimation_parametre_autosimilation(Matrice_signaux_Fenetres,ordre)

    [lf,n] = size(Matrice_signaux_Fenetres{1});
    Matrice_courbe_Moindres_carrees = cell(1,3);
    Matrice_F = cell(1,3);
    x = 1:n;
    % Estimation de la droite des moindres carrees
    for i=1:3
        for j=1:lf
            [P,~,mu] = polyfit(x,Matrice_signaux_Fenetres{i}(j,:),ordre);
            % Redressement
            Matrice_courbe_Moindres_carrees{i}(j,:) = polyval(P,x,[],mu);
            Matrice_F{i}(j,:) = abs(Matrice_signaux_Fenetres{i}(j,:) - polyval(P,x,[],mu)) .^ 2;
        end

    end
end

