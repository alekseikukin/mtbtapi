function message2send = strucuture2message(MessageMediaType, structure2send)
% return message in form ready to send
if isstruct(structure2send)
    if string(MessageMediaType) =="multipart/form-data"
        if ~isstring(structure2send) || ~ischar(structure2send)
            structure2send = fullstructure2cellarray(structure2send);
        else
        end
    elseif string(MessageMediaType) == "application/json"
        structure2send = jsonencode(structure2send);
        message2send = structure2send;
    else
        disp(3)
    end
else
end
end