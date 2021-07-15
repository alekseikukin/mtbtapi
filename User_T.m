function user = User_T(id, is_bot, first_name, varargin)
% User_T - This object represents a Telegram user or bot.
%
% id	Integer	Unique identifier for this user or bot
%
% is_bot	Boolean	True, if this user is a bot
%
% first_name	String	User's or bot's first name
%
% last_name	String	Optional. User's or bot's last name
%
% username	String	Optional. User's or bot's username
%
% language_code	String	Optional. IETF language tag of the user's language
%
% can_join_groups	Boolean	Optional. True, if the bot can be invited to
% groups. Returned only in getMe.
%
% can_read_all_group_messages	Boolean	Optional. True, if privacy mode is
% disabled for the bot. Returned only in getMe.
%
% supports_inline_queries	Boolean	Optional. True, if the bot supports
% inline queries. Returned only in getMe.
%
user = struct;
user.id = (id);
user.is_bot = (is_bot);
user.first_name = (first_name);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'last_name'
            user.last_name = varargin{2};
        case 'username'
            user.username = varargin{2};
        case 'language_code'
            user.language_code = varargin{2};
        case 'can_join_groups'
            user.can_join_groups = varargin{2};
        case 'can_read_all_group_messages'
            user.can_read_all_group_messages = varargin{2};
        case 'supports_inline_queries'
            user.supports_inline_queries = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end