function iqresult = InlineQueryResultCachedVoice_T(id, voice_file_id,...
    title, varargin)
% InlineQueryResultCachedVoice_T - Represents a link to a voice message
% stored on the Telegram servers. By default, this voice message will be
% sent by the user. Alternatively, you can use input_message_content to
% send a message with the specified content instead of the voice message.
%
% type	String	Type of the result, must be voice
% 
% id	String	Unique identifier for this result, 1-64 bytes
% 
% voice_file_id	String	A valid file identifier for the voice message
% 
% title	String	Voice message title
% 
% caption	String	Optional. Caption, 0-1024 characters after entities
% parsing
% 
% parse_mode	String	Optional. Mode for parsing entities in the voice
% message caption. See formatting options for more details.
% 
% caption_entities	Array of MessageEntity	Optional. List of special
% entities that appear in the caption, which can be specified instead of
% parse_mode
% 
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
% 
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the voice message
%
iqresult = struct;
iqresult.type = 'voice';
iqresult.id = id;
iqresult.voice_file_id = voice_file_id;
iqresult.title = title;
while ~isempty(varargin)
    switch lower(varargin{1})
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