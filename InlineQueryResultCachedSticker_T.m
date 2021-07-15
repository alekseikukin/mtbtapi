function iqresult = InlineQueryResultCachedSticker_T(id, sticker_file_id, varargin)
% InlineQueryResultCachedSticker_T - Represents a link to a sticker stored on
% the Telegram servers. By default, this sticker will be sent by the user.
% Alternatively, you can use input_message_content to send a message with
% the specified content instead of the sticker.
%
% type	String	Type of the result, must be sticker
% 
% id	String	Unique identifier for this result, 1-64 bytes
% 
% sticker_file_id	String	A valid file identifier of the sticker
% 
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
% 
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the sticker
%
iqresult = struct;
iqresult.type = 'sticker';
iqresult.id = id;
iqresult.sticker_file_id = sticker_file_id;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'input_message_content'
            iqresult.input_message_content = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end