function iqresult = InlineQueryResultVenue_T(id, latitude,longitude, ...
    title, address, varargin)
% InlineQueryResultVenue_T Represents a venue. By default, the venue will
% be sent by the user. Alternatively, you can use input_message_content to
% send a message with the specified content instead of the venue.
%
% type	String	Type of the result, must be venue
% 
% id	String	Unique identifier for this result, 1-64 Bytes
% 
% latitude	Float	Latitude of the venue location in degrees
% 
% longitude	Float	Longitude of the venue location in degrees
% 
% title	String	Title of the venue
% 
% address	String	Address of the venue
% 
% foursquare_id	String	Optional. Foursquare identifier of the venue if
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
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
% 
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the venue
% 
% thumb_url	String	Optional. Url of the thumbnail for the result
% 
% thumb_width	Integer	Optional. Thumbnail width
% 
% thumb_height	Integer	Optional. Thumbnail height
%
iqresult = struct;
iqresult.type = 'location';
iqresult.id = id;
iqresult.title = latitude;
iqresult.title = longitude;
iqresult.title = title;
iqresult.title = address;

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