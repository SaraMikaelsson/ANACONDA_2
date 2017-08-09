function [ ydata ] = size_dep_binomial_peaks(parameters, xdata)
% binomial_peaks.
% This function fits a set of close Gaussian peaks, and thereby assumes a
% binomial distribution (see
% http://hyperphysics.phy-astr.gsu.edu/hbase/math/dice.html#c2)
% Input parameters:
% xdata         [n,1]
% parameters    [first_peak_centre, last_peak_centre, peak_spacing, peak_height, p_A, sigma_G, sigma_L, noise_level]
% Output parameters:
% ydata

%parameters:
mu              = repmat(parameters(1):parameters(3):parameters(2), length(xdata), 1);
q               = size(mu,2) - 1; %q is the number of dice throws
peak_height     = parameters(4);
p_m             = parameters(5);
sigma_G         = parameters(6);% Gaussian standard deviation* ones(length(xdata), q+1);
sigma_L         = parameters(7);% Lorentzian standard deviation
noise_level     = parameters(8);

% calculating ydata:
X               = repmat(xdata, 1, q+1); % the xdata in useful form
YV              = macro.fit.m2q.voigt(X, mu, sigma_G, sigma_L); % Voigt profile
binomial_PDF    = theory.binomial_f(q, 0:q, 1-p_m); % the peaks in binomial distribution
y_norm          = sum(repmat(binomial_PDF, size(xdata,1), 1).*YV,2); % the normalized ydata
ydata           = peak_height./max(y_norm) * y_norm + noise_level; % adding the noise
end