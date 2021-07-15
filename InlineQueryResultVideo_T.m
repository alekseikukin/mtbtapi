function iqresult = InlineQueryResultVideo_T(id, video_url, mime_type, ...
    thumb_url, title,  varargin)
% InlineQueryResultVideo_T Represents a link to a page containing an embedded
% video player or a video file. By default, this video file will be sent by
% the user with an optional caption. Alternatively, you can use
% input_message_content to send a message with the specified content
% instead of the video.
%
% If an InlineQueryResultVideo message contains an embedded video (e.g.,
% YouTube), you must replace its content using input_message_content.
%
% type	String	Type of the result, must be mpeg4_gif
%
% id	String	Unique identifier for this result, 1-64 bytes
%
% video_url	String	A valid URL for the embedded video player or video file
%
% mime_type	String	Mime type of the content of video url, “text/html” or
% “video/mp4”
%
% thumb_url	String	URL of the static (JPEG or GIF) or animated (MPEG4)
% thumbnail for the result
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
%
% video_width	Integer	Optional. Video width
%
% video_height	Integer	Optional. Video height
%
% video_duration	Integer	Optional. Video duration in seconds
%
% description	String	Optional. Short description of the result
%
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
%
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the video animation
%
iqresult = struct;
iqresult.type = 'video';
iqresult.id = id;
iqresult.video_url = video_url;
iqresult.mime_type = mime_type;
iqresult.thumb_url = thumb_url;
iqresult.title = title;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'caption'
            iqresult.caption = varargin{2};
        case 'parse_mode'
            iqresult.parse_mode = varargin{2};
        case 'caption_entities'
            iqresult.caption_entities = varargin{2};
        case 'video_width'
            iqresult.video_width = varargin{2};
        case 'video_height'
            iqresult.video_height = varargin{2};
        case 'video_duration'
            iqresult.video_duration = varargin{2};
        case 'description'
            iqresult.description = varargin{2};
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'input_message_content'
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end