


function [ h_figure, UI ] = conversion( h_figure, pos, h_tabs, tab_calib)

% Radiobuttons: Two buttons for the choice of either electrons or ions 
%                which sets the metadata    
% % calibration button wh
% UI.RadioGroup_CalibType = uibuttongroup('Parent', tab_calib,...
% 'Units', 'normalized', ...
% 'Position', [0.56 0.82 0.4 0.15]);

% UI.Radio_CalibType_Ions = uicontrol('Parent', UI.RadioGroup_CalibType, ...
% 'Style','radiobutton',...
% 'Units', 'normalized',...
% 'Position',[0.5 0 0.5 1],...
% 'FontSize', 11, ...
% 'String','ion');
% 
% UI.Radio_CalibType_Electrons = uicontrol('Parent', UI.RadioGroup_CalibType, ...
% 'Style','radiobutton',...
% 'Units', 'normalized',...
% 'Position',[0 0 0.5 1],...
% 'FontSize', 11, ...
% 'String','electron');

% A listbox which shows the names of the different filter parameters
UI.Fieldname = uicontrol('Parent', tab_calib, ...
'Style', 'list', ...
'Units', 'normalized', ...
'Position', [0.05 0.35 0.55 0.5], ...
'FontSize', 14, ...
'Enable', 'on', ...
'String', 'Parameter', ...
'TooltipString', 'Conversion Variable');

% A listbox which shows the values of the different filter parameters
UI.Fieldvalue = uicontrol('Parent', tab_calib, ...
'Style', 'list', ...
'Units', 'normalized', ...
'Position', [0.55 0.35 0.4 0.5], ...
'FontSize', 14, ...
'Enable', 'on', ...
'String', 'Value', ...
'TooltipString', 'Value of ConversionVariable');

UI.RadioGroupCalib = uibuttongroup('Parent', tab_calib,...
'Units', 'normalized', ...
'Position', [0.05 0.87 0.4 0.10]);
    
UI.RadioCalib_ON = uicontrol('Parent', UI.RadioGroupCalib, ...
'Style','radiobutton',...
'Units', 'normalized',...
'Position',[0.1 0 0.5 1],...
'FontSize', 11, ...
'String','on');

    
UI.RadioCalib_OFF = uicontrol('Parent', UI.RadioGroupCalib, ...
'Style','radiobutton',...
'Units', 'normalized',...
'Position',[0.5 0 0.5 1],...
'FontSize', 11, ...
'String','off');

% UI.PushCalib = uicontrol('Parent', tab_calib, ...
% 'Style', 'pushbutton', ...
% 'Units', 'normalized', ...
% 'Position', [0.25 0.20 0.4 0.10], ...
% 'Enable', 'on', ...
% 'String', 'Calibrate', ...
% 'FontSize', 14, ...
% 'TooltipString', 'Press to calibrate');

end