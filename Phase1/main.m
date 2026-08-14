% Phase 1: olfactory-evoked theta/gamma power analysis.
project_dir = fileparts(mfilename('fullpath'));
cd(project_dir);
addpath(fullfile(project_dir, 'Functions'));

if exist('eeglab', 'file') ~= 2
    error(['EEGLAB was not found on the MATLAB path. Install EEGLAB and ', ...
           'add its directory to the path before running this script.']);
end
eeglab;

subjects = {'Healthy/Healthy_data_ICA_rem_', ...
            'MCI/MCI_data_ICA_rem_', ...
            'Mild/Mild_data_ICA_rem_'};
odors = {'Chocolate', 'Rose'};

for s = 1:length(subjects)
    eeg_file = sprintf('PreProcessed/%s', subjects{s});
    EEG = load_and_preprocess_eeg(eeg_file);

    for o = 1:length(odors)
        tag = sprintf('%d', o + 4);
        EEG_odor = pop_selectevent(EEG, 'type', tag);

        [theta, gamma, time] = compute_power_stft(EEG_odor, 'Cz', 'window', 0.5);

        [~, subject_name] = fileparts(subjects{s});
        subject_name = erase(subject_name, '_data_ICA_trial');
        plot_power_comparison(time, theta, gamma, subject_name, odors{o});
    end
end

group_info = [ ...
    struct('name', 'Healthy_data_ICA_rem', 'label', 'Healthy'), ...
    struct('name', 'MCI_data_ICA_rem', 'label', 'MCI'), ...
    struct('name', 'Mild_data_ICA_rem', 'label', 'Mild') ...
];

compare_group_power(group_info, odors, 'theta');
compare_group_power(group_info, odors, 'gamma');
