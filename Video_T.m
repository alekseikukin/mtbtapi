function video = Video_T(file_id, file_unique_id, width, height,...
    duration, varargin)
% Video_T - This object represents a video file.
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
% thumb	PhotoSize	Optional. Video thumbnail
% 
% mime_type	String	Optional. Mime type of a file as defined by sender
% 
% file_size	Integer	Optional. File size
%
video = struct;
video.file_id = (file_id);
video.file_unique_id = (file_unique_id);
video.width = (width);
video.height = (height);
video.duration = (duration);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            video.thumb = varargin{2};
        case 'mime_type'
            video.mime_type = varargin{2};
        case 'file_size'
            video.file_size = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}]);
    end
    varargin(1:2) = [];
end
end