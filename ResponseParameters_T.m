function responseparameters = ResponseParameters_T(varargin)
% ResponseParameters_T  - Contains information about why a request was
% unsuccessful.
%
% migrate_to_chat_id	Integer	Optional. The group has been migrated to a
% supergroup with the specified identifier. This number may be greater than
% 32 bits and some programming languages may have difficulty/silent defects
% in interpreting it. But it is smaller than 52 bits, so a signed 64 bit
% integer or double-precision float type are safe for storing this
% identifier.
%
% retry_after	Integer	Optional. In case of exceeding flood control, the
% number of seconds left to wait before the request can be repeated
%
responseparameters = struct;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'migrate_to_chat_id'
            responseparameters.migrate_to_chat_id = varargin{2};
        case 'retry_after'
            responseparameters.retry_after = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end

