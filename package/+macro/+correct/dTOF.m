function  [data_out] = dTOF(data_in, metadata_in, det_name)
% This macro corrects the TOF (for example for signal propagation times).
% Input:
% data_in        The experimental data, already converted
% metadata_in    The corresponding metadata
% det_name      (optional) The name of the detector
% Output:
% data_out      The output data with converted data.
% metadata_out  The corresponding metadata
data_out = data_in;

if exist('det_name', 'var')
    detnames = {det_name};
else % No detector name is given, so we fetch all detector names:
    detnames = fieldnames(metadata_in.det);
end

for i = 1:length(detnames)
    detname = detnames{i};  

    % find the TOF signal:
    idx_TOF     = find(strcmp(metadata_in.det.(detname).signals, 'TOF [ns]'));

    if general.struct.probe_field(metadata_in.corr.(detname).ifdo, 'dTOF') && ~general.struct.probe_field(data_in.h.(detname).corr_log, 'dTOF')

        data_out.h.(detname).TOF = data_in.h.(detname).raw(:,idx_TOF) - metadata_in.corr.(detname).dTOF;
        disp(['Log: delta TOF correction performed on ' detname])
%         write in the log:
        data_out.h.(detname).corr_log.dTOF = true;
    elseif general.struct.probe_field(data_in.h.(detname).corr_log, 'dTOF')
        disp(['Delta TOF correction already performed earlier on ' detname])
    else
        % no correction needed
        data_out.h.(detname).TOF      = data_in.h.(detname).raw(:,idx_TOF);
        data_out.h.(detname).corr_log.dTOF = false;
    end
end
end
