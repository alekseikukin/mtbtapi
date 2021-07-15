function iquery = InlineQuery_T(id,from, query, offset,  varargin)
% InlineQuery_T - This object represents an incoming inline query. When the
% user sends an empty query, your bot could return some default or trending
% results.
%
% id	String	Unique identifier for this query
%
% from	User	Sender
%
% location	Location	Optional. Sender location, only for bots that
% request user location
%
% query	String	Text of the query (up to 256 characters)
%
% offset	String	Offset of the results to be returned, can be controlled
% by the bot
%
iquery = struct;
iquery.id = id;
iquery.from = from;
iquery.query = query;
iquery.offset = offset;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'location'
            iquery.location = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end

