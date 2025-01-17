function [ exp ] = load_mat(event_path, electrons_path, ions_path)
%This function loads custom COBOLD PC ASCII files (that are already
%converted to MAT files) and converts them to the ANA2 format.
% Inputs:
% event_path		The path (directory) where the events file can be found
% electrons_path	The path (directory) where the electrons file can be found
% ions_path			The path (directory) where the ions file can be found
% Outputs:
% exp				The data struct.
%
% electrons_path	The path (directory) where the electrons file can be found
%
% Written by Bart Oostenrijk, 2018, Lund university: Bart.oostenrijk(at)sljus.lu.se

% read the event ID datafile:
events	= load(event_path); % read the events
el		= load(electrons_path);	% read the electron datafile
ion		= load(ions_path);	% read the ion datafile

% Initialize an empty event pointer array:
% make sure the correlation between detector numbers and ions is correct:
% We do this by verifying the number of hits on each detector:
% we will place electrons on detector 1, ions on detector 2:
if abs(size(el.d.Var1, 1)-max(events.d.Var3+1)) < abs(size(el.d.Var1, 1)-max(events.d.Var4+1))
	% the first detector in the event index is the electron detector:
	exp.e.raw = [events.d.Var3+1 events.d.Var4+1];
else
	% the first detector in the event index is the ion detector:
	exp.e.raw = [events.d.Var4+1 events.d.Var3+1];
end
	
	

% Fill in electron data: (format [x, y, TOF])
try
	exp.h.det1.raw = [el.d.Var1 el.d.Var2 el.d.Var3];
catch
	exp.h.det1.raw = double.empty(0, 3);
end

% Fill in ion data: (format [x, y, TOF])
try 
	exp.h.det2.raw = [ion.d.Var1 ion.d.Var2 ion.d.Var3];
catch
	exp.h.det2.raw = double.empty(0, 3);
end