function EEG = load_and_preprocess_eeg(filepath)
    filepath1 = fullfile([filepath, 'epochs.set']);
    EEG = pop_loadset('filename', filepath1);
    n_epochs = size(EEG.data, 3);
    epoch_rms = zeros(1, n_epochs);
    for i = 1:n_epochs
        epoch_rms(i) = rms(reshape(EEG.data(:, :, i), 1, []));
    end
    z_scores = (epoch_rms - mean(epoch_rms)) / std(epoch_rms);
    bad_epochs = find(abs(z_scores) > 3.5);
    filepath = fullfile([filepath, 'trial.set']);
    EEG = pop_select(EEG, 'notrial', bad_epochs);
    pop_saveset(EEG, 'filename', filepath);
end