function messageentity = MessageEntity_T(type, offset, length, varargin)
% MessageEntity_T This object represents one special entity in a text
% message. For example, hashtags, usernames, URLs, etc.
%
% type - String	Type of the entity. Can be “mention” (@username), “hashtag”
% (#hashtag), “cashtag” ($USD), “bot_command” (/start@jobs_bot), “url”
% (https://telegram.org), “email” (do-not-reply@telegram.org),
% “phone_number” (+1-212-555-0123), “bold” (bold text), “italic” (italic
% text), “underline” (underlined text), “strikethrough” (strikethrough
% text), “code” (monowidth string), “pre” (monowidth block), “text_link”
% (for clickable text URLs), “text_mention” (for users without usernames)
%
% offset - Integer	Offset in UTF-16 code units to the start of the entity
%
% length - Integer	Length of the entity in UTF-16 code units
%
% url -	String	Optional. For “text_link” only, url that will be opened
% after user taps on the text
%
% user - User	Optional. For “text_mention” only, the mentioned user
%
% language - String	Optional. For “pre” only, the programming language of
% the entity text
%
messageentity = struct;
messageentity.type = (type);
messageentity.offset = (offset);
messageentity.length = (length);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'url'
            messageentity.url = (varargin{2});
        case 'user'
            messageentity.user = varargin{2};
        case 'language'
            messageentity.language = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end

end

