% Description: Layout for the new plot configurations tab
% Subtab of the plot tab.
%   - inputs: 
%           Main graphical objects, incl. main figure of the GUI.
%   - outputs: 
%           User interface (UI) graphical objects for the new plot tab.
% Date of creation: 2017-01-04
% Author: Benjamin Bolling
% Modification date:
% Modifier:

function [ h_figure, UI ] = new_plot( h_figure, pos, h_tabs, tab_plot)

% Just a button with no callback - only for design reasons.
UI.BackgroundBox =uicontrol('Parent', tab_plot, ...
'Style', 'pushbutton', ...
'Enable', 'off', ...
'Units', 'normalized',...
'FontSize', 14, ...
'BackgroundColor', [0.935 0.935 0.935], ...
'Position',[0.005 0.12 0.99 0.88],...
'Enable', 'off', ...
'String', '', ...
'TooltipString', '');

% A textbox
UI.SignalSettings_Text = uicontrol('Parent', tab_plot, ...
'Style','text',...
'Units', 'normalized',...
'Position',[0.02 0.91 0.96 0.06],...
'FontSize', 14, ...
'HorizontalAlignment', 'left', ...
'String','Signal settings');

% A textbox
UI.x_text = uicontrol('Parent', tab_plot, ...
'Style','text',...
'Units', 'normalized',...
'Position',[0.51 0.84 0.47 0.06],...
'FontSize', 14, ...
'HorizontalAlignment', 'center', ...
'String','X (Ordinate)');

% A checkbox to enable or disable the y-signal pointer
UI.y_signals_checkbox = uicontrol('Parent', tab_plot, ...
'Style','checkbox',...
'Units', 'normalized',...
'Position',[0.51 0.62 0.47 0.06],...
'FontSize', 14, ...
'HorizontalAlignment', 'center', ...
'Enable', 'off',...
'String','Y (Abscissa)');

% List of signal pointers
UI.signals_list = uicontrol('Parent', tab_plot, ...
'Style','list',...
'Units', 'normalized',...
'Position',[0.02 0.23 0.47 0.67],...
'FontSize', 14, ...
'HorizontalAlignment', 'center', ...
'Enable', 'off',...
'String','-');

% X-signal pointer
UI.x_signal_pointer = uicontrol('Parent', tab_plot, ...
'Style','text',...
'Units', 'normalized',...
'Position',[0.65 0.72 0.33 0.1],...
'FontSize', 16, ...
'HorizontalAlignment', 'left', ...
'String','-');

% Y-signal pointer
UI.y_signal_pointer = uicontrol('Parent', tab_plot, ...
'Style','text',...
'Units', 'normalized',...
'Position',[0.65 0.5 0.33 0.1],...
'FontSize', 16, ...
'HorizontalAlignment', 'left', ...
'String','-');

% A button which sets the selected signal as the X-signal pointer
UI.btn_set_x_sign_pointer = uicontrol('Parent', tab_plot, ...
'Style','pushbutton',...
'Units', 'normalized',...
'Position',[0.51 0.72 0.1 0.1],...
'FontSize', 16, ...
'HorizontalAlignment', 'center', ...
'Enable', 'off',...
'String','>');

% A button which sets the selected signal as the Y-signal pointer
UI.btn_set_y_sign_pointer = uicontrol('Parent', tab_plot, ...
'Style','pushbutton',...
'Units', 'normalized',...
'Position',[0.51 0.5 0.1 0.1],...
'FontSize', 14, ...
'HorizontalAlignment', 'center', ...
'Enable', 'off',...
'String','>');

% A button which saves the plot configuration
UI.save_plot_conf = uicontrol('Parent', tab_plot, ...
'Style','pushbutton',...
'Units', 'normalized',...
'Position',[0.51 0.32 0.47 0.08],...
'FontSize', 14, ...
'HorizontalAlignment', 'center', ...
'Enable', 'off',...
'String','Save plot...');

% A button which opens the plot configurations for editing
UI.edit_plot_conf = uicontrol('Parent', tab_plot, ...
'Style','pushbutton',...
'Units', 'normalized',...
'Position',[0.51 0.23 0.47 0.08],...
'FontSize', 14, ...
'HorizontalAlignment', 'center', ...
'Enable', 'off',...
'String','Edit...');

% A button which plots the selected experiments with the selected plot
% configuration
UI.PlotButton = uicontrol('Parent', tab_plot, ...
'Style', 'pushbutton', ...
'Units', 'normalized',...
'FontSize', 14, ...
'Position',[0.01 0.01 0.98 0.1],...
'Enable', 'off', ...
'String', 'Plot', ...
'TooltipString', 'Press to plot');

end