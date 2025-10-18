function plot_group_MVL_comparison(results, odor_idx, electrode_label)
% Plot MVL time-series across subject groups for a given odor and electrode

fig = figure('Visible','off');
hold on;

colors = lines(numel(results));
legend_entries = {};

for s = 1:numel(results)
    odor = results(s).odor(odor_idx);
    for ch = 1:numel(odor.electrode)
        if strcmpi(odor.electrode(ch).label, electrode_label)
            plot(odor.electrode(ch).t_mvl, odor.electrode(ch).mvl_time, ...
                'LineWidth', 1.5, 'Color', colors(s,:));
            legend_entries{end+1} = results(s).subject;
            break;
        end
    end
end

xlabel('Time (s)');
ylabel('Mean Vector Length (MVL)');
title(sprintf('MVL Time Course | Odor: %s | Electrode: %s', ...
    results(1).odor(odor_idx).name, electrode_label));
legend(legend_entries, 'Location', 'best');
grid on;

filename = sprintf('plots/MVL/MVL_group_compare_%s_%s.png', results(1).odor(odor_idx).name, electrode_label);
saveas(fig, filename);
close(fig);
end

