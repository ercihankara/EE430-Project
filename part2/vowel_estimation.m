% Ercihan Kara / 2375160
% Beste Öztop / 2375624
function vowel_pred = vowel_estimation(formant_freqs_updated, audio_type, gender)

    if audio_type == "whisper"
        vowel_categories = {'whisper_a', 'whisper_i', 'whisper_u', 'whisper_e', 'whisper_o', 'whisper_ö', 'whisper_ı', 'whisper_ü'};
        % Categorize vowels for whispering
        if gender == 'M'
            vowel_freqs = [900 1400; 460 2000; 390 920; 520 1780; 610 1190; 470 1430; 420 1500; 330 1730];
        elseif gender == 'F'
            vowel_freqs = [1000 1350; 400 1800; 390 920; 520 1780; 760 1500; 600 1630; 420 1500; 400 1530];
        end

    else
        vowel_categories = {'a', 'i', 'u', 'e', 'o', 'œ - ö', 'ɯ - ı', 'y - ü'};
        % Categorize vowels for normal speech
        if gender == 'M'
            vowel_freqs = [500 900; 310 2070; 390 920; 520 1980; 500 860; 470 1430; 300 1700; 330 1730];
        elseif gender == 'F'
            vowel_freqs = [900 1050; 310 2070; 390 920; 640 760; 580 910; 450 1630; 420 1550; 400 1730];
        end
        % Categorize vowels for whispering normal speech
        % vowel_freqs = [650 1130; 310 2070; 390 920; 520 1780; 500 860; 470 1430; 420 1500; 330 1730];
        % a e ı i o ö u ü
    end

    vowel_predictions = [];
    % Compute distances between formant frequencies and vowel prototypes
    distances = zeros(1, size(vowel_freqs, 1));
    for j = 1:size(vowel_freqs, 1)
        distances(j) = norm(formant_freqs_updated(1:2) - vowel_freqs(j,:));
    end
    % Assign vowel label to the frame with the minimum distance
    [~, vowel_predictions] = min(distances);

    vowel_pred = vowel_categories(vowel_predictions);
end