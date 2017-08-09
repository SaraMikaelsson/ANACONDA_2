% Description: Unloads the selected file from memory. 
%   - inputs: 
%           Experiment names                    (exp_names)
%           Loaded file number                  (filenumber_selected)
%           Number of loaded files in total     (NumberOfLoadedFiles)
%           Number of loaded files selected     (numberofloadedfilesselected)
%           Names of the loaded files           (String_LoadedFiles)
%           File location + name                (d_fn)
%           File data.                          (data_n)
%           File metadata.                      (mdata_n)
%   - outputs: 
%           Experiment names        (exp_names)
%           Name of loaded files    (String_LoadedFiles)
%           File location + name    (d_fn)
%           File data.              (data_n)
%           File metadata.          (mdata_n)
%           Experiment settings.    (expsettings)
%           Number of loaded files. (NumberOfLoadedFiles)
% Date of creation: 2017-07-10.
% Author: Benjamin Bolling.
% Modification date:
% Modifier:

%% UnLoadFile function
function [ ] = UnLoadFile(UILoad, UIPlot, UIFilter)
md_GUI = evalin('base', 'md_GUI');
UI = md_GUI.UI.UI;
import uiextras.jTree.*
%Get the filenumber of the selected file - if exists.
if isfield(md_GUI.load, 'filenumber_selected')
    LoadedFileNumber = md_GUI.load.filenumber_selected; %multiselection available! -> Cell.
else
    LoadedFileNumber = 1;
end
%check how many files to unload. Now only support of one file to unload
%each time. Upgrade in future may support multi selection unload.
if isfield(md_GUI.load, 'numberofloadedfilesselected')
    numberoffilesselected = md_GUI.load.numberofloadedfilesselected;
else
    numberoffilesselected = 1;
