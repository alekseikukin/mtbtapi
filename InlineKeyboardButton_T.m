function Button = InlineKeyboardButton_T(text, varargin)
% InlineKeyboardButton_T - This object represents one button of an inline
% keyboard. You must use exactly one of the optional fields.
% 
% text	String	Label text on the button
% 
% url	String	Optional. HTTP or tg:// url to be opened when button is
% pressed
% 
% login_url	LoginUrl	Optional. An HTTP URL used to automatically
% authorize the user. Can be used as a replacement for the Telegram Login
% Widget.
% 
% callback_data	String	Optional. Data to be sent in a callback query to
% the bot when button is pressed, 1-64 bytes
% 
% switch_inline_query	String	Optional. If set, pressing the button will
% prompt the user to select one of their chats, open that chat and insert
% the bot's username and the specified inline query in the input field. Can
% be empty, in which case just the bot's username will be inserted. Note:
% This offers an easy way for users to start using your bot in inline mode
% when they are currently in a private chat with it. Especially useful when
% combined with switch_pm… actions – in this case the user will be
% automatically returned to the chat they switched from, skipping the chat
% selection screen.
% 
% switch_inline_query_current_chat	String	Optional. If set, pressing the
% button will insert the bot's username and the specified inline query in
% the current chat's input field. Can be empty, in which case only the
% bot's username will be inserted. This offers a quick way for the user to
% open your bot in inline mode in the same chat – good for selecting
% something from multiple options.
% 
% callback_game	CallbackGame	Optional. Description of the game that will
% be launched when the user presses the button. NOTE: This type of button
% must always be the first button in the first row.
% 
% pay	Boolean	Optional. Specify True, to send a Pay button. NOTE: This
% type of button must always be the first button in the first row.
% 
Button = struct;
Button.text = (text);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'url'
            Button.url = varargin{2};
        case 'login_url'
            Button.login_url = varargin{2};
        case 'callback_data'
            Button.callback_data = varargin{2};
        case 'switch_inline_query'
            Button.switch_inline_query = varargin{2};
        case 'switch_inline_query_current_chat'
            Button.switch_inline_query_current_chat = varargin{2};
        case 'callback_game'
            Button.callback_game = varargin{2};
        case 'pay'
            Button.pay = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end

