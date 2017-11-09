function open_Variables ()
% This function opens up the variables reader to view the plotting
% configuration.
md_GUI = evalin('base', 'md_GUI');
plottype = char(md_GUI.UI.UIPlot.def.Popup_plot_type.String(md_GUI.UI.UIPlot.def.Popup_plot_type.Value));
typesplit = strsplit(plottype, '.');
plottype = char(typesplit(2));
% fetch all the current names:
for ll = 1:length(md_GUI.UI.UIPlot.LoadedFilesPlotting.Value)
    exp_name(ll) = cellstr(['exp', num2str(md_GUI.UI.UIPlot.LoadedFilesPlotting.Value(ll))]);
    det_name(ll) = cellstr(['det' num2str(find(strcmp(char(typesplit(1)), md_GUI.mdata_n.(char(exp_name(ll))).spec.det_modes)))]);
    confname(ll) = cellstr(['md_GUI.mdata_n.' char(exp_name(ll)) '.plot.' char(det_name(ll)) '.' plottype]);
    openvar(char(confname(ll)))
end
end