function [ exp_md ] = fit ( exp_md )
% This convenience funciton lists the default fitting metadata, and can be
% read by other experiment-specific metadata files.

% Which fittings should be performed on the data:
exp_md.fit.det1.ifdo.m2q_1	= false;% Do we need to perform the first (pure binomial model) fitting
exp_md.fit.det1.ifdo.m2q_2	= false;% Do we need to perform the second (nucleation model) fitting
exp_md.fit.det1.ifdo.m2q_3	= false;% Do we need to perform the third (evaporation model) fitting
exp_md.fit.det1.ifdo.m2q_4	= false;% Do we need to perform the fourth (combined model) fitting
exp_md.fit.det1.ifdo.m2q_4	= false;% Do we need to perform the fourth (combined model) fitting

% Binary cluster fitting procedure
exp_md.fit.det1.m2q.q = [2:12]; % number of units in cluster: q = m+n, with m = 0, 1, 2, .... q and n = q, q-1, ..0; Warning: for model 4, q needs to be uniformly, monotonically increasing with 1 as stepsize.

exp_md.fit.det1.m2q.m.mass 				= 17; % atomic weight of unit m. (in this case NH3)
exp_md.fit.det1.m2q.n.mass 				= 18; % atomic weight of unit n.
exp_md.fit.det1.m2q.H.mass 				= 1; % atomic mass of proton. 

exp_md.fit.det1.m2q.H.nof 					= 0; %  degree of protonation: 0 means no protonation, 2 means two protons.
exp_md.fit.det1.m2q.binsize 			 	= 0.05;% [a.m.u]0.3
exp_md.fit.det1.m2q.range_surplus = 1;% [a.m.u.] The range surplus on low and high borders to be considered in the fit.

% Binary cluster fitting procedure; optimization parameters:
exp_md.fit.det1.m2q.opt.TolX 			= 1E-10; % Tolerance in X
exp_md.fit.det1.m2q.opt.TolFun 		= 1E-11;% Tolerance in function error
exp_md.fit.det1.m2q.opt.MaxFunEvals = 1e5;% Maximum evaluations of the function.
exp_md.fit.det1.m2q.opt.MaxIter 	= 1e5; % Maximum number of iterations.

% fitting parameters for second model.
% Initial guesses
exp_md.fit.det1.m2q.p_nucl_q				= 1; % Initial guess of picking probability to pick monomer m

% fitting parameters for third model.
% Initial guesses
exp_md.fit.det1.m2q.p_evap_q			= 0.5; % Initial guess of evaporation probability to pick monomer m

% fitting parameters for fourth model:
% Initial guesses
exp_md.fit.det1.m2q.p_nucl_q_m		= 0.5; % Initial guess of picking probability to pick monomer m
exp_md.fit.det1.m2q.p_evap_q_m	= 0.5; % Initial guess of evaporating probability to pick monomer m
exp_md.fit.det1.m2q.f_mother 			= 0.1; % Initiak guess of PD fraction that comes from mother clusters.

% allowed deviation from initial guess:
exp_md.fit.det1.m2q.dpeak_height = 0.2 ; % allowed relative difference in peak height.
exp_md.fit.det1.m2q.dp_m_q			= 1;% allowed difference in picking probability

% Binary cluster fitting procedure nr 2;
exp_md.fit.det1.m2q.opt_2.p_m_q_prev = [1 0]; % OPTIONAL: The initial condition at the previous cluster group. 

% Binary cluster fitting procedure nr 2; optimization parameters:
exp_md.fit.det1.m2q.opt_2.TolX 			= 1E-10; % Tolerance in X
exp_md.fit.det1.m2q.opt_2.TolFun 		= 1E-11;% Tolerance in function error
exp_md.fit.det1.m2q.opt_2.MaxFunEvals = 1e5;% Maximum evaluations of the function.
exp_md.fit.det1.m2q.opt_2.MaxIter 	= 1e5; % Maximum number of iterations.


% Binary cluster fitting procedure nr 3; optimization parameters:
exp_md.fit.det1.m2q.opt_3.TolX 			= 1E-10; % Tolerance in X
exp_md.fit.det1.m2q.opt_3.TolFun 		= 1E-11;% Tolerance in function error
exp_md.fit.det1.m2q.opt_3.MaxFunEvals = 1e5;% Maximum evaluations of the function.
exp_md.fit.det1.m2q.opt_3.MaxIter 	= 1e5; % Maximum number of iterations.

% Binary cluster fitting procedure nr 4; optimization parameters:
exp_md.fit.det1.m2q.opt_4.TolX 			= 1E-10; % Tolerance in X
exp_md.fit.det1.m2q.opt_4.TolFun 		= 1E-11;% Tolerance in function error
exp_md.fit.det1.m2q.opt_4.MaxFunEvals = 1e6;% Maximum evaluations of the function.
exp_md.fit.det1.m2q.opt_4.MaxIter 	= 1e5; % Maximum number of iterations.

%% p1 to p2 angle distribution fits:
% Gaussian fit:

