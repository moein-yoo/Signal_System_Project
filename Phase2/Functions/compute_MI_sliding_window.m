function [mi_vec, time_vec, P_mat] = compute_MI_sliding_window(theta_phase, gamma_amp, fs, win_len, overlap, nbins)
    if nargin < 6
        nbins = 18;
    end

    N = round(win_len * fs);
    step = round(N * (1 - overlap));
    nSamples = length(theta_phase);

    nWin = floor((nSamples - N) / step) + 1;

    mi_vec = zeros(1, nWin);
    P_mat = zeros(nWin, nbins);
    time_vec = zeros(1, nWin);

    edges = linspace(-pi, pi, nbins + 1);

    for w = 1:nWin
        idx = (w-1)*step + (1:N);
        phase_win = theta_phase(idx);
        amp_win = gamma_amp(idx);

        P = zeros(1, nbins);
        for b = 1:nbins
            inds = phase_win >= edges(b) & phase_win < edges(b+1);
            if any(inds)
                P(b) = mean(amp_win(inds));
            else
                P(b) = 0;
            end
        end

        P = P + eps;
        P = P / sum(P);
        U = ones(1, nbins) / nbins;
        DKL = sum(P .* log(P ./ U));
        mi_vec(w) = DKL / log(nbins);
        P_mat(w, :) = P;

        time_vec(w) = ((idx(1) + idx(end))/2) / fs; 
    end
end
