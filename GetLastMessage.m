function message1 = GetLastMessage(update_inform, varargin)
% GetLastMessage return text of last chat message from getUpdate
%
% update_inform - message returned by function getUpdates of telegram bot
%
% no_messages - string optional. message that will be showed if no messages
%
% show_in_CW - bool optional. will show a messages in the Command Window
%
no_messages = '@NoMessages';
show_in_CW  = false;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'no_messages'
            no_messages = varargin{2};
        case 'show_in_cw'
            show_in_CW = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
if  isempty(update_inform.result)
    message1 = no_messages;
else
    k = update_inform.result(end);
    if iscell(k)
        message1 = k{1}.message.text;
    else
        message1 = (k.message.text);
    end
end
if show_in_CW
    disp(message1);
end
end
