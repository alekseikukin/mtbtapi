function iqresult = InlineQueryResultCachedMpeg4Gif_T(id, mpeg4_file_id, varargin)
% InlineQueryResultCachedMpeg4Gif_T - Represents a link to a video animation
% (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By
% default, this animated MPEG-4 file will be sent by the user with an
% optional caption. Alternatively, you can use input_message_content to
% send a message with the specified content instead of the animation.
%
% type	String	Type of the result, must be mpeg4_gif
% 
% id	String	Unique identifier for this result, 1-64 bytes
% 
% mpeg4_file_id	String	A valid file identifier for the MP4 file
% 
% title	String	Optional. Title for the result
% 
% caption	String	Optional. Caption of the MPEG-4 file to be sent, 0-1024
% characters after entities parsing
% 
% parse_mode	String	Optional. Mode for parsing entities in the caption.
% See formatting options for more details.
% 
% caption_entities	Array of MessageEntity	Optional. List of special
% entities that appear in the caption, which can be specified instead of
% parse_mode
% 
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
% 
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the video animation
%
iqresult = struct;
iqresult.type = 'mpeg4_gif';
iqresult.id = id;
iqresult.mpeg4_file_id = mpeg4_file_id;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'title'
            iqresult.title = varargin{2};
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