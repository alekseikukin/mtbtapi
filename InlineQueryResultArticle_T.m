function iqresult = InlineQueryResultArticle_T(id, title,...
    input_message_content, varargin)
% InlineQueryResultArticle_T - Represents a link to an article or web page.
%
% type	String	Type of the result, must be article
%
% id	String	Unique identifier for this result, 1-64 Bytes
%
% title	String	Title of the result
%
% input_message_content	InputMessageContent	Content of the message to be
% sent
%
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
%
% url	String	Optional. URL of the result
%
% hide_url	Boolean	Optional. Pass True, if you don't want the URL to be
% shown in the message
%
% description	String	Optional. Short description of the result
%
% thumb_url	String	Optional. Url of the thumbnail for the result
%
% thumb_width	Integer	Optional. Thumbnail width
%
% thumb_height	Integer	Optional. Thumbnail height
%
iqresult = struct;
iqresult.type = 'article';
iqresult.id = id;
iqresult.title = title;
iqresult.input_message_content = input_message_content;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'url'
            iqresult.url = varargin{2};
        case 'hide_url'
            iqresult.hide_url = varargin{2};
        case 'description'
            iqresult.description = varargin{2};
        case 'thumb_url'
            iqresult.thumb_url = varargin{2};
        case 'thumb_width'
            iqresult.thumb_width = varargin{2};
        case 'thumb_height'
            iqresult.thumb_height = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end %switch
    varargin(1:2) = [];
end % while isempty
end