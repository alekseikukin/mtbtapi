function iqresult = InputVenueMessageContent_T(latitude, longitude,...
    title, address, varargin)
% InputVenueMessageContent_T Represents the content of a venue message to
% be sent as the result of an inline query.
%
% latitude	Float	Latitude of the venue in degrees
%
% longitude	Float	Longitude of the venue in degrees
%
% title	String	Name of the venue
%
% address	String	Address of the venue
%
% foursquare_id	String	Optional. Foursquare identifier of the venue, if
% known
%
% foursquare_type	String	Optional. Foursquare type of the venue, if
% known. (For example, “arts_entertainment/default”,
% “arts_entertainment/aquarium” or “food/icecream”.)
%
% google_place_id	String	Optional. Google Places identifier of the venue
%
% google_place_type	String	Optional. Google Places type of the venue. (See
% supported types.)
%
iqresult = struct;
iqresult.latitude = latitude;
iqresult.longitude = longitude;
iqresult.title = title;
iqresult.address = address;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'foursquare_id'
            iqresult.foursquare_id = varargin{2};
        case 'foursquare_type'
            iqresult.foursquare_type = varargin{2};
        case 'google_place_id'
            iqresult.google_place_id = varargin{2};
        case 'google_place_type'
            iqresult.google_place_type = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end