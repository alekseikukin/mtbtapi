function audio2send = InputMediaAudio_T( varargin)
% InputMediaAudio_T - Represents an audio file to be treated as music to be
% sent.

% type	String	Type of the result, must be audio
%
% media_file, media_id, media_url	String	File to send. Pass a file_id to
% send a file that exists on the Telegram servers (recommended), pass an
% HTTP URL for Telegram to get a file from the Internet, or pass to file
%
% thumbf, thumbs	InputFile or String	Optional. Thumbnail of the file
% sent; can be ignored if thumbnail generation for the file is supported
% server-side. The thumbnail should be in JPEG format and less than 200 kB
% in size. A thumbnail's width and height should not exceed 320. Ignored if
% the file is not uploaded using multipart/form-data. Thumbnails can't be
% reused and can be only uploaded as a new file, so you can pass
%
% caption	String	Optional. Caption of the audio to be sent, 0-1024
% characters after entities parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the audio
% caption. See formatting options for more details.
%
% duration	Integer	Optional. Duration of the audio in seconds
%
% performer	String	Optional. Performer of the audio
%
% title	String	Optional. Title of the audio
%
audio2send = struct;
audio2send.type = 'audio';
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'media_file'
            audio2send.media = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'media_id'
            audio2send.media = varargin{2};
        case 'media_url'
            audio2send.media = varargin{2};
        case 'thumbf'
            audio2send.thumb = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'thumbs'
            audio2send.thumb = varargin{2};
        case 'caption'
            audio2send. caption = varargin{2};
        case 'parse_mode'
            audio2send.parse_mode = varargin{2};
        case 'duration'
            audio2send.duration = varargin{2};
        case 'performer'
            audio2send.performer = varargin{2};
        case 'title'
            audio2send.title = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end