end
%check how many files are loaded in total.
NumberOfLoadedFiles = md_GUI.load.NumberOfLoadedFiles;
%get the strings of the loaded files.
String_LoadedFiles = md_GUI.load.String_LoadedFiles;
if numberoffilesselected == 1
	%unload file.
    disp('Single file chosen - gets unloaded.')
    String_FileToUnload = String_LoadedFiles(LoadedFileNumber)
    % Delete the tree nodes - strange errors found. Temporary solution: 
    % Destroy all nodes and then reconstruct them.
    clear Node
    UI.Tree.Root.Children.delete
    for nn = (LoadedFileNumber + 1):NumberOfLoadedFiles
        filenumber_1 = nn-1;
        filenumber = nn;
        filenumber_1 = int2str(filenumber_1);
        filenumber = int2str(filenumber);
        md_GUI.d_fn.(['exp', filenumber_1]) = md_GUI.d_fn.(['exp', filenumber]);
        String_LoadedFiles(nn-1) = String_LoadedFiles(nn);
        md_GUI.data_n.(['exp', filenumber_1]) = md_GUI.data_n.(['exp', filenumber]);
        md_GUI.mdata_n.(['exp', filenumber_1]) = md_GUI.mdata_n.(['exp', filenumber]);
        md_GUI.load.exp_names(nn-1) = md_GUI.load.exp_names(nn);
    end
    %Remove last field (since all other fields have 'moved up 1 step')
    NumberOfLoadedFiles_str = int2str(NumberOfLoadedFiles);
    for nk = 1:(NumberOfLoadedFiles-1)
       String_LoadedFilesNew(nk) = String_LoadedFiles(nk)
       nkk = int2str(nk);
        data_n_new.(['exp', nkk]) = md_GUI.data_n.(['exp', nkk]);
        mdata_n_new.(['exp', nkk]) = md_GUI.mdata_n.(['exp', nkk]);
        exp_names_new(nk) = md_GUI.load.exp_names(nk);
    end
    % Check if there is more than one loaded files as of now.
    if length(String_LoadedFiles) == 1
        set(UILoad.LoadedFiles, 'Enable', 'off');
        set(UIPlot.LoadedFilesPlotting, 'Enable', 'off');
        set(UIPlot.Popup_experiment_name, 'String', '-');
        set(UIPlot.Popup_experiment_name, 'Value', 1);
        set(UIPlot.Popup_experiment_name, 'Enable', 'off');
        set(UIPlot.Popup_Hits_or_Events, 'String', '-');
        set(UIPlot.Popup_Hits_or_Events, 'Value', 1);
        set(UIPlot.Popup_Hits_or_Events, 'Enable', 'off')
        set(UIPlot.Popup_detector_choice, 'String', '-');
        set(UIPlot.Popup_detector_choice, 'Value', 1);
        set(UIPlot.Popup_detector_choice, 'Enable', 'off')
        set(UIPlot.Popup_plot_dimensions, 'Value', 1);
        set(UIPlot.Popup_plot_dimensions, 'Enable', 'off')
        set(UIPlot.PopupPlotSelected, 'String', '-');
        set(UIPlot.PopupPlotSelected, 'Value', 1);
        set(UIPlot.PopupPlotSelected, 'Enable', 'off')
        set(UIPlot.Popup_graph_type_X, 'String', '-');
        set(UIPlot.Popup_graph_type_X, 'Value', 1);
        set(UIPlot.Popup_graph_type_X, 'Enable', 'off')
        set(UIPlot.Popup_graph_type_Y, 'String', '-');
        set(UIPlot.Popup_graph_type_Y, 'Value', 1);
        set(UIPlot.Popup_graph_type_Y, 'Enable', 'off')
        set(UILoad.LoadedFiles, 'String', '-');
        set(UILoad.LoadedFiles, 'Enable', 'off');
        set(UIPlot.LoadedFilesPlotting, 'String', '-');
        set(UIPlot.LoadedFilesPlotting, 'Enable', 'off');
        set(UIPlot.PlotButton, 'Enable', 'off')
        set(UIPlot.Popup_Filter_Selection, 'Enable', 'off')
        set(UIPlot.Popup_Filter_Selection, 'String', '-')
        set(UIPlot.Popup_Filter_Selection, 'Value', 1)
        md_GUI.load = rmfield(md_GUI.load, 'String_LoadedFiles');
        md_GUI.load.filenumber_selected = 1;
    else
        String_LoadedFiles = String_LoadedFilesNew;
        md_GUI.data_n = data_n_new;
        md_GUI.mdata_n = mdata_n_new;
        md_GUI.load.exp_names = exp_names_new;
        md_GUI.load.String_LoadedFiles = String_LoadedFiles;
        set(UILoad.LoadedFiles, 'Value', 1);
        md_GUI.load.filenumber_selected = 1;
        set(UIPlot.Popup_experiment_name, 'Value', 1);
        set(UIPlot.Popup_experiment_name, 'String', String_LoadedFiles);
        set(UILoad.LoadedFiles, 'String', md_GUI.load.String_LoadedFiles);
        set(UIPlot.LoadedFilesPlotting, 'String', md_GUI.load.String_LoadedFiles);
        set(UILoad.LoadedFiles, 'Value', 1);
        set(UIPlot.LoadedFilesPlotting, 'Value', 1);
        set(UIPlot.Popup_plot_dimensions, 'Value', 1);
        set(UIPlot.Popup_experiment_name, 'Value', 1);
    end
    if NumberOfLoadedFiles > 1
        md_GUI.d_fn = rmfield(md_GUI.d_fn, (['exp', NumberOfLoadedFiles_str]));
    end
    NumberOfLoadedFiles = NumberOfLoadedFiles - 1;
    md_GUI.load.NumberOfLoadedFiles = NumberOfLoadedFiles;
    set(UILoad.LoadedFiles, 'Value', 1);
    set(UIPlot.Popup_experiment_name, 'Enable', 'off');
    set(UIPlot.Popup_experiment_name, 'String', '-');
    % Reconstruct all nodes:
    fileloading = 1;
    assignin('base', 'md_GUI', md_GUI);
    for nn = 1:NumberOfLoadedFiles
        [ UI ] = GUI.filter.Create_layout.FilterTreeList( fileloading, nn );
    end
else
	%Give message that this GUI version supports only one unload per time.
	msgbox('Select one file to unload.', 'Warning')
    disp('Select one file to unload.')
end
end