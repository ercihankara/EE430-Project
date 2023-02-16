function f0 = fundamental_freq(voice, sampling_freq)
    % Calculate fundamental frequency of audio signal using the cepstral method
    cepstra = rceps(voice);
    [~, peaks] = findpeaks(cepstra);
    f0 = sampling_freq / (peaks(2) - peaks(1));
end