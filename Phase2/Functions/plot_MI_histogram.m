function plot_MI_histogram(P, phase_bins, save_path)

fig = figure('Visible','off');
bar(phase_bins, P, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Phase (rad)'); ylabel('Normalized Amplitude');
title('Amplitude Distribution over Theta Phase');
xticks(-pi : pi/2 : pi);
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
grid on;

saveas(fig, save_path);
close(fig);
end
