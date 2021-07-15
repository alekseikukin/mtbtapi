function iqresult = InputContactMessageContent_T(phone_number, first_name,...
    varargin)
% InputContactMessageContent_T Represents the content of a contact message
% to be sent as the result of an inline query.
%
% phone_number	String	Contact's phone number
%
% first_name	String	Contact's first name
%
% last_name	String	Optional. Contact's last name
%
% vcard	String	Optional. Additional data about the contact in the form of
% a vCard, 0-2048 bytes
%
iqresult = struct;
iqresult.phone_number = phone_number;
iqresult.first_name = first_name;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'last_name'
            iqresult.last_name = varargin{2};
        case 'vcard'
            iqresult.vcard = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end