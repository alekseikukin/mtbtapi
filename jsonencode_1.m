function json  = jsonencode_1(data)
% convert structure to json string, correct cases when structure containe
% json string
json = jsonencode(data);
json = strrep(json,'\"','"');
json = strrep(json,'\\','\');
json = strrep(json,'"{','{');
json = strrep(json,'}"','}');
json = strrep(json,'"[','[');
json = strrep(json,']"',']');
end