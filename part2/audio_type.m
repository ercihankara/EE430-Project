% Ercihan Kara / 2375160
% Beste Öztop / 2375624
function type = audio_type(STFT)
    if abs(max(STFT)) < 20
        type = "whisper";
    else
        type = "normal speech";
    end
end