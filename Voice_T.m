function voice = Voice_T(file_id, file_unique_id,...
    duration, varargin)
% Voice_T - This object represents a voice note.
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
% mime_type	String	Optional. MIME type of the file as defined by sender
%
% file_size	Integer	Optional. File size
%
voice = struct;
voice.file_id = (file_id);
voice.file_unique_id = (file_unique_id);
voice.duration = (duration);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            voice.thumb = (varargin{2});
        case 'file_name'
            voice.file_name = (varargin{2});
        case 'mime_type'
            voice.mime_type = (varargin{2});
        case 'file_size'
            voice.file_size = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end