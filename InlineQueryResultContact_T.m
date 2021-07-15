function iqresult = InlineQueryResultContact_T(id, phone_number,first_name, varargin)
% InlineQueryResultContact_T Represents a contact with a phone number. By
% default, this contact will be sent by the user. Alternatively, you can
% use input_message_content to send a message with the specified content
% instead of the contact.
%
% type	String	Type of the result, must be contact
% 
% id	String	Unique identifier for this result, 1-64 Bytes
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
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
% 
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the contact
% 
% thumb_url	String	Optional. Url of the thumbnail for the result
% 
% thumb_width	Integer	Optional. Thumbnail width
% 
% thumb_height	Integer	Optional. Thumbnail height
%
iqresult = struct;
iqresult.type = 'contact';
iqresult.id = id;
iqresult.phone_number = phone_number;
iqresult.first_name = first_name;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'last_name'
            iqresult.last_name = varargin{2};
        case 'vcard'
            iqresult.vcard = varargin{2};
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'input_message_content'
            iqresult.input_message_content = varargin{2};
        case 'thumb_url'
            iqresult.thumb_url = varargin{2};
        case 'thumb_width'
            iqresult.thumb_width = varargin{2};
        case 'thumb_height'
            iqresult.thumb_height = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end