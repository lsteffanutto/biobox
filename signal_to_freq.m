function [res] = signal_to_freq(signal,Fs)
%DOC Matlab FFT

N=length(signal);
% Fs = 1000;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
L = N;               % Length of signal
% t = (0:L-1)*T;        % Time vector

Y=abs(fft(signal)).^2/N;
% Y = (fftshift(abs(fft(signal))).^2)/N;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure;
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Signal Powerspectre')
xlabel('f (Hz)')
ylabel('|P1(f)|')

end

