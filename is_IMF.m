function [res] = is_IMF(signal)
%return if a function (1) is an IMF o no (0)

conditions_IMF = 0;

[pks,locs] = findpeaks(signal); nb_max = length(pks); %nb maximums
[pks_min,locs_min] = findpeaks(-signal);nb_min = length(pks_min); %nb minimums

nb_extremas = nb_max + nb_min;
nb_zero = zeros_crossing(signal) ;
moyenne = mean(signal);
diff_extrema_nb_zero_crossings = abs(nb_zero-nb_extremas);

if (diff_extrema_nb_zero_crossings<=1) && abs(moyenne)<0.1 %conditions nb_extremas = nb_zero_crossing (+-1) + moyenne environ nulle
    conditions_IMF = 1;
end

res = conditions_IMF;

end

