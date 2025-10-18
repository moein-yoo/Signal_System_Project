function compare_group_power(subjects, odors, band)
colors = lines(length(subjects));

for o = 1:length(odors)
    odor = odors{o};
    figure('Position', [100 100 800 400]); hold on;
    
    for s = 1:length(subjects)
        subj = subjects(s);
        file = sprintf('Results/%s_%s_power.mat', subj.name, odor);        
        data = load(file);
        power = data.(band);
        plot(data.time, power, 'DisplayName', subj.label, 'LineWidth', 2, 'Color', colors(s,:));
    end
    
    xline(0, '--k', 'Onset', 'LabelVerticalAlignment', 'top');
    xlabel('t (sec)');
    ylabel(sprintf('Power %s (\\muV^2)', band));
    title(sprintf('Power compare %s - odor %s', band, odor), 'Interpreter', 'none');
    legend('Location', 'best');
    grid on;
    
    if ~exist('Results', 'dir')
        mkdir('Results');
    end
    saveas(gcf, sprintf('Results/Comparison_%s_%s.png', band, odor));
end
end
