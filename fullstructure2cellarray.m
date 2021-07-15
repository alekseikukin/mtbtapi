function input_data = fullstructure2cellarray(input_data)
% fullstructure2cellarray convert structure to cell array of string and
% objects for sending by http.
if isempty(input_data)
elseif ischar(input_data)
    % elseif isstring(input_data)
    %     input_data = char(string(input_data));
elseif isnumeric(input_data)
    input_data = char(string(input_data));
elseif islogical(input_data)
    input_data = char(string(input_data));
elseif iscell(input_data)
    input_data = cellfun(@fullstructure2cellarray, input_data,...
        'UniformOutput', false);
elseif  isstruct(input_data)
    fieldnames_res = fieldnames(input_data);
    fields_res = struct2cell(input_data);
    clear input;
    input_data = {};
    [fields_res] = json_string_cheker(fieldnames_res, fields_res);
    for i=1:size(fieldnames_res)
        input_data{end + 1} = fieldnames_res{i};
        input_data{end + 1} = fullstructure2cellarray(fields_res{i});
    end
else
end
end

