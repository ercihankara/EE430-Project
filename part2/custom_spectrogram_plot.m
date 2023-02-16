% Beste Öztop - 2375624
% Ercihan Kara - 2375160
% code to plot spectrogram:
% spectrogram is a color or grey scale plot of the magnitude of the short-time Fourier transform (STFT) on the time-frequency plane.
% the STFT of a signal is computed by sliding an analysis window g(n) of
% length M over the signal and calculating the discrete Fourier transform (DFT) of each segment of windowed data.

function custom_spectrogram_plot(time, freq, mag_stft)

%surf(time, freq, mag_stft, 'EdgeColor', 'none');
%axis xy; axis tight; colormap(jet); view(0,90);
s = pcolor(time, freq, mag_stft);
s.FaceColor = 'interp';
shading flat;
c = colorbar;
c.Label.String = 'Power/Frequency (dB/Hz)';

end
