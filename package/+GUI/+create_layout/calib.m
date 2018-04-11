

function [ h_figure, UIctrl_calib ] = calib( h_figure, pos, h_tabs, tab_calib)
%% Description:
% Input:    h_figure =  figure handle containing information about the main
%                       picture of the environment
%           pos      =  position of the main figure
%           h_tabs   =  all the information about the tabgroup contained in
%                       the GUI
%           tab_calib=  Infos about the calibration tab

%Functions
% % Information about the listbox below
 UIctrl_calib.h_calib_tabs = uitabgroup(tab_calib,'Position',[0 0 1 0.70]);
% TOF2m2q tab
 UIctrl_calib.tab_correction = uitab(UIctrl_calib.h_calib_tabs,'Title','correction');
% Momentum tab:
 UIctrl_calib.tab_conversion = uitab(UIctrl_calib.h_calib_tabs,'Title','conversion');

% %% TOF2m2q calibration
 [h_figure, UIctrl_calib.correction]         = GUI.create_layout.calib.correction(h_figure, pos, UIctrl_calib.h_calib_tabs, UIctrl_calib.tab_correction);
% %% New Plotting:
 [h_figure, UIctrl_calib.conversion]           = GUI.create_layout.calib.conversion(h_figure, pos, UIctrl_calib.h_calib_tabs, UIctrl_calib.tab_conversion);


% A listbox for calibration parameter selection
% 
md_GUI = evalin('base', 'md_GUI');

UIctrl_calib.text_CalibParameter = uicontrol('Parent', tab_calib, ...
'Style','text',...
'Units', 'normalized',...
'FontSize', 12, ...
'Position',[0.02 0.96 0.96 0.03], ...
'String','Select Experiment to calibrate :');

UIctrl_calib.LoadedFilesCalibrating = uicontrol('Parent', tab_calib, ...
'Style', 'listbox', ...
'Units', 'normalized', ...
'Position', [0.02 0.85 0.96 0.10], ...
'FontSize', 14, ...
'Enable', 'on', ...
'String', {''}, ...
'Max',2,'Min',0,...
'TooltipString', 'Select file');

UIctrl_calib.text_detector_modes = uicontrol('Parent', tab_calib, ...
'Style','text',...
'Units', 'normalized',...
'FontSize', 12, ...
'Position',[0.02 0.78 0.30 0.03], ...
'String','Detector mode:');

UIctrl_calib.Popup_DetModes = uicontrol('Parent', tab_calib, ...
'Style', 'popupmenu', ...
'Units', 'normalized', ...
'Position', [0.34 0.77 0.30 0.05], ...
'FontSize', 12, ...
'Enable', 'on', ...
'String', {'-'}, ...
'Max',1,'Min',0);


UIctrl_calib.Push_Calib = uicontrol('Parent', tab_calib, ...
'Style', 'pushbutton', ...
'Enable', 'off', ...
'Units', 'normalized', ...
'Position', [0.67 0.75 0.3 0.08], ...
'String', 'Calibrate', ...
'FontSize', 14, ...
'TooltipString', 'Press to calibrate');

md_GUI.calib.correction.caliblistval= 0;
md_GUI.calib.conversion.caliblistval= 0;
assignin('base', 'md_GUI', md_GUI);
end