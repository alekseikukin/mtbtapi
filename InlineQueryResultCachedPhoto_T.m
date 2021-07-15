function iqresult = InlineQueryResultCachedPhoto_T(id, photo_file_id, varargin)
% InlineQueryResultCachedPhoto_T - Represents a link to a photo stored on the
% Telegram servers. By default, this photo will be sent by the user with an
% optional caption. Alternatively, you can use input_message_content to
% send a message with the specified content instead of the photo.
%
% type	String	Type of the result, must be photo
% 
% id	String	Unique identifier for this result, 1-64 bytes
% 
% photo_file_id	String	A valid file identifier of the photo
% 
% title	String	Optional. Title for the result
% 
% description	String	Optional. Short description of the result
% 
% caption	String	Optional. Caption of the photo to be sent, 0-1024
% characters after entities parsing
% 
% parse_mode	String	Optional. Mode for parsing entities in the photo
% caption. See formatting options for more details.
% 
% caption_entities	Array of MessageEntity	Optional. List of special
% entities that appear in the caption, which can be specified instead of
% parse_mode
% 
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
% 
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the photo
%
iqresult = struct;
iqresult.type = 'photo';
iqresult.id = id;
iqresult.photo_file_id = photo_file_id;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'title'
            iqresult.title = varargin{2};
        case 'description'
            iqresult.description = varargin{2};
        case 'caption'
            iqresult.caption = varargin{2};
        case 'parse_mode'
            iqresult.parse_mode = varargin{2};
        case 'caption_entities'
            iqresult.caption_entities = varargin{2};
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