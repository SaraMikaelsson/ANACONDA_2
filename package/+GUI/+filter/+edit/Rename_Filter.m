% Description: Renames the selected filter.
%   - inputs:
%           Selected node (filter)
%           Selected filter's file metadata
%   - outputs:
%           Modified loaded file metadata
% Date of creation: 2017-07-18.
% Author: Benjamin Bolling.
% Modification date:
% Modifier:
function [] = Rename_Filter(~)
    md_GUI = evalin('base', 'md_GUI');
    %% Extracting the selected node
    % Get the path of the selected node:
    node_depth = 0; %At start 0 since penetration has not begun.
    parents_nom_str = 'Parent.Name'; %Starting parental path.
    parent.xyx = 0; %simply creating a struct named parent.
    [ parent, SelectedNode ] = GUI.filter.visualize.UI_Tree_selected_node_extract( node_depth, parents_nom_str, parent );
    % From the recursive extractor above, the path is returned as (parent.s(N-1)). ... .(parent.s2).
    nom_parents = length(fieldnames(parent)) - 2; %First fieldname is xyx ('waste'), and last one is the selected node.
    prev_path = parent.s1;
    for pathway = 2:(nom_parents) % 2 since number 1 is already set to prev_path.
        prev_path = [(parent.(['s', num2str(pathway)])), '.', prev_path, ];
    end
    selected_node_path = [prev_path, '.', SelectedNode];
    selected_node_path_cells = strsplit(selected_node_path, '.');
    if nom_parents == 0
        % Name is NOT editable! This is an experimental parameter.
        %% Message to log_box
        GUI.log.add(['This field cannot be renamed! This is a filter parent for an experiment.'])
    elseif strcmp(char(selected_node_path_cells(1)), 'built_in_filter') || strcmp(char(selected_node_path_cells(2)), 'built_in_filter')
        % A built-in filter cannot be renamed.
        %% Message to log_box
        GUI.log.add(['Cannot rename a built-in filter.'])
    else
        if ~selected_node_path == 0
            [exp_names] = strsplit(selected_node_path,'.');
            exp_name = char(exp_names(1));
            exp_parts = strsplit(selected_node_path,[exp_name, '.']);
            exp_part = char(exp_parts(2));
            exp_parts_struct = strsplit(exp_part, '.');
            exp_parent_path = char(exp_parts_struct(1));
            for llx = 2:length(exp_parts_struct)-1
                exp_parent_path = [exp_parent_path, '.', char(exp_parts_struct(llx))];
            end
            base_value = general.struct.getsubfield(md_GUI.mdata_n.(exp_name).cond, exp_part);
            UI = md_GUI.UI.UIFilter;
            OldName = UI.Tree.SelectedNodes.Name;
            NewName = inputdlg('Select the new filter name.', 'New Filter name', 1, {char(OldName)});
            if ~isempty(NewName)
                NewName = char(NewName);
                if strcmp(NewName, OldName)
                    % Old name is same as new name - show as message.
                    %% Message to log_box
                    GUI.log.add(['New name is the same as the old name.'])
                elseif strcmp(NewName, 'operator') || strcmp(NewName, 'operators')
                    % Do nothing since 'operator' or 'operators' as name will result in an error.
                    %% Message to log_box
                    GUI.log.add(['New name of filter cannot be [ operator ] nor [ operators ].'])
                else
                    parentpath = strsplit(exp_part, '.');
                    pathdepth = length(parentpath);
                    newpath = strsplit(exp_part, char(parentpath(pathdepth)));
                    newpath = char(newpath(1));
                    newpath = [newpath, NewName];
                    md_GUI.mdata_n.(exp_name).cond = general.struct.setsubfield(md_GUI.mdata_n.(exp_name).cond, newpath, base_value);
                    FieldToRmvCell = strsplit(exp_part, '.');
                    if length(FieldToRmvCell) == 1
                        md_GUI.mdata_n.(exp_name).cond = rmfield(md_GUI.mdata_n.(exp_name).cond, exp_part);
                    else
                        md_GUI.mdata_n.(exp_name).cond = general.struct.rmsubfield(md_GUI.mdata_n.(exp_name).cond, exp_part);
                    end
                    %% Message to log_box
                    GUI.log.add(['Filter was renamed from [ ', OldName, ' ] to [ ', NewName, ' ].'])
                    UI.Tree.SelectedNodes.Name = NewName;
                end
            end
        end
    end
    assignin('base', 'md_GUI', md_GUI)
end