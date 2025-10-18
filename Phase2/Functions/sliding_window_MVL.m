function [mvl_vec, t_centers] = sliding_window_MVL(theta_phase, gamma_amp, fs, win_len, overlap)
if nargin < 5; overlap = 0.95; end
if nargin < 4; win_len = 1; end

Nwin = round(win_len * fs);
step = round(Nwin * (1 - overlap));
idx  = 1:step:(length(theta_phase) - Nwin + 1);

mvl_vec   = zeros(1, length(idx));
t_centers = zeros(1, length(idx));

for k = 1:length(idx)
    seg = idx(k):(idx(k) + Nwin - 1);
    z = gamma_amp(seg) .* exp(1j * theta_phase(seg));
    mvl_vec(k) = abs(mean(z));
    t_centers(k) = (seg(1) + seg(end)) / (2 * fs);
end
end