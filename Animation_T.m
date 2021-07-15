function animation = Animation_T(file_id, file_unique_id, width,...
    height, duration, varargin)
% Animation_T - This object represents an animation file (GIF or H.264/MPEG-4
% AVC video without sound).
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% width	Integer	Video width as defined by sender
%
% height	Integer	Video height as defined by sender
%
% duration	Integer	Duration of the video in seconds as defined by sender
%
% thumb	PhotoSize	Optional. Animation thumbnail as defined by sender
%
% file_name	String	Optional. Original animation filename as defined by
% sender
%
% mime_type	String	Optional. MIME type of the file as defined by sender
%
% file_size	Integer	Optional. File size
%

animation = struct;
animation.file_id = (file_id);
animation.file_unique_id = (file_unique_id);
animation.width = (width);
animation.height = (height);
animation.duration = (duration);

while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            animation.thumb = (varargin{2});
        case 'file_name'
            animation.file_name = (varargin{2});
        case 'mime_type'
            animation.mime_type = (varargin{2});
        case 'file_size'
            animation.file_size = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
% animation = jsonencode(animation);

end