function animation2send = InputMediaAnimation_T( varargin)
% InputMediaAnimation_T - Represents an animation file (GIF or H.264/MPEG-4
% AVC video without sound) to be sent.
%
% type	String	Type of the result, must be animation
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
% caption	String	Optional. Caption of the animation to be sent, 0-1024
% characters after entities parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the
% animation caption. See formatting options for more details.
%
% width	Integer	Optional. Animation width
%
% height	Integer	Optional. Animation height
%
% duration	Integer	Optional. Animation duration
%
animation2send = struct;
animation2send.type = 'animation';
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'media_file'
            animation2send.media = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'media_id'
            animation2send.media = varargin{2};
        case 'media_url'
            animation2send.media = varargin{2};
        case 'thumbf'
            animation2send.thumb = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'thumbs'
            animation2send.thumb = varargin{2};
        case 'caption'
            animation2send. caption = varargin{2};
        case 'parse_mode'
            animation2send.parse_mode = varargin{2};
        case 'width'
            animation2send.width = varargin{2};
        case 'height'
            animation2send.height = varargin{2};
        case 'duration'
            animation2send.duration = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end

