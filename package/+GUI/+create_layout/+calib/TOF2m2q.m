




function [ h_figure, UI ] = TOF2m2q( h_figure, pos, h_tabs, tab_calib)

% Two buttons initiating the calibration of either electrons or ions


% A radiobutton group container
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

UI.Push_CalibControl = uicontrol('Parent', tab_calib, ...
'Style','pushbutton',...
'Units', 'normalized',...
'Position',[0.05 0.86 0.40 0.06],...
'FontSize', 11, ...
'String','Calibrate');

UI.Text_ExpectedMass               = uicontrol('Parent', tab_calib, ...
'Style','text',...
'Units', 'normalized',...
'Position',[0.02 0.74 0.2 0.08],...
'FontSize', 11, ...
'String','Expected Mass');

UI.Edit_ExpectedMass               = uicontrol('Parent', tab_calib, ...
'Style','edit',...
'Units', 'normalized',...
'Position',[0.25 0.75 0.2 0.05],...
'FontSize', 11, ...
'String',{'4'}, ...
'Enable', 'on', ...
'horizontalalign','center');
% One should add a window where the user can write the number of peaks 
% identified as well as the expected masses for the ion
% For the electrons, as this is sample independent, it will be located in
% the metadata
end