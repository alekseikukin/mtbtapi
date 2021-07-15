function iqresult = InlineQueryResultMpeg4Gif_T(id, mpeg4_url,...
    thumb_url, varargin)
% InlineQueryResultMpeg4Gif - Represents a link to a video animation
% (H.264/MPEG-4 AVC video without sound). By default, this animated MPEG-4
% file will be sent by the user with optional caption. Alternatively, you
% can use input_message_content to send a message with the specified
% content instead of the animation.
%
% type	String	Type of the result, must be mpeg4_gif
%
% id	String	Unique identifier for this result, 1-64 bytes
%
% mpeg4_url	String	A valid URL for the MP4 file. File size must not exceed
% 1MB
%
% mpeg4_width	Integer	Optional. Video width
%
% mpeg4_height	Integer	Optional. Video height
%
% mpeg4_duration	Integer	Optional. Video duration
%
% thumb_url	String	URL of the static (JPEG or GIF) or animated (MPEG4)
% thumbnail for the result
%
% thumb_mime_type	String	Optional. MIME type of the thumbnail, must be
% one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to
% “image/jpeg”
%
% title	String	Optional. Title for the result
%
% caption	String	Optional. Caption of the MPEG-4 file to be sent, 0-1024
% characters after entities parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the caption.
% See formatting options for more details.
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
iqresult.mpeg4_url = mpeg4_url;
iqresult.thumb_url = thumb_url;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'mpeg4_width'
            iqresult.mpeg4_width = varargin{2};
        case 'mpeg4_height'
            iqresult.mpeg4_height = varargin{2};
        case 'mpeg4_duration'
            iqresult.mpeg4_duration = varargin{2};
        case 'thumb_mime_type'
            iqresult.thumb_mime_type = varargin{2};
        case 'title'
            iqresult.title = varargin{2};
        case 'caption'
            iqresult.caption = varargin{2};
        case 'parse_mode'
            iqresult.parse_mode = varargin{2};
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'input_message_content'
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end