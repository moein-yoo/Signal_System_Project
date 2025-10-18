function plot_group_MVL_comparison_avg(results, odor_idx, save_name)
% Plot MVL over time averaged across electrodes for each subject for given odor

figure; hold on;
colors = lines(numel(results));
legend_entries = {};

for s = 1:numel(results)
    odor = results(s).odor(odor_idx);
    
    mvl_matrix = [];
    for ch = 1:numel(odor.electrode)
        mvl_vec = odor.electrode(ch).mvl_time;
        if ~isempty(mvl_vec)
            mvl_matrix(end+1, :) = mvl_vec;
        end
    end

    if ~isempty(mvl_matrix)
        mean_mvl_across_channels = mean(mvl_matrix, 1, 'omitnan');
        t_mvl = odor.electrode(1).t_mvl;
        
        plot(t_mvl, mean_mvl_across_channels, 'LineWidth', 1.8, 'Color', colors(s,:));
        legend_entries{end+1} = results(s).subject;

        results(s).odor(odor_idx).mean_mvl_all_channels_time = mean_mvl_across_channels;
    end
end

xlabel('Time (s)');
ylabel('MVL (mean across channels)');
title(['MVL comparison - Odor: ', results(1).odor(odor_idx).name]);
legend(legend_entries, 'Location', 'best');
grid on;

saveas(gcf, "plots/MVL_GroupComparison_" + results(1).odor(odor_idx).name + "_" + save_name + ".png");
close;
end
