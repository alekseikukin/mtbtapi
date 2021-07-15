function video2send = InputMediaVideo_T( varargin)
% InputMediaVideo_T - Represents a video to be sent.
%
% type	String	Type of the result, must be video
%
% media_file, media_id, media_url	String	File to send. Pass a file_id to
% send a file that exists on the Telegram servers (recommended), pass an
% HTTP URL for Telegram to get a file from the Internet, or pass to file
%
% thumbf, thumbs	InputFile or String	Optional. Thumbnail of the file sent; can be
% ignored if thumbnail generation for the file is supported server-side.
% The thumbnail should be in JPEG format and less than 200 kB in size. A
% thumbnail's width and height should not exceed 320. Ignored if the file
% is not uploaded using multipart/form-data. Thumbnails can't be reused and
% can be only uploaded as a new file, so you can pass
%
% caption	String	Optional. Caption of the video to be sent, 0-1024
% characters after entities parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the video
% caption. See formatting options for more details.
%
% width	Integer	Optional. Video width
%
% height	Integer	Optional. Video height
%
% duration	Integer	Optional. Video duration
%
% supports_streaming	Boolean	Optional. Pass True, if the uploaded video
% is suitable for streaming
%
video2send = struct;
video2send.type = 'video';
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'media_file'
            video2send.media = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'media_id'
            video2send.media = varargin{2};
        case 'media_url'
            video2send.media = varargin{2};
        case 'thumbf'
            video2send.thumb = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'thumbs'
            video2send.thumb = varargin{2};
        case 'caption'
            video2send. caption = varargin{2};
        case 'parse_mode'
            video2send.parse_mode = varargin{2};
        case 'width'
            video2send.width = varargin{2};
        case 'height'
            video2send.height = varargin{2};
        case 'duration'
            video2send.duration = varargin{2};
        case 'supports_streaming'
            video2send.supports_streaming = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end

