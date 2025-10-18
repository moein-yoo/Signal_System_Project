function [theta_phase, gamma_amp] = extract_phase_amplitude(eeg, fs, method, theta_band, gamma_band)
if nargin < 5 || isempty(gamma_band); gamma_band = [30 50]; end
if nargin < 4 || isempty(theta_band); theta_band = [4 8]; end
if nargin < 3 || isempty(method); method = 'hilbert'; end

% Bandpass filter design
theta_filt = designfilt('bandpassiir','FilterOrder',4, ...
    'HalfPowerFrequency1',theta_band(1),'HalfPowerFrequency2',theta_band(2), ...
    'SampleRate',fs);
gamma_filt = designfilt('bandpassiir','FilterOrder',4, ...
    'HalfPowerFrequency1',gamma_band(1),'HalfPowerFrequency2',gamma_band(2), ...
    'SampleRate',fs);

% Filter signals
eeg_theta = filtfilt(theta_filt, eeg);
eeg_gamma = filtfilt(gamma_filt, eeg);

switch lower(method)
    case 'hilbert'
        theta_phase = angle(hilbert(eeg_theta));
        gamma_amp   = abs(hilbert(eeg_gamma));
    case 'wavelet'
        % Placeholder for optional wavelet-based implementation
        error('Wavelet method not implemented yet. Use "hilbert".');
    otherwise
        error('Unknown method. Use "hilbert" or "wavelet".');
end
end
