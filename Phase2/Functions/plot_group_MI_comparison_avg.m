function plot_group_MI_comparison_avg(results, odor_idx, save_name)
% Plot MI over time averaged across electrodes for each subject for given odor

figure; hold on;
colors = lines(numel(results));
legend_entries = {};

for s = 1:numel(results)
    odor = results(s).odor(odor_idx);
    
    mi_matrix = [];
    for ch = 1:numel(odor.electrode)
        if isfield(odor.electrode(ch), 'mi_time') && ~isempty(odor.electrode(ch).mi_time)
            mi_vec = odor.electrode(ch).mi_time;
            mi_matrix(end+1, :) = mi_vec;
        end
    end

    if ~isempty(mi_matrix)
        mean_mi_across_channels = mean(mi_matrix, 1, 'omitnan');
        t_mi = odor.electrode(1).t_mi; 

        plot(t_mi, mean_mi_across_channels, 'LineWidth', 1.8, 'Color', colors(s,:));
        legend_entries{end+1} = results(s).subject;

        results(s).odor(odor_idx).mean_mi_all_channels_time = mean_mi_across_channels;
    end
end

xlabel('Time (s)');
ylabel('MI (mean across channels)');
title(['MI comparison - Odor: ', results(1).odor(odor_idx).name]);
legend(legend_entries, 'Location', 'best');
grid on;

if ~exist('plots', 'dir')
    mkdir('plots');
end
saveas(gcf, "plots/MI_GroupComparison_" + results(1).odor(odor_idx).name + "_" + save_name + ".png");
close;
end
