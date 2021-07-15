function iqresult = InputTextMessageContent_T(message_text,...
    varargin)
% InputTextMessageContent_T Represents the content of a text message to be
% sent as the result of an inline query.
%
% message_text	String	Text of the message to be sent, 1-4096 characters
% 
% parse_mode	String	Optional. Mode for parsing entities in the message
% text. See formatting options for more details.
% 
% entities	Array of MessageEntity	Optional. List of special entities that
% appear in message text, which can be specified instead of parse_mode
% 
% disable_web_page_preview	Boolean	Optional. Disables link previews for
% links in the sent message
%
iqresult = struct;
iqresult.message_text = message_text;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'parse_mode'
            iqresult.parse_mode = varargin{2};
        case 'entities'
            iqresult.entities = varargin{2};
        case 'disable_web_page_preview'
            iqresult.disable_web_page_preview = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end