function iqresult = InputLocationMessageContent_T(latitude, longitude,...
    varargin)
% InputLocationMessageContent_T Represents the content of a location
% message to be sent as the result of an inline query.
%
% latitude	Float	Latitude of the location in degrees
%
% longitude	Float	Longitude of the location in degrees
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
iqresult = struct;
iqresult.latitude = latitude;
iqresult.longitude = longitude;

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
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end