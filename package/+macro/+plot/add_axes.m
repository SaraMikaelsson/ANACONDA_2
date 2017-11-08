function [ Ax ] = add_axes(Ax_ori, Ax_new, md, axestype, coor)
% This function will add an extra axis to an existing plot axes. It will
% respect the plot range and add the new {m2q, CSD} values of plotted {TOF,
% KER}, respectively
% values.
% Inputs:
% Ax_ori			The original axes
% md			conversion metadata. In case of 'cluster_size as an
%					axestype, this is the sample metadata.
% AxisLocation		(optional) where the plot should be: 'top' or 'bottom'.
%					Default: 'top'
% AxisName			(optional) which ordinate should be added: 'X', 'Y' or 'Z'
% 					Default: 'X'
% axestype			string describing the type of axes that is added. Possible values: 'm2q',
%					'CSD', 'cluster_size'
% coor				(Optional) String representing the coordinate name,
%					e.g. 'X'. Default: all Tick names defined.
% Outputs:
% Ax				The combined axes, original and newly produced overlay axes.

if numel(Ax_ori) > 1 % If the axes is larger, we only take the first element:
	Ax_ori_full		= Ax_ori;
	Ax_ori			= Ax_ori(1);
end

% Copy the orginal over to the new axes:
Ax_new					= general.struct.catstruct(Ax_ori, Ax_new);

if exist('coor', 'var')
	[Ax_new, Ax_ori] = exch_ticks (Ax_new, Ax_ori, md, coor, axestype);
else
	if isfield(Ax_ori, 'XTick')
		[Ax_new, Ax_ori] = exch_ticks (Ax_new, Ax_ori, md, 'X', axestype);
	end
	if isfield(Ax_ori, 'YTick')
		[Ax_new, Ax_ori] = exch_ticks (Ax_new, Ax_ori, md, 'Y', axestype);
	end
	if isfield(Ax_ori, 'ZTick')
		 [Ax_new, Ax_ori] = exch_ticks (Ax_new, Ax_ori, md, 'Z', axestype);
	end
end

if exist('Ax_ori_full', 'var') % If the axes is larger, we merge it again:
	Ax_ori_full(1)	= Ax_ori;
	Ax				= [Ax_ori_full, Ax_new];
else
	% If the added axes misses fields that the original has, we fill those
	% up with the same value of the original axes:
	Ax = [Ax_ori, Ax_new];
end

end

function [Ax_new, Ax_ori] = exch_ticks (Ax_new, Ax_ori, md, cname, axestype)
	switch axestype
		case 'm2q'
			ticklabel					= sort(unique(md.m2q_labels))';
			Ax_new.([cname 'TickLabel'])= strread(num2str(ticklabel),'%s');
			Ax_new.([cname 'Tick'])		= round(unique(convert.m2q_2_TOF(ticklabel, ...
												md.TOF_2_m2q.factor, ...
												md.TOF_2_m2q.t0)));
			Ax_ori.([cname 'Tick'])			= Ax_new.([cname 'Tick']);
			Ax_ori.([cname 'TickLabel'])	= Ax_ori.([cname 'Tick']);
		case 'cluster_size'
			ticklabel					= md.fragment.sizes';
			Ax_new.([cname 'TickLabel'])= strread(num2str(ticklabel),'%s');
			if size(md.fragment.sizes) == size(md.fragment.masses)
				Ax_new.([cname 'Tick'])		= md.fragment.masses;
				Ax_ori.([cname 'Tick'])			= Ax_new.([cname 'Tick']);
			else % Multi-component cluster, we take the pure clusters:
				% Calculate the average fragment mass:
				Ax_new.([cname 'Tick'])		= mean(md.fragment.pure.masses, 2);
				% We do not change the original axes tick.
				Ax_new.grid					= 'off';
				Ax_ori.grid					= 'on';
			end
			Ax_ori.([cname 'TickLabel'])	= Ax_ori.([cname 'Tick']);
			
		case 'CSD'
			Ax_new.([cname 'Tick']) = Ax_ori.([cname 'Tick']);
			KER_ticks = Ax_ori.([cname 'Tick']);
			ticklabel = round(theory.Coulomb.distance(md.eps_m, md.mult*ones(size(KER_ticks)), md.charge, KER_ticks),1);
			Ax_new.([cname 'TickLabel']) = strread(num2str(ticklabel),'%s');
	end
	Ticklabels_rm_Inf = Ax_new.([cname 'TickLabel']);
	try Ticklabels_rm_Inf{cell2mat(strfind(Ticklabels_rm_Inf, 'Inf'))} = '\infty';
	end
	Ax_new.([cname 'TickLabel']) = Ticklabels_rm_Inf;
end