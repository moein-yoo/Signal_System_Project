function plot_MVL_timecourse(t_mv, mvl_vec, save_path)
fig = figure('Visible','off');
plot(t_mv, mvl_vec, 'b', 'LineWidth', 2);
xlabel('Time (s)'); ylabel('MVL');
title(sprintf('MVL over Time'));
grid on; axis tight;

saveas(fig, save_path);
close(fig);
end
