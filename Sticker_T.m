function iqresult = Sticker_T(file_id, file_unique_id, width, height,...
    is_animated, varargin)
% Sticker_T This object represents a sticker.
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% width	Integer	Sticker width
%
% height	Integer	Sticker height
%
% is_animated	Boolean	True, if the sticker is animated
%
% thumb	PhotoSize	Optional. Sticker thumbnail in the .WEBP or .JPG format
%
% emoji	String	Optional. Emoji associated with the sticker
%
% set_name	String	Optional. Name of the sticker set to which the sticker
% belongs
%
% mask_position	MaskPosition	Optional. For mask stickers, the position
% where the mask should be placed
%
% file_size	Integer	Optional. File size
%
iqresult = struct;
iqresult.file_id = file_id;
iqresult.file_unique_id = file_unique_id;
iqresult.width = width;
iqresult.height = height;
iqresult.is_animated = is_animated;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            iqresult.thumb = varargin{2};
        case 'emoji'
            iqresult.emoji = varargin{2};
        case 'set_name'
            iqresult.set_name = varargin{2};
        case 'mask_position'
            iqresult.mask_position = varargin{2};
        case 'file_size'
            iqresult.file_size = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end