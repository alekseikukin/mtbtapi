function venue = Venue_T(location, title, address, varargin)
% Venue_T This object represents a venue.
%
% location	Location	Venue location
%
% title	String	Name of the venue
%
% address	String	Address of the venue
%
% foursquare_id	String	Optional. Foursquare identifier of the venue
%
% foursquare_type	String	Optional. Foursquare type of the venue. (For
% example, “arts_entertainment/default”, “arts_entertainment/aquarium” or
% “food/icecream”.)
%
venue = struct;
venue.location = location;
venue.title = title;
venue.address = address;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'foursquare_id'
            venue.foursquare_id = (varargin{2});
        case 'foursquare_type'
            venue.foursquare_type = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end