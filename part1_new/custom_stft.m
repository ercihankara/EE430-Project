% Ercihan Kara - 2375160
% code to create STFT of a discrete-time signal:
% spectrogram is a color or grey scale plot of the magnitude of the short-time Fourier transform (STFT) on the time-frequency plane.
% the STFT of a signal is computed by sliding an analysis window g(n) of
% length M over the signal and calculating the discrete Fourier transform (DFT) of each segment of windowed data.

function [time, freqs, STFT] = custom_stft(in_sig, win_len, win_type, shift, num_fft, freq)

% output:
% STFT: Short-time Fourier transform
% time: time vector (sec)
% freqs: frequency vector (Hz)

% input:
% in_sig: input signal in time domain (discrete)
% win_len: length of the desired window signal to be used in windowing purposes
% shift: window shift (<= win_len)
% num_fft: number of fft points
% freq: sampling frequency in Hz

% set the window signal depending on the input
switch win_type 
    case  'tukey'
         win_sig = tukeywin(win_len).';
    case 'blackman'
         win_sig = blackman(win_len).';
    case 'hamming'
         win_sig = hamming(win_len).';
    case 'hanning'
         win_sig = hanning(win_len).';  
    case 'kaiser'
         beta = 5;
         win_sig = kaiser(win_len, beta).';
    case 'gaussian'
         win_sig = gausswin(win_len).';
    case 'triangular'
         win_sig = triang(win_len).';
    case 'rectangular'  % rectangular window
         win_sig = ones(1, win_len);
end

% make input signal column vector for computations
in_sig = in_sig(:);

% lengths of signals
in_len = length(in_sig);

% number of segments/frames
num_seg = 1+fix((in_len-win_len)/shift);

% number of unique fft points ???????????
num_uniq_fft = ceil((1+num_fft)/2);

% create the stft matrix
STFT = zeros(num_uniq_fft, num_seg);

% calculations:
for i=0:num_seg-1
    % window the input signal by multiplication (element-wise)
    in_sig_wind = in_sig((1+i*shift) : (win_len+i*shift)).*win_sig;
    
    % apply built-in fft (samples of dtft)
    temp = fft(in_sig_wind, num_fft);
    
    % update the stft matrix
    STFT(:, 1+i) = temp(1 : num_uniq_fft);
end

% generate time and frequency vectors for spectrogram ????????????
time = ((win_len/2) : shift : (win_len/2 + (num_seg-1)*shift));
freqs = (0 : num_uniq_fft-1) * (freq/num_fft) / freq;

end