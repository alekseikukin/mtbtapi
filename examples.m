%%%%%%%%%%%% set telegram bot token %%%%%%%%%%%%%%%%%%%
MyBot=telegram_bot('123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11'); % see here how to get token https://core.telegram.org/bots
%%%%%%%%%%%%%% get info about bot%%%%%%%%%%%%%%%%%%%%
BotInfo = MyBot.getMe;
disp('This was returned by MyBot.getMe:');
disp(BotInfo);
ChatID = '';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% recive a message %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (PS: to recive something, send something to this bot...)
% (PPS: in groups bot can resive message that stratt from "/", for
% example "/start")
for i = 1:12
    ExampleRecivedMessages = MyBot.getUpdates('allowed_updates', {'message',...
        'edited_message',...
        'channel_post',...
        'edited_channel_post',...
        'inline_query',...
        'chosen_inline_result',...
        'callback_query',...
        'shipping_query',...
        'pre_checkout_query',...
        'poll',...
        'poll_answer',...
        'my_chat_member',...
        'chat_member'});
    if ~isempty(ExampleRecivedMessages().result())
        disp('This was in the last message to bot:');
        if iscell(ExampleRecivedMessages.result(end))
            last_result = ExampleRecivedMessages.result{end};
        else
            last_result = ExampleRecivedMessages.result(end);
        end
        disp(last_result.message);
        ChatID = last_result.message.chat.id;
        disp(['From the chat #' char(string(ChatID))])
        disp(['Last update ID is: ' char(string(last_result.update_id))]);
        break;
    else
        disp('No messages today yet');
        disp(ExampleRecivedMessages(end).result());
        pause(5);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% in this chat bot will send messages %%%%%%%%%%%%%%
% ChatID = ; %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% how make keyboard %%%%%%%%%%%%%%%%%%%%
FirstLineKeyboard = {'\1', '2', '3'}; % be careful with symbols
ExampleButton =  InlineKeyboardButton_T('"6"', 'callback_data', 7);
SecondLineKeyboard = {KeyboardButton_T('send contact', 'request_contact', true), ExampleButton};
ExampleKeyboard = ReplyKeyboardMarkup_T({FirstLineKeyboard, SecondLineKeyboard, {'third line'}},...
    'one_time_keyboard', true, ...
    'resize_keyboard', true);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% concate a message %%%%%%%%%%%%%%%%%%%%%%%%%
MyMessage = ['<i>Hellow, my name is </i><b>' char(string(BotInfo.first_name)) '</b>'...
    newline...
    '<i>My ID is </i><b>' char(string(BotInfo.id)) '</b>'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% send messages with differen content %%%%%%%%%%%%%%
if ~isempty(ChatID)
    MyBot.sendMessage(ChatID, MyMessage,... % simple text
        'parse_mode', 'HTML',... % format of text
        'reply_markup', ExampleKeyboard); % keyboard
    MyBot.sendDocument(...% Send any type of files 'txt' just for example
        ChatID, 'document_file', 'test_document.txt',... 
        'usepm', true,... % show progress monitor
        'thumbf', 'test_thumb.jpg'); % file with thumb of document
    MyBot.sendPhoto(ChatID, 'photo_file', 'test_photo.jpg',... % photo
        'usepm', true,... % show progress monitor
        'caption', 'nice photo with a road'); %caption of photo
    MyBot.sendDice(ChatID); % Dice
else
    disp(["No chat ID" newline ...
        "point chat ID or send message to the bot"]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%