function pitch = pitch(voice, fs)
    % Calculate pitch of audio signal using the autocorrelation method
    autocorr = xcorr(voice, 'coeff');
    [~, lag] = max(autocorr);
    pitch = fs / lag;
end