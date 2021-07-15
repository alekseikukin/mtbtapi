function iqresult = InlineQueryResultLocation_T(id, latitude,longitude, ...
    title, varargin)
% InlineQueryResultLocation_T Represents a location on a map. By default,
% the location will be sent by the user. Alternatively, you can use
% input_message_content to send a message with the specified content
% instead of the location.
%
% type	String	Type of the result, must be location
%
% id	String	Unique identifier for this result, 1-64 Bytes
%
% latitude	Float number	Location latitude in degrees
%
% longitude	Float number	Location longitude in degrees
%
% title	String	Location title
%
% horizontal_accuracy	Float number	Optional. The radius of uncertainty
% for the location, measured in meters; 0-1500
%
% live_period	Integer	Optional. Period in seconds for which the location
% can be updated, should be between 60 and 86400.
%
% heading	Integer	Optional. For live locations, a direction in which the
% user is moving, in degrees. Must be between 1 and 360 if specified.
%
% proximity_alert_radius	Integer	Optional. For live locations, a maximum
% distance for proximity alerts about approaching another chat member, in
% meters. Must be between 1 and 100000 if specified.
%
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
%
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the location
%
% thumb_url	String	Optional. Url of the thumbnail for the result
%
% thumb_width	Integer	Optional. Thumbnail width
%
% thumb_height	Integer	Optional. Thumbnail height
%
iqresult = struct;
iqresult.type = 'venue';
iqresult.id = id;
iqresult.title = latitude;
iqresult.title = longitude;
iqresult.title = title;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'horizontal_accuracy'
            iqresult.horizontal_accuracy = varargin{2};
        case 'live_period'
            iqresult.live_period = varargin{2};
        case 'heading'
            iqresult.heading = varargin{2};
        case 'proximity_alert_radius'
            iqresult.proximity_alert_radius = varargin{2};
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'input_message_content'
            iqresult.input_message_content = varargin{2};
        case 'thumb_url'
            iqresult.thumb_url = varargin{2};
        case 'thumb_width'
            iqresult.thumb_width = varargin{2};
        case 'thumb_height'
            iqresult.thumb_height = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end