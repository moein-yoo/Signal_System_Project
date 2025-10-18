function [theta_mean, gamma_mean, time] = compute_power_stft(EEG, chan_name, varargin)
params = inputParser;
addParameter(params, 'window', 0.9, @isnumeric);
addParameter(params, 'overlap', 0.9, @isnumeric);
parse(params, varargin{:});

fs = EEG.srate;
win_samples = round(params.Results.window * fs);
noverlap = round(params.Results.overlap * win_samples);

chan_idx = find(strcmp({EEG.chanlocs.labels}, chan_name));
n_epochs = size(EEG.data, 3);

theta_all = [];
gamma_all = [];

for ep = 1:n_epochs
    signal = EEG.data(chan_idx, :, ep);
    [S, f, t] = spectrogram(signal, win_samples, noverlap, [], fs);
    P = abs(S).^2;
    theta_idx = (f >= 4) & (f <= 8);
    gamma_idx = (f >= 30) & (f <= 50);
    theta_all = [theta_all; mean(P(theta_idx, :), 1)];
    gamma_all = [gamma_all; mean(P(gamma_idx, :), 1)];
end

theta_mean = mean(theta_all, 1);
gamma_mean = mean(gamma_all, 1);
time = t + EEG.xmin;
end
