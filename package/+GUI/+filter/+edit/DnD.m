% Description: Restructures the Filter Tree (UIFilter.Tree) as a drag and
% drop function. Function is being called at from uiextras.jTree.Tree, use
% ctrl + f or cmd + f and paste GUI.filter.edit.DnD to find its location in
% the Tree function. This is a modification which was not included in the
% original Tree function.
%   - inputs:
%           Nodes           (TargetNode, SourceNode)
%   - outputs:
%           Modified tree.                      (UIFilter.Tree, UI.Tree)
% Date of creation: 2017-07-03.
% Author: Benjamin Bolling.
% Modification date:
% Modifier:

function [ ] = DnD(Tree, DropInfo)
%%
TargetNode = DropInfo.Target;
SourceNode = DropInfo.Source;
TargetName = TargetNode.Name;
SourceName = SourceNode.Name;
md_GUI = evalin('base', 'md_GUI');
% Check destination if it is an experiment:
NameOfTargetParent = TargetNode.Name;
if strcmp(NameOfTargetParent, 'Filter')
    msgbox('Cannot copy to a non-experiment destination.', 'Warning')
    DropAction = 'Nothing';
else
    % Message to log_box - cell_to_be_inserted:
    cell_to_be_inserted = ['Condition/filter source: ', SourceName];
    [ md_GUI.UI.log_box_string ] = GUI.multitab.insertCell ( md_GUI.UI.log_box_string, cell_to_be_inserted );
    md_GUI.UI.UImultitab.log_box.String = md_GUI.UI.log_box_string;
    cell_to_be_inserted = ['Condition/filter target: ', TargetName];
    [ md_GUI.UI.log_box_string ] = GUI.multitab.insertCell ( md_GUI.UI.log_box_string, cell_to_be_inserted );
    md_GUI.UI.UImultitab.log_box.String = md_GUI.UI.log_box_string;
    % End of new message to log_box function.
    DropAction = questdlg(['Copy or move ' SourceName ' to ' TargetName '?'], 'Drag and drop', 'copy', 'move', 'move');
    % Message to log_box - cell_to_be_inserted:
    cell_to_be_inserted = ['Drag and Drop action: ', DropAction, ' ', SourceName, ' to ', TargetName];
    [ md_GUI.UI.log_box_string ] = GUI.multitab.insertCell ( md_GUI.UI.log_box_string, cell_to_be_inserted );
    md_GUI.UI.UImultitab.log_box.String = md_GUI.UI.log_box_string;
    % End of new message to log_box function.
    % Extracting the selected nodes:
    % Get the path of the origin:
    if isempty(DropAction)
        % Do nothing.
    else
    node_depth = 0; %At start 0 since penetration has not begun.
    parents_nom_str = 'Parent.Name'; %Starting parental path.
    parent.xyx = 0; %simply creating a struct named parent.
    [ parent, SelectedNode ] = GUI.filter.visualize.UI_Tree_selected_node_extract( node_depth, parents_nom_str, parent );
    parentfieldnames = fieldnames(parent);
    for parentlength = 2:length(parentfieldnames) - 1
        parentstructpath(parentlength-1) = parentfieldnames(parentlength);
        parentpath(parentlength-1) = cellstr(parent.([char(parentstructpath(parentlength-1))]));
    end
    parentlength = length(parentfieldnames) - 2;
    exp_name_in = strsplit(char(parentpath(parentlength)), '_|_');
    exp_name_in = char(exp_name_in(1));
    SelectedNodePath = [exp_name_in, '.cond'];
    for ppp = parentlength-1:-1:1
        SelectedNodePath = [char(SelectedNodePath), '.', char(parentpath(ppp))];
    end
    SelectedNodePath = [char(SelectedNodePath), '.', char(SelectedNode)];
    filterstruct = general.getsubfield(md_GUI.mdata_n, SelectedNodePath);
    % Get the path of the destination:
    targetpath = TargetNode.Name;
    % Check if it is a condition or a condition group (filter). If is a condition, take its parent.
    % This can be checked by looking if its children are structs or not.
    filtercontcheck = TargetNode.Children;
    if isempty(filtercontcheck)
        targetpath = TargetNode.Parent.Name;
        TargetNode = TargetNode.Parent;
        % Message to log_box - cell_to_be_inserted:
        cell_to_be_inserted = ['Target found to be a condition. Parent selected to be target, which is a filter: ', targetpath];
        [ md_GUI.UI.log_box_string ] = GUI.multitab.insertCell ( md_GUI.UI.log_box_string, cell_to_be_inserted );
        md_GUI.UI.UImultitab.log_box.String = md_GUI.UI.log_box_string;
        % End of new message to log_box function.
    end
    depth = 0;
    [ ~, ~, depth ] = GUI.filter.visualize.targetdepthfinder( TargetNode, targetpath, depth );
    [  targetpath, exp_name_out ] = GUI.filter.visualize.targetextractor(TargetNode, depth);
    if strcmp(targetpath, '.filter')
        targetfullpath = [exp_name_out, '.cond', '.', SelectedNode];
    elseif isempty(targetpath)
        targetfullpath = [exp_name_out, '.cond.', SelectedNode];
    else
        targetfullpath = [exp_name_out, '.cond.', targetpath, '.', SelectedNode];
    end
    md_GUI.mdata_n = general.setsubfield(md_GUI.mdata_n, targetfullpath, filterstruct);
    %Check if there already is a node with same name - if yes, tell this to the user and ask what to do.
    targetchildren = char(TargetNode.Children.Name);
    targetchildren = cellstr(targetchildren);
    Replacement = 0;
    for tchildren = 1:length(targetchildren)
        targetname = char(targetchildren(tchildren));
        if strcmp(targetname, SelectedNode)
            replacetarget = questdlg('Filter with same name found in target. Replace?', 'Warning', 'yes', 'no', 'no');
            switch replacetarget
                case 'yes'
                    Replacement = 1;
                case 'no'
                    DropAction = 'Nothing';
            end
        end
    end
