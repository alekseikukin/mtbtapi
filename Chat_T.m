function chat = Chat_T(id, type, varargin)
% Chat_T - This object represents a chat.
%
% id	Integer	Unique identifier for this chat. This number may be greater
% than 32 bits and some programming languages may have difficulty/silent
% defects in interpreting it. But it is smaller than 52 bits, so a signed
% 64 bit integer or double-precision float type are safe for storing this
% identifier.
%
% type	String	Type of chat, can be either “private”, “group”,
% “supergroup” or “channel”
%
% title	String	Optional. Title, for supergroups, channels and group chats
%
% username	String	Optional. Username, for private chats, supergroups and
% channels if available
%
% first_name	String	Optional. First name of the other party in a
% private chat
%
% last_name	String	Optional. Last name of the other party in a private
% chat
%
% photo	ChatPhoto	Optional. Chat photo. Returned only in getChat.
%
% description	String	Optional. Description, for groups, supergroups and
% channel chats. Returned only in getChat.
%
% invite_link	String	Optional. Chat invite link, for groups, supergroups
% and channel chats. Each administrator in a chat generates their own
% invite links, so the bot must first generate the link using
% exportChatInviteLink. Returned only in getChat.
%
% pinned_message	Message	Optional. Pinned message, for groups,
% supergroups and channels. Returned only in getChat.
%
% permissions	ChatPermissions	Optional. Default chat member permissions,
% for groups and supergroups. Returned only in getChat.
%
% slow_mode_delay	Integer	Optional. For supergroups, the minimum allowed
% delay between consecutive messages sent by each unpriviledged user.
% Returned only in getChat.
%
% sticker_set_name	String	Optional. For supergroups, name of group
% sticker set. Returned only in getChat.
%
% can_set_sticker_set	Boolean	Optional. True, if the bot can change the
% group sticker set. Returned only in getChat.
%
chat = struct;
chat.id = (id);
chat.type = (type);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'title'
            chat.title = varargin{2};
        case 'username'
            chat.username = varargin{2};
        case 'first_name'
            chat.first_name = varargin{2};
        case 'last_name'
            chat.last_name = varargin{2};
        case 'photo'
            chat.photo = varargin{2};
        case 'description'
            chat.description = varargin{2};
        case 'invite_link'
            chat.invite_link = varargin{2};
        case 'pinned_message'
            chat.pinned_message = varargin{2};
        case 'permissions'
            chat.permissions = varargin{2};
        case 'slow_mode_delay'
            chat.slow_mode_delay = varargin{2};
        case 'sticker_set_name'
            chat.sticker_set_name = varargin{2};
        case 'can_set_sticker_set'
            chat.can_set_sticker_set = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end

end

