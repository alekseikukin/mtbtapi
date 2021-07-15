function CallbackQuery = CallbackQuery_T(id, from,varargin)
% CallbackQuery_T - This object represents an incoming callback query from a
% callback button in an inline keyboard. If the button that originated the
% query was attached to a message sent by the bot, the field message will
% be present. If the button was attached to a message sent via the bot (in
% inline mode), the field inline_message_id will be present. Exactly one of
% the fields data or game_short_name will be present.
%
% id	String	Unique identifier for this query
%
% from	User	Sender
%
% message	Message	Optional. Message with the callback button that
% originated the query. Note that message content and message date will not
% be available if the message is too old
%
% inline_message_id	String	Optional. Identifier of the message sent via
% the bot in inline mode, that originated the query.
%
% chat_instance	String	Global identifier, uniquely corresponding to the
% chat to which the message with the callback button was sent. Useful for
% high scores in games.
%
% data	String	Optional. Data associated with the callback button. Be
% aware that a bad client can send arbitrary data in this field.
%
% game_short_name	String	Optional. Short name of a Game to be returned,
% serves as the unique identifier for the game
%
CallbackQuery = struct;
CallbackQuery.id = id;
CallbackQuery.from = from;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'message'
            CallbackQuery.message = varargin{2};
        case 'inline_message_id'
            CallbackQuery.inline_message_id = varargin{2};
        case 'chat_instance'
            CallbackQuery.chat_instance = varargin{2};
        case 'data'
            CallbackQuery.data = varargin{2};
        case 'game_short_name'
            CallbackQuery.game_short_name = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end

