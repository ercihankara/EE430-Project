% Ercihan Kara / 2375160
% Beste Öztop / 2375624
function gender = detect_gender(freqs_formant, type)
    % discriminate between male and female based on formant frequencies
    if type == "normal speech"
        if (freqs_formant(2) > 500) && (freqs_formant(3) < 3000)
            gender = 'M';
        elseif (freqs_formant(3) > 3000)
            gender = 'F';
        else
            gender = 'U';
        end
    elseif type == "whisper"
        if (freqs_formant(2) > 500) && (freqs_formant(3) < 2500)
            gender = 'M';
        elseif (freqs_formant(3) > 2500)
            gender = 'F';
        else
            gender = 'U';
        end
    end
end