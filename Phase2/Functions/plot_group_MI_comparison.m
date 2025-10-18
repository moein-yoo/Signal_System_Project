function plot_group_MI_comparison(results, odor_idx, electrode_label)
mi_vals = zeros(1, numel(results));
group_names = strings(1, numel(results));

for s = 1:numel(results)
    odor = results(s).odor(odor_idx);
    elecs = odor.electrode;
    for e = 1:numel(elecs)
        if strcmpi(elecs(e).label, electrode_label)
            mi_vals(s) = elecs(e).mi;
            break;
        end
    end
    group_names(s) = results(s).subject;
end

fig = figure('Visible','off');
bar(mi_vals, 'FaceColor', [0.3 0.7 0.4]);
set(gca, 'XTickLabel', group_names, 'XTickLabelRotation', 45);
ylabel('Modulation Index (MI)');
title(sprintf('MI Comparison (%s - %s)', results(1).odor(odor_idx).name, electrode_label));

grid on; box off;
saveas(fig, sprintf('plots/MI/Group_MI_%s_%s.png', results(1).odor(odor_idx).name, electrode_label));
close(fig);
end