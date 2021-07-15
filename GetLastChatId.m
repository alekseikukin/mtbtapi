function chat_id = GetLastChatId(update_inform)
%GetLastChatId - return id of last chat from getUpdate
chat_id = (update_inform(end).message.chat.id);
end
