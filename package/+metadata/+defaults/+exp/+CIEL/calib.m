function [ exp_md ] = calib ( exp_md )
% This convenience funciton lists the default correction metadata, and can be
% read by other experiment-specific metadata files.

%% Preparation: We define the signals:
%%%%%% TOF:
signals_i.TOF.hist.pointer	= 'h.det2.raw(:,3)';% Data pointer, where the signal can be found. 
% Histogram metadata:
signals_i.TOF.hist.binsize	= 1;% [ns] binsize of the variable. 
signals_i.TOF.hist.Range	= [0 2.5e4];% [ns] range of the variable. 
% Axes metadata:
signals_i.TOF.axes.Lim		= signals_i.TOF.hist.Range;% [ns] Lim of the axis that shows the variable. 
signals_i.TOF.axes.Tick		= 0:1e3:1e5;% [ns] Tick of the axis that shows the variable.
signals_i.TOF.axes.Label.String	= 'TOF [ns]'; %The label of the variable

%%%%%% Mass-to-charge:
% Histogram metadata:
signals_i.m2q.hist.binsize	= 0.5;% [Da] binsize of the variable. 
signals_i.m2q.hist.Range	= [1 400];% [Da] range of the variable. 
% Axes metadata:
signals_i.m2q.axes.Lim		= [0 100];% [Da] Lim of the axis that shows the variable. 
signals_i.m2q.axes.Tick	= exp_md.sample.fragment.masses; % [Da] Tick of the axis that shows the variable. 
signals_i.m2q.axes.Label.String	= 'm/q [Da]'; %The label of the variable

%%%%%% Momentum:
p_Lim				= [-1 1]*1e2;% [au] range of the variable. 
p_binsize			= 3e0; % [au] binsize of the variable. 

signals_e.px.hist.pointer	= 'h.det1.dp(,1)';% Data pointer, where the signal can be found. 
% Histogram metadata:
signals_e.px.hist.binsize	= p_binsize;% [a.u.] binsize of the variable. 
signals_e.px.hist.Range		= p_Lim;
% Axes metadata:
signals_e.px.axes.Lim	= signals_e.px.hist.Range;% [au] Lim of the axis that shows the variable. 
signals_e.px.axes.Tick	= hist.bins(p_Lim, 30);% [au] Ticks on the respective axes.
signals_e.px.axes.Label.String	= {'$p_x$ [a.u.]'}; %The label of the variable

[signals_e.py, signals_e.pz, signals_e.pnorm] = deal(signals_e.px, signals_e.px, signals_e.px);
[signals_e.py.hist.pointer, signals_e.pz.hist.pointer, signals_e.pnorm.hist.pointer]				= deal('h.det1.dp(:,2)', 'h.det1.dp(:,3)', 'h.det1.p_norm');
[signals_e.py.axes.Label.String, signals_e.pz.axes.Label.String, signals_e.pnorm.axes.Label.String]	= deal({'$p_y$ [a.u.]'}, {'$p_z$ [a.u.]'}, {'$|p|$ [a.u.]'});

% The calibration procedure requires parameters.

cd1.R_circle.isplotted			= true ;% Should the calibration procedure be visual (show plot)
cd1.R_circle.ROI					= [26 32];% [mm] the regions of interest to find the peaks. The first row defines the ROI that is used as global scaling.
cd1.R_circle.filter_width		= 1; %[mm] width of the median filter applied before maximum finding.
cd1.R_circle.plot.hist.binsize       = [0.1 0.05]; %[rad, mm] binsize of the m2q variable. 
cd1.R_circle.plot.hist.Range		= [-pi pi; 20 35]; % [rad, mm] x,y range of the data on y-axis.
cd1.R_circle.plot.axes.XLabel		= '$\theta$ [rad]'; % label on x-axis.
cd1.R_circle.plot.axes.YLabel		= 'R [mm]'; % label on y-axis.
cd1.R_circle.plot.axes.colormap		= plot.custom_RGB_colormap(); % type of colormap
cd1.R_circle.plot.axes.hold			= 'on'; % type of colormap
cd1.R_circle.plot.axes.Type			= 'axes';

%% Define the calibration metadata:

% TOF to m2q conversion
cd2.TOF_2_m2q.TOF							= metadata.create.plot.signal_2_plot({signals_i.TOF});
cd2.TOF_2_m2q.TOF.hist.Integrated_value	= 1;
cd2.TOF_2_m2q.m2q							= metadata.create.plot.signal_2_plot({signals_i.m2q});
cd2.TOF_2_m2q.findpeak.search_radius		= 10;% [ns] The search radius around the indicated point, where the algorithm will look for a peak.
cd2.TOF_2_m2q.findpeak.binsize				= 0.05;% [ns] The search radius around the indicated point, where the algorithm will look for a peak.
% 
cd2.momentum.hist.binsize       = [1, 1]*5e0; %[a.u.] binsize of the m2q variable. 
cd2.momentum.hist.Range			= [-1 1]*3e2; % [a.u.] x range of the data on x-axis.
cd2.momentum.hist.pointer		= 'h.det1.raw';

% Plot style for 2D momentum histogram:
cd2.momentum.labels_to_show = exp_md.sample.fragment.masses;%(3:end);%general.fragment_masses(exp_md.sample.constituent.masses, exp_md.sample.constituent.nof); 
cd2.momentum.binsize       	= [1, 1]*4e0; %[a.u.] binsize of the m2q variable. 
cd2.momentum.x_range		= [-1 1]*1e2; % [a.u.] x range of the data on x-axis.
cd2.momentum.y_range		= [-1 1]*1e2; % [a.u.] y range of the data on y-axis.

exp_md.calib.det1 = cd1;
exp_md.calib.det2 = cd2;
end

