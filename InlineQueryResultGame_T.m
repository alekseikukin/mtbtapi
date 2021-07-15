function iqresult = InlineQueryResultGame_T(id, game_short_name, varargin)
% InlineQueryResultGame_T Represents a Game.
%
% type	String	Type of the result, must be game
% 
% id	String	Unique identifier for this result, 1-64 bytes
% 
% game_short_name	String	Short name of the game
% 
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
%
iqresult = struct;
iqresult.type = 'game';
iqresult.id = id;
iqresult.game_short_name = game_short_name;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end