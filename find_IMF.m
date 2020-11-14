function [ res_IMF, res_signal ] = find_IMF( signal, mean_envelope_signal)
% 1 INPUT: signal
% 2 OUTPUT: extracted_IMF ; signal-extracted_IMF

res_IMF = signal-mean_envelope_signal; % pour l'instant on va dire que faut soustraire juste une fois

res_signal = mean_envelope_signal; %le signal devient l'enveloppe moyenne
end

