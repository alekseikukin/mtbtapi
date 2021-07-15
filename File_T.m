function file = File_T(file_id, file_unique_id, varargin)
% File_T - This object represents a file ready to be downloaded. The file can
% be downloaded via the link
% https://api.telegram.org/file/bot<token>/<file_path>. It is guaranteed
% that the link will be valid for at least 1 hour. When the link expires, a
% new one can be requested by calling getFile.
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% file_size	Integer	Optional. File size, if known
%
% file_path	String	Optional. File path. Use
% https://api.telegram.org/file/bot<token>/<file_path> to get the file.
%
file = struct;
file.file_id = (file_id);
file.file_unique_id = (file_unique_id);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'file_size'
            file.file_size = varargin{2};
        case 'file_path'
            file.file_path = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end

end

