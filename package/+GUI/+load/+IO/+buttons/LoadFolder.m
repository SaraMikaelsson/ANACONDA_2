% Description: Loads the filecontent of the selected folder. 
%   - inputs: None.
%   - outputs: 
%           Folder name             (folder_name)
%           List of files in folder (String_ListOfFilesInFolder)
% Date of creation: 2017-07-18.
% Author: Benjamin Bolling.
% Modification date:
% Modifier:

%% Loadfolder function
function [ ] = LoadFolder( hObject, eventdata, UIPlot, UILoad)
md_GUI = evalin('base', 'md_GUI');
if isfield(md_GUI.load, 'prevdir')
    folder_name = uigetdir(md_GUI.load.prevdir);
else
    folder_name = uigetdir;
end
nofiles = 0;
fullfiletypeselected = '.mat';
if folder_name == 0
    msgbox('Please select a folder')
else
    %Save folder to .mat file - must be here, otherwise changes to 0
    md_GUI.load.prevdir = folder_name;
    foldername = folder_name;
    mdDefaultsPath = fullfile(foldername, 'md_defaults.m');
    pathname = fullfile(foldername, '*.dlt');   %set file extension
    matFiles = dir(pathname);                   %get the files
    String_ListOfFilesInFolder = {matFiles.name};
    set(UILoad.FiletypeEditBox, 'String', 'dlt')
    if isempty(String_ListOfFilesInFolder)
        pathname = fullfile(foldername, '*.mat');   %set file extension
        matFiles = dir(pathname);                   %get the files
        String_ListOfFilesInFolder = {matFiles.name};
        set(UILoad.FiletypeEditBox, 'String', 'mat')
        if isempty(String_ListOfFilesInFolder)
            % No .dlt nor .mat files found in folder.
            nofiles = 1;
        else
            % Selection on first file.
            fileselected = String_ListOfFilesInFolder(1);
        end
    else
        % Selection on first file.
        fileselected = String_ListOfFilesInFolder(1);
    end
    if nofiles == 0
    if exist(mdDefaultsPath, 'file' )
        filepath_mdDefault = fullfile(foldername, 'md_defaults.m'); %md_default in folder
        fileextension = ['*', fullfiletypeselected];
        pathname = fullfile(foldername, fileextension);   %set file extension
        matFiles = dir(pathname);                   %get the file
    else
    % Construct a question dialogue with two options: Yes and no.
        msgbox('md_defaults.m was not found in the folder. Please select the md_defaults file.')
        filepath_mdDefault = uigetfile();
    end
 	%run (filepath_mdDefault)
    md_GUI.load.String_ListOfFilesInFolder = String_ListOfFilesInFolder;
    md_GUI.load.folder_name = folder_name;
    md_GUI.load.fileselected = fileselected;
    set(UILoad.ListOfFilesInFolder, 'String', md_GUI.load.String_ListOfFilesInFolder)
    set(UILoad.ListOfFilesInFolder, 'Value', 1)
    set(UILoad.FiletypeEditBox, 'Enable', 'on')
    set(UILoad.LoadFileButton, 'Enable', 'on')
    %% Message to log_box - cell_to_be_inserted:
    cell_to_be_inserted = ['Folder loaded: ', foldername];
    [ md_GUI.UI.log_box_string ] = GUI.multitab.insertCell ( md_GUI.UI.log_box_string, cell_to_be_inserted );
    md_GUI.UI.UImultitab.log_box.String = md_GUI.UI.log_box_string;
    % End of new message to log_box function.
    %% Put it into base.
    assignin('base', 'md_GUI', md_GUI);
    else % No files found!
        message = ['No files with working fileformats found in that folder. Working fileformats are currently: [.dlt] & [.mat]. Returned to previous directory: ', md_GUI.load.prevdir];
        uiwait(msgbox(message,'No files found','modal'))
    end
end
end