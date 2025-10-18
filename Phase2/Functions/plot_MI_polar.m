function plot_MI_polar(P, phase_bins, save_path)
fig = figure('Visible', 'off');
polarplot([phase_bins phase_bins(1)], [P P(1)], '-o', 'LineWidth', 2);
title('Phase-Amplitude Distribution');
rlim([0 max(P) * 1.1]);

saveas(fig, save_path);
close(fig);
end