exp_md.fit.det1.angle_p_corr_C2.gauss.mu.value  = [90*pi/180, 120*pi/180, 180*pi/180]; %[pi 0.5*pi]; %104*pi/180; % depending on the no. of peaks 
exp_md.fit.det1.angle_p_corr_C2.gauss.mu.isfree = [false false false]; %false; %[true true true]; %
exp_md.fit.det1.angle_p_corr_C2.gauss.mu.min    = [0, 0, 0]; %pi/2;% [pi/2 pi/2];
exp_md.fit.det1.angle_p_corr_C2.gauss.mu.max    = [pi, pi, pi]; %pi/2; %[pi/2 pi/2];


exp_md.fit.det1.angle_p_corr_C2.gauss.sigma.value  = [0.2 0.2 0.2];% 0.2; %
exp_md.fit.det1.angle_p_corr_C2.gauss.sigma.isfree = [true true true]; % true; %
exp_md.fit.det1.angle_p_corr_C2.gauss.sigma.min    = [0.0 0.0 0.0]; %0; %[0.0  0.0]
exp_md.fit.det1.angle_p_corr_C2.gauss.sigma.max    = [0.5, 0.5, 0.5]; %4; %[4.0  4.0]
exp_md.fit.det1.angle_p_corr_C2.gauss.sigma.mode   ='independent'; % 'one width fits all'; %

exp_md.fit.det1.angle_p_corr_C2.gauss.PH.value    = [0.5, 0.8, 1.0]; %1; %;%[0.7 0.7]
exp_md.fit.det1.angle_p_corr_C2.gauss.PH.isfree   = [true true true]; %true; %
exp_md.fit.det1.angle_p_corr_C2.gauss.PH.min      = [0.0 0.0 0.0]; %0; %
exp_md.fit.det1.angle_p_corr_C2.gauss.PH.max      = [[1.0, 1.0, 1.0]]; %1.5; %

exp_md.fit.det1.angle_p_corr_C2.gauss.y_bgr.value  = 0.0;
exp_md.fit.det1.angle_p_corr_C2.gauss.y_bgr.min    = 0;
exp_md.fit.det1.angle_p_corr_C2.gauss.y_bgr.max    = 0.4; %0.1
exp_md.fit.det1.angle_p_corr_C2.gauss.y_bgr.isfree = false; %true; %

exp_md.fit.det1.angle_p_corr_C2.gauss.theta.value			= [0.1 pi-0.01];  %[0 pi];

% optimization parameters:
exp_md.fit.det1.angle_p_corr_C2.gauss.fit_param.TolX 			= 1E-15; %-7 Tolerance in X
exp_md.fit.det1.angle_p_corr_C2.gauss.fit_param.TolFun          = 1E-15;%-10 Tolerance in function error
exp_md.fit.det1.angle_p_corr_C2.gauss.fit_param.MaxFunEvals     = 1e6;% Maximum evaluations of the function.
exp_md.fit.det1.angle_p_corr_C2.gauss.fit_param.MaxIter         = 1e5; % Maximum number of iterations.

exp_md.fit.det1.angle_p_corr_C2.plot                = exp_md.plot.det1.angle_p_corr_C2;

% Triple coincidence:
exp_md.fit.det1.angle_p_corr_C3.gauss = exp_md.fit.det1.angle_p_corr_C2.gauss;

% 
exp_md.fit.det1.angle_p_corr_C3.gauss.mu.value  = [pi/2, 2*pi/3, pi];
exp_md.fit.det1.angle_p_corr_C3.gauss.mu.isfree = [false, false, false];
exp_md.fit.det1.angle_p_corr_C3.gauss.mu.min    = [0, 0, 0];
exp_md.fit.det1.angle_p_corr_C3.gauss.mu.max    = [pi, pi, pi];

exp_md.fit.det1.angle_p_corr_C3.gauss.sigma.value  = [0.2, 0.2, 0.2];
exp_md.fit.det1.angle_p_corr_C3.gauss.sigma.isfree = [true true true];
exp_md.fit.det1.angle_p_corr_C3.gauss.sigma.min    = [0.01, 0.1, 0.01];
exp_md.fit.det1.angle_p_corr_C3.gauss.sigma.max    = [1.5, 1.5, 1.5];
exp_md.fit.det1.angle_p_corr_C3.gauss.sigma.mode   = 'independent'; %'one width fits all';

exp_md.fit.det1.angle_p_corr_C3.gauss.PH.value    = [0.1, 0.7, 0.1];
exp_md.fit.det1.angle_p_corr_C3.gauss.PH.isfree   = [true true true];
exp_md.fit.det1.angle_p_corr_C3.gauss.PH.min      = [0.0 0.2 0.0];
exp_md.fit.det1.angle_p_corr_C3.gauss.PH.max      = [0.5, 1.5, 0.5];

exp_md.fit.det1.angle_p_corr_C3.gauss.y_bgr.value  = 0;
exp_md.fit.det1.angle_p_corr_C3.gauss.y_bgr.min    = 0;
exp_md.fit.det1.angle_p_corr_C3.gauss.y_bgr.max    = 0.4;
exp_md.fit.det1.angle_p_corr_C3.gauss.y_bgr.isfree = false;

exp_md.fit.det1.angle_p_corr_C3.plot                = exp_md.plot.det1.angle_p_corr_C3;


end