end
switch DropAction
    case 'copy'
        NewSourceNode = copy(SourceNode,TargetNode);
        expand(TargetNode)
        expand(SourceNode)
        expand(NewSourceNode)
        assignin('base', 'md_GUI', md_GUI)
        % Always reload the tree if a previous node is replaced.
        if Replacement == 1
            UI = md_GUI.UI.UIFilter;
            clear Node
            UI.Tree.Root.Children.delete
            NumberOfLoadedFiles = md_GUI.load.NumberOfLoadedFiles;
            fileloading = 1;
            for nn = 1:NumberOfLoadedFiles
                [ UI ] = GUI.filter.Create_layout.FilterTreeList( fileloading, nn );
            end
        end
    case 'move'
        set(SourceNode,'Parent',TargetNode)
        expand(TargetNode)
        expand(SourceNode)
        % Remove original:
        FieldToRmv = strsplit(SelectedNodePath, '.cond.');
        FieldToRmv = char(FieldToRmv(2));
        FieldToRmvCell = strsplit(FieldToRmv, '.');
        if length(FieldToRmvCell) == 1
            md_GUI.mdata_n.(exp_name_out).cond = rmfield(md_GUI.mdata_n.exp1.cond, FieldToRmv);
        else
            md_GUI.mdata_n.(exp_name_out).cond = general.rmsubfield(md_GUI.mdata_n.exp1.cond, FieldToRmv);
        end
        % Always reload the tree if a previous node is replaced.
        if Replacement == 1
            UI = md_GUI.UI.UIFilter;
            clear Node
            UI.Tree.Root.Children.delete
            NumberOfLoadedFiles = md_GUI.load.NumberOfLoadedFiles;
            fileloading = 1;
            for nn = 1:NumberOfLoadedFiles
                [ UI ] = GUI.filter.Create_layout.FilterTreeList( fileloading, nn );
            end
            expand(TargetNode)
            expand(SourceNode)
        end
        assignin('base', 'md_GUI', md_GUI)
    otherwise % Do nothing
        disp('Did nothing.')
end
end
end