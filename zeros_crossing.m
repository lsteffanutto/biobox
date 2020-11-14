function [total_zero_crossing,downcross, upcross] = zeros_crossing(signal)

% upward zero-crossings to nearest time step
upcross = find(signal(1:end-1) <= 0 & signal(2:end) > 0);
% interpolate
upcross = upcross - signal(upcross) ./ (signal(upcross+1)-signal(upcross));
% downward zero-crossings
downcross = find(signal(1:end-1) >= 0 & signal(2:end) < 0);
downcross = downcross - signal(downcross) ./ (signal(downcross+1)-signal(downcross));

total_zero_crossing = length(downcross)+length(upcross);

end

