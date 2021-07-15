function photo2send = InputMediaPhoto_T( varargin)
%InputMediaPhoto_T - Represents a photo to be sent.
%
% Field	Type	Description
%
% type	String	Type of the result, must be photo
%
% media_file, media_id, media_url	String	File to send. Pass a file_id to
% send a file that exists on the Telegram servers (recommended), pass an
% HTTP URL for Telegram to get a file from the Internet, or pass to file
%
% caption	String	Optional. Caption of the photo to be sent, 0-1024
% characters after entities parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the photo
% caption. See formatting options for more details.
%
photo2send = struct;
photo2send.type = 'photo';
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'caption'
            photo2send. caption = varargin{2};
        case 'parse_mode'
            photo2send.parse_mode = varargin{2};
        case 'media_file'
            photo2send.media = ...
                matlab.net.http.io.FileProvider(string(varargin{2}));
        case 'media_id'
            photo2send.media = varargin{2};
        case 'media_url'
            photo2send.media = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty

end

