function plot_power_comparison(time, theta, gamma, subject_name, odor_type)
if ~exist('Results', 'dir')
    mkdir('Results');
end
figure('Position', [100 100 800 400]);
plot(time, theta, 'b', 'LineWidth', 2); hold on;
plot(time, gamma, 'r', 'LineWidth', 2);
xline(0, '--k', 'Onset', 'LabelVerticalAlignment', 'top');
xlabel('t(sec)');
ylabel('Power (\mu V^2)');
title(sprintf('%s - %s', subject_name, odor_type), 'Interpreter', 'none');
legend('theta (4-8 Hz)','Ghama (30-50 Hz)');
grid on;

filename_base = sprintf('Results/%s%s_power', subject_name, odor_type);
saveas(gcf, [filename_base '.png']);
save([filename_base '.mat'], 'theta', 'gamma', 'time');
end
