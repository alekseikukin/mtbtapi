function videonote = VideoNote_T(file_id, file_unique_id, length,...
    duration, varargin)
% VideoNote_T This object represents a video message (available in Telegram
% apps as of v.4.0).
%
% file_id	String	Identifier for this file, which can be used to download
% or reuse the file
%
% file_unique_id	String	Unique identifier for this file, which is
% supposed to be the same over time and for different bots. Can't be used
% to download or reuse the file.
%
% length	Integer	Video width and height (diameter of the video message)
% as defined by sender
%
% duration	Integer	Duration of the video in seconds as defined by sender
%
% thumb	PhotoSize	Optional. Video thumbnail
%
% file_size	Integer	Optional. File size
%
videonote = struct;
videonote.file_id = file_id;
videonote.file_unique_id = file_unique_id;
videonote.length = length;
videonote.duration = duration;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'thumb'
            videonote.thumb = varargin{2};
        case 'file_size'
            videonote.file_size = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end