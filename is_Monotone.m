function [res] = is_Monotone(signal)
% if function is monotone (1) or not (0)
res = 0;
derivee = diff(signal,1);

if all(derivee(:)>=0)||all(derivee(:)<=0)
    res = 1 ;
end

end

