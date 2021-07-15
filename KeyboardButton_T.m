function Button= KeyboardButton_T(text, varargin)
%KeyboardButton - This object represents one button of the reply keyboard.
%For simple text buttons String can be used instead of this object to
%specify text of the button. Optional fields request_contact,
%request_location, and request_poll are mutually exclusive.
% 
% text -	String -	Text of the button. If none of the optional fields
% are used, it will be sent as a message when the button is pressed
% 
% request_contact	- Boolean -	Optional. If True, the user's phone number
% will be sent as a contact when the button is pressed. Available in
% private chats only
% 
% request_location -	Boolean -	Optional. If True, the user's current
% location will be sent when the button is pressed. Available in private
% chats only
% 
% request_poll -	KeyboardButtonPollType -	Optional. If specified, the
% user will be asked to create a poll and send it to the bot when the
% button is pressed. Available in private chats only
% 
Button = struct;
Button.text = (text);
Button.request_contact = false;
Button.request_location = false;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'request_contact'
            Button.request_contact = varargin{2};
        case 'request_location'
            Button.request_location = varargin{2};
        case 'request_poll'
            Button.request_poll = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end

