function audio = Audio_T(file_id, file_unique_id, duration, varargin)
% Audio_T - This object represents an audio file to be treated as music by
% the Telegram clients.
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% duration	Integer	Duration of the audio in seconds as defined by sender
%
% performer	String	Optional. Performer of the audio as defined by sender
% or by audio tags
%
% title	String	Optional. Title of the audio as defined by sender or by
% audio tags
%
% mime_type	String	Optional. MIME type of the file as defined by sender
%
% file_size	Integer	Optional. File size
%
% thumb	PhotoSize	Optional. Thumbnail of the album cover to which the
% music file belongs
%
audio = struct;
audio.file_id = (file_id);
audio.file_unique_id = (file_unique_id);
audio.duration = (duration);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'performer'
            audio.performer = (varargin{2});
        case 'title'
            audio.title = (varargin{2});
        case 'mime_type'
            audio.mime_type = (varargin{2});
        case 'file_size'
            audio.file_size = (varargin{2});
        case 'thumb'
            audio.thumb = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
audio = jsonencode(audio);

end