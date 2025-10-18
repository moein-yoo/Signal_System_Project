
function main_PAC_analysis()

%% --------------------- Setup ---------------------

%addpath(genpath('eeglab'));   % path to EEGLAB
%addpath(genpath('.'));        % current folder
addpath 'C:\Users\moien\Desktop\Signal System Proj\eeglab2025.0.0'
eeglab; % Launch EEGLAB
addpath 'C:\Users\moien\Desktop\Signal System Proj2\Functions'
if ~exist('plots', 'dir')
    mkdir('plots');
end


subj_files  = {'PreProcessed/Healthy/Healthy_data_ICA_rem_trial.set', 'PreProcessed/MCI/MCI_data_ICA_rem_trial.set', 'PreProcessed/Mild/Mild_data_ICA_rem_trial.set'};
subj_labels = {'Healthy','MCI','Mild'};
odor_tags   = [5 6];
odor_names  = {'Chocolate','Rose'};
channels_of_interest =  {'C4','P3','F8','Fp2','O1','Fz','Pz','Fp1','F7','F3','F4','C3','Cz','T3','P4','T4','T5','O2','T6'};

fs_target = 256;
win_len   = 1;        % seconds
overlap   = 0.95;
nbins_MI  = 18;
target_epoch = [-2 5]; % seconds

% Create plot directory
if ~exist('plots', 'dir'); mkdir('plots'); end

theta_band = [4 8];
gamma_band = [30 50];
method     = 'hilbert';

%% --------------------- Analysis ---------------------
results = struct();

for s = 1:numel(subj_files)
    EEG = pop_loadset('filename', subj_files{s});
    if EEG.srate ~= fs_target
        EEG = pop_resample(EEG, fs_target);
    end
    fs = EEG.srate;

    for o = 1:numel(odor_tags)
        tag = odor_tags(o);
        EEG_epo = pop_epoch(EEG, {num2str(tag)}, target_epoch);
        EEG_epo = pop_rmbase(EEG_epo, [1000*target_epoch(1) 0]);

        data = EEG_epo.data; % nCh x nSamples x nTrials
        nTr = size(data, 3);

        for ch = 1:length(channels_of_interest)

            ch_idx = find(strcmpi({EEG.chanlocs.labels}, channels_of_interest{ch}));
            if isempty(ch_idx); continue; end

            % Initialize containers
            [mvl_trials, mi_trials, P_trials] = deal([]);
            for tr = 1:nTr
                sig = double(data(ch_idx,:,tr));
                [theta_phase, gamma_amp] = extract_phase_amplitude(sig, fs, method, theta_band, gamma_band);
                [mi_time_vec, t_vec, P_time] = compute_MI_sliding_window(theta_phase, gamma_amp, fs, win_len, overlap, nbins_MI);
                [mvl_vec, t_mv] = sliding_window_MVL(theta_phase, gamma_amp, fs, win_len, overlap);
                [mi_val, P, phase_bins] = compute_MI(theta_phase, gamma_amp, nbins_MI);

                mvl_trials(tr,:) = mvl_vec;
                %mi_trials(tr,:) = compute_MI(theta_phase, gamma_amp, nbins_MI);
                mi_trials(tr) = mi_val;
                mi_time_trials(tr,:) = mi_time_vec; 
                P_trials(tr,:) = P;


            end

            % Average across epochs
            mean_mvl = mean(mvl_trials, 1, 'omitnan');
            mean_mi  = mean(mi_trials, 'omitnan');
            mean_P   = mean(P_trials, 1, 'omitnan');

            mean_mi_time = mean(mi_time_trials, 1, 'omitnan');
            % Save
            results(s).subject = subj_labels{s};
            results(s).odor(o).name = odor_names{o};
            results(s).odor(o).electrode(ch).label = channels_of_interest{ch};
            results(s).odor(o).electrode(ch).t_mvl = t_mv;
            results(s).odor(o).electrode(ch).mvl_time = mean_mvl;
            results(s).odor(o).electrode(ch).mi = mean_mi;
            results(s).odor(o).electrode(ch).P_phase = mean_P;
            results(s).odor(o).electrode(ch).phase_bins = phase_bins;
            
            results(s).odor(o).electrode(ch).mi_time = mean_mi_time;
            results(s).odor(o).electrode(ch).t_mi = t_vec;


            % Save plots
            if (ch>5) 
                continue;
            end

            base = sprintf('plots/%s/%s_%s', subj_labels{s}, odor_names{o}, channels_of_interest{ch});
            plot_MI_polar(mean_P, phase_bins, base + "_polar.png");
            plot_MVL_timecourse(t_mv, mean_mvl, base + "_MVL_timecourse.png");
            plot_MI_histogram(mean_P, phase_bins, base + "_amplitudeHist.png");
        end
        avg_mvl_epochs = mean(mvl_trials, 'all', 'omitnan');
        results(s).odor(o).electrode(ch).avg_mvl_epochs = avg_mvl_epochs;
        all_avg_mvl = [results(s).odor(o).electrode.avg_mvl_epochs];
        final_avg_mvl_all_channels = mean(all_avg_mvl, 'omitnan');
        
        all_avg_mi = [results(s).odor(o).electrode.mi];
        final_avg_mi_all_channels = mean(all_avg_mi, 'omitnan');
        
        all_avg_mi_time = [];
        all_t_mi = [];
        for ch = 1:length(results(s).odor(o).electrode)
            all_avg_mi_time(ch, :) = results(s).odor(o).electrode(ch).mi_time;
            all_t_mi = results(s).odor(o).electrode(ch).t_mi; 
        end
        final_avg_mi_time = mean(all_avg_mi_time, 1, 'omitnan');
        
        results(s).odor(o).avg_mvl_all_channels = final_avg_mvl_all_channels;
        results(s).odor(o).avg_mi_all_channels = final_avg_mi_all_channels;
        results(s).odor(o).avg_mi_time_all_channels = final_avg_mi_time;
        results(s).odor(o).t_mi_all_channels = all_t_mi;


    end
    base = sprintf('plots/%s/', subj_labels{s});
    plot_MI_timecourse(t_vec, mean_mi_time, base + "MI_timecourse.png");
end

save('PAC_all_subjects.mat', 'results');

% Group comparison
electrodes_to_plot = {'Fz','Pz','Fp1','Fp2'};
for odor_idx = 1:2
    for e = 1:length(electrodes_to_plot)
        el = electrodes_to_plot{e};
        plot_group_MI_comparison(results, odor_idx, el);
        plot_group_MVL_comparison(results, odor_idx, el);
    end
    plot_group_MVL_comparison_avg(results, odor_idx, odor_names(odor_idx));
    plot_group_MI_comparison_avg(results, odor_idx, odor_names(odor_idx));
end

fprintf("\nPAC analysis complete. Results saved.\n");
end
