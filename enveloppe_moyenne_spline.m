function [ res ] = enveloppe_moyenne_spline( signal )
%Calcul enveloppe moyenne d'un signal, à partir de ses enveloppes min/max

graph = 0; % On plot (1) ou pas (0)

N = length(signal);
xx = 1:N;

%Enveloppe_max
[pks,locs] = findpeaks(signal); %vecteur lignes des peaks et vecteur ligne de leur valeur

% For interpolate 1st and last values of the signal considerated as max
pks = [ signal(1) pks signal(N) ];
locs = [ 1 locs N ];

nb_peaks_max = length(pks);

env_max = spline(locs,pks,xx); % enveloppe des maximas avec cubic spline interpolation curve 

%Enveloppe_min 
% on inverse le signal pour que les mins deviennent des max " -(siganl) "
% on enregistre la localisation de ces maxs du signal inverse
% ensuite on prend ces positions, mais dans le signal de départ, et on a les mins
[pks_min,locs_min] = findpeaks(-signal);

% For interpolate 1st and last values of the signal considerated as min

pks_min = [ signal(1) pks_min signal(N) ];
locs_min = [ 1 locs_min N ];

nb_peaks_min = length(pks_min);

env_min = spline(locs_min,signal(locs_min),xx);

mean_env_spline = (env_max + env_min)/2 ;

%Observations

if graph == 1
    
    figure,

    plot(signal,'b-');xlim([0 1024]); %signal
    hold on;
    scatter(locs,pks,'r+','LineWidth',1);xlim([0 1024]); %points max
    hold on;
    scatter(locs_min,signal(locs_min),'k+','LineWidth',1);xlim([0 1024]); %points min
    hold on;
    plot(env_max,'g-','LineWidth',1);xlim([0 1024]); %env_max
    hold on;
    plot(env_min,'r-','LineWidth',1) %env_min
        
    plot(mean_env_spline,'y-','LineWidth',1.5);%ylim([-5 2]); %env_moyenne
    
    title('Enveloppe moyenne "cubic spline" du signal');
    
    xlabel('Echantillons');
    ylabel('Amplitude');
    legend('signal','maxs','mins','env-max','env-min','enveloppe moyenne');
    
end

res = mean_env_spline;

end

