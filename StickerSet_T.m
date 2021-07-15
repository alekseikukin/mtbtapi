function iqresult = StickerSet_T(name, title, is_animated, contains_masks,...
    stickers, varargin)
% StickerSet_T This object represents a sticker set.
%
% name	String	Sticker set name
% 
% title	String	Sticker set title
% 
% is_animated	Boolean	True, if the sticker set contains animated stickers
% 
% contains_masks	Boolean	True, if the sticker set contains masks
% 
% stickers	Array of Sticker	List of all set stickers
% 
% thumb	PhotoSize	Optional. Sticker set thumbnail in the .WEBP or .TGS
% format
%
iqresult = struct;
iqresult.name = name;
iqresult.title = title;
iqresult.is_animated = is_animated;
iqresult.contains_masks = contains_masks;
iqresult.stickers = stickers;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            iqresult.thumb = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end