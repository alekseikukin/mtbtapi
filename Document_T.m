function document = Document_T(file_id, file_unique_id, varargin)
% Document_T - This object represents a general file (as opposed to photos,
% voice messages and audio files).
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% thumb	PhotoSize	Optional. Document thumbnail as defined by sender
%
% file_name	String	Optional. Original filename as defined by sender
%
% mime_type	String	Optional. MIME type of the file as defined by sender
%
% file_size	Integer	Optional. File size
%
document = struct;
document.file_id = (file_id);
document.file_unique_id = (file_unique_id);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            document.thumb = varargin{2};
        case 'file_name'
            document.file_name = varargin{2};
        case 'mime_type'
            document.mime_type = varargin{2};
        case 'file_size'
            document.file_size = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end