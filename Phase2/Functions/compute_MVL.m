function mvl = compute_MVL(theta_phase, gamma_amp)
%COMPUTE_MVL  Mean Vector Length PAC metric (single window)
%   mvl = |mean( gamma_amp .* exp(1j*theta_phase) )|

z   = gamma_amp .* exp(1j*theta_phase);
mvl = abs( mean(z) );
end
