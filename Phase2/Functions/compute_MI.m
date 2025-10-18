function [mi, P, phase_bins] = compute_MI(theta_phase, gamma_amp, nbins)
if nargin < 3; nbins = 18; end

% Define phase bin edges and centers
edges = linspace(-pi, pi, nbins + 1);
phase_bins = edges(1:end-1) + diff(edges)/2;

% Bin amplitudes according to phase
P = zeros(1, nbins);
for b = 1:nbins
    idx = theta_phase >= edges(b) & theta_phase < edges(b+1);
    P(b) = mean(gamma_amp(idx));
end
P = P + eps;
P = P / sum(P);
U = ones(1, nbins) / nbins;

% Compute Modulation Index (KL divergence)
DKL = sum(P .* log(P ./ U));
mi = DKL / log(nbins);
end