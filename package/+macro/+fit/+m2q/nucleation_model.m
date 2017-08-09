function [ ydata ] = nucleation_model ( parameters, xdata )
% This function projects a smaller cluster group spectrum onto a cluster
% group one 'q' higher.

% We fetch the relative peak heights of the previous cluster group:
%parameters:
% mu              = repmat(parameters(end-6):parameters(end-4):parameters(end-5), length(xdata), 1);
centers         = linspace(parameters(end-6), parameters(end-5), round((parameters(end-5)-parameters(end-6)+parameters(end-4))./parameters(end-4)));
mu              = repmat(centers,  length(xdata), 1);
q               = size(mu,2) - 1; %q is the number of dice throws
peak_height     = parameters(end-3);
sigma_G         = parameters(end-2);% Gaussian standard deviation* ones(length(xdata), q+1);
sigma_L         = parameters(end-1);% Lorentzian standard deviation
noise_level     = parameters(end);
rph_prev        = parameters(2:q+1); % The relative peak height.
p_nucl_q           = parameters(1);

% The previous group fit is written as the new spectrum by using the probability p_m_q:
rph = [p_nucl_q*rph_prev 0] + [0 (1-p_nucl_q)*rph_prev];


% These are written as the new spectrum by using the probability p_m_q:

% calculating ydata:
X               = repmat(xdata, 1, q+1); % the xdata in useful form
YV              = theory.function.voigt(X, mu, sigma_G, sigma_L); % Voigt profile
PDF             = rph;% the peaks in binomial distribution
y_norm          = sum(repmat(PDF, size(xdata,1), 1).*YV,2); % the normalized ydata
ydata           = peak_height./max(y_norm) * y_norm + noise_level; % adding the noise
end

