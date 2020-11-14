function [ res ] = enveloppe_moyenne( signal, window )
%Calcul enveloppe moyenne d'un signal, à partir de ses enveloppes min/max
%avec fonctions envelope() de Matlab qui dépend de la fenêtre

graph = 1; % On plot (1) ou pas (0)
plot_windows = 1;


N = length(signal);
nb_windows = N/window;
nb_extremums = window;
%returns the upper and lower peak envelopes of x.
%using spline interp, local maxima separated by at least np samples

%repère les min/max dans des fenetres de cette taille
%mais garde N points en interpolant
[yupper,ylower] = envelope(signal,2,'peak'); %envelopes min/max

index_maxs = find(yupper==signal); %on cherche l'abscisse des min/max
index_mins = find(ylower==signal);

nb_max = length(index_maxs);
nb_min = length(index_mins);

max_win = zeros(1,nb_windows);
min_win = zeros(1,nb_windows);

for i =0:nb_windows
    [M i_max] = max(signal(1,(i+1)*window:(i+2)*window-1));
    [m i_min] = min(signal(1,(i+1)*window:(i+2)*window-1));
    
    max_win = [max_win i_max];
    min_win = [min_win i_min];
end

res = (yupper+ylower)/2;            %%envelope moyenne

%Observations
if graph == 1
    
    figure,
    
    
    plot(signal,'b-');xlim([0 1024]); %signal
    hold on;
    scatter(index_maxs,signal(index_maxs),'r+','LineWidth',1);xlim([0 1024]); %points max
    hold on;
    scatter(min_win(1,:),signal(1,min_win(1,:)),'k+','LineWidth',1);xlim([0 1024]); %points min
    hold on;
    plot(yupper,'g-');xlim([0 1024]); %env_max
    hold on;
    plot(ylower,'r-');xlim([0 1024]); %env_min
    hold on;
    
    plot(res,'y-','linewidth',1.5);xlim([0 1024]);  %envelope moyenne
    
%     title('Enveloppe moyenne "envelope()" du signal dependant taille window = ' + window + 'echantillons');
    title( ['Enveloppe moyenne "envelope()" du signal dependant taille window = ' num2str( window ) ' echantillons'] )
    
    xlabel('Echantillons');
    ylabel('Amplitude');
        
    y1=get(gca,'ylim'); %défini amplitude extremes du graph
    if plot_windows == 1  && window>=32
        for i = 1:nb_windows-1
            hold on
            pos_fen = i*window;
            plot([pos_fen pos_fen],y1,'--','Color', uint8([17 17 17]));
        end
    end
    
    legend('signal','maxs','mins','env-max','env-min','enveloppe moyenne', 'fenetres');
    
end

end
