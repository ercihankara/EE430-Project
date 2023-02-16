function gender = alternative_detect_gender(voice, freqs_formant, sampling_freq)

    % Extract pitch and fundamental frequency for the speaker
    pitcher = pitch(voice, sampling_freq);
    f0 = fundamental_freq(voice, sampling_freq);
    
    % Classify the speaker as male or female based on formant frequencies, pitch, and fundamental frequency
    if (mean(freqs_formant) < 500) && (mean(pitcher) < 150) && (mean(f0) < 150)
        gender = "male";
    elseif (mean(freqs_formant) > 500) && (mean(pitcher) > 150) && (mean(f0) > 150)
        gender = "female";
    else
        gender = "none";
    end


end