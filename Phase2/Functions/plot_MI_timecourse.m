function plot_MI_timecourse(time_vec, mi_vec, save_path)
    figure; 
    plot(time_vec, mi_vec, 'b', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Modulation Index (MI)');
    title('Time-resolved PAC (MI)');
    grid on;
    if nargin > 2
        saveas(gcf, save_path);
        close;
    end
end
