function vowel_predictions = alternative(audio, fs)
    
    % Pre-emphasis filtering
    audio = filter([1 -0.95], 1, audio);
    
    % Frame the signal into overlapping frames
    frame_size = 0.025; % 25 ms frame size
    frame_shift = 0.01; % 10 ms frame shift
    frame_length = frame_size * fs; % convert frame size to samples
    frame_step = frame_shift * fs; % convert frame shift to samples
    num_frames = floor((length(audio)-frame_length)/frame_step)+1;
    frames = buffer(audio, floor(frame_length), floor(frame_length-frame_step));
    
    % Compute LPC coefficients and formant frequencies for each frame
    lpc_order = 8; % LPC order
    formant_freqs = zeros(2, num_frames);
    for i = 1:num_frames
        % Compute LPC coefficients
        lpc_coeffs = lpc(frames(:,i), lpc_order);
        % Compute roots of LPC polynomial
        rootss = roots(lpc_coeffs);
        % Find roots with magnitude > 1 (formants)
        rootss = rootss(abs(rootss) > 1);
        % Convert roots to formant frequencies
        formant_freqs(:,i) = sort(angle(rootss)*fs/(2*pi), 'descend');
    end
    
    % Categorize vowels
    vowel_freqs = [700 850; 300 400; 400 500; 500 600; 600 700];
    vowel_categories = {'a', 'i', 'u', 'e', 'o'};
    vowel_predictions = zeros(1, num_frames);
    for i = 1:num_frames
        % Compute distances between formant frequencies and vowel prototypes
        distances = zeros(1, size(vowel_freqs, 1));
        for j = 1:size(vowel_freqs, 1)
            distances(j) = norm(formant_freqs(:,i) - vowel_freqs(j,:));
        end
        % Assign vowel label to the frame with the minimum distance
        [~, vowel_predictions(i)] = min(distances);
    end
    vowel_predictions = vowel_categories(vowel_predictions);

end