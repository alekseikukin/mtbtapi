function iqresult = InlineQueryResultGif_T(id, gif_url,...
    thumb_url, varargin)
% InlineQueryResultGif_T - Represents a link to an animated GIF file. By
% default, this animated GIF file will be sent by the user with optional
% caption. Alternatively, you can use input_message_content to send a
% message with the specified content instead of the animation.
%
% type	String	Type of the result, must be gif
%
% id	String	Unique identifier for this result, 1-64 bytes
%
% gif_url	String	A valid URL for the GIF file. File size must not exceed
% 1MB
%
% gif_width	Integer	Optional. Width of the GIF
%
% gif_height	Integer	Optional. Height of the GIF
%
% gif_duration	Integer	Optional. Duration of the GIF
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
% caption	String	Optional. Caption of the GIF file to be sent, 0-1024
% characters after entities parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the caption.
% See formatting options for more details.
%
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
%
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the GIF animation
%
iqresult = struct;
iqresult.type = 'gif';
iqresult.id = id;
iqresult.gif_url = gif_url;
iqresult.thumb_url = thumb_url;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'gif_width'
            iqresult.gif_width = varargin{2};
        case 'gif_height'
            iqresult.gif_height = varargin{2};
        case 'gif_duration'
            iqresult.gif_duration = varargin{2};
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
            iqresult.input_message_content = varargin{2};
            
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end