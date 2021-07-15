function photosize = PhotoSize_T(file_id, file_unique_id, width, height, varargin)
% PhotoSize_T This object represents one size of a photo or a file / sticker
% thumbnail.
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% width	Integer	Photo width
%
% height	Integer	Photo height
%
% file_size	Integer	Optional. File size
%
photosize = struct;
photosize.file_id = (file_id);
photosize.file_unique_id = (file_unique_id);
photosize.width = (width);
photosize.height = (height);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'file_size'
            photosize.file_size = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end