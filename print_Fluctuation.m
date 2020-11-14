function [alpha] = print_Fluctuation(indexs_variances,variances)

x=log10(indexs_variances);
y=log10(variances);

figure,scatter(x,y,'LineWidth',1);

hold on;

p = polyfit(x,y,1); %p(1) = alpha; p(2) = Beta
f = polyval(p,x); 
alpha = p(1);

plot(x,f,'r-');

xlabel('log_1_0(n)');
ylabel('log_1_0(F(n))');
title('Fonction de fluctuation'); % PRINT LEGEND DU RéSIDU
legend("vars estimées","\alpha = "+alpha);

end

