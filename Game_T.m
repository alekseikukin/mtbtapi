function iqresult = Game_T(title, description, photo, varargin)
% Game_T - This object represents a game. Use BotFather to create and edit
% games, their short names will act as unique identifiers.
%
% title	String	Title of the game
%
% description	String	Description of the game
%
% photo	Array of PhotoSize	Photo that will be displayed in the game
% message in chats.
%
% text	String	Optional. Brief description of the game or high scores
% included in the game message. Can be automatically edited to include
% current high scores for the game when the bot calls setGameScore, or
% manually edited using editMessageText. 0-4096 characters.
%
% text_entities	Array of MessageEntity	Optional. Special entities that
% appear in text, such as usernames, URLs, bot commands, etc.
%
% animation	Animation	Optional. Animation that will be displayed in the
% game message in chats. Upload via BotFather
%
iqresult = struct;
iqresult.title = title;
iqresult.description = description;
iqresult.photo = photo;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'text'
            iqresult.text = varargin{2};
        case 'text_entities'
            iqresult.text_entities = varargin{2};
        case 'animation'
            iqresult.animation = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end