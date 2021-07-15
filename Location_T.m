function location = Location_T(longitude, latitude)
% Location_T - This object represents a point on the map.
%
% longitude	Float	Longitude as defined by sender
%
% latitude	Float	Latitude as defined by sender
%
location = struct;
location.longitude = longitude;
location.latitude = latitude;
end