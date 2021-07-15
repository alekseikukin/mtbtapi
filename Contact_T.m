function contact = Contact_T(phone_number, first_name, varargin)
% Contact_T - This object represents a phone contact.
%
% phone_number	String	Contact's phone number
%
% first_name	String	Contact's first name
%
% last_name	String	Optional. Contact's last name
%
% user_id	Integer	Optional. Contact's user identifier in Telegram
%
% vcard	String	Optional. Additional data about the contact in the form of
% a vCard
%
contact = struct;
contact.phone_number = (phone_number);
contact.first_name = (first_name);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'last_name'
            contact.last_name = (varargin{2});
        case 'user_id'
            contact.user_id = (varargin{2});
        case 'vcard'
            contact.vcard = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end

end