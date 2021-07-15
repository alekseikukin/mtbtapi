function chatpermissions = ChatPermissions_T(varargin)
% ChatPermissions_T  - Describes actions that a non-administrator user is
% allowed to take in a chat.
%
% can_send_messages	Boolean	Optional. True, if the user is allowed to send
% text messages, contacts, locations and venues
%
% can_send_media_messages	Boolean	Optional. True, if the user is allowed
% to send audios, documents, photos, videos, video notes and voice notes,
% implies can_send_messages
%
% can_send_polls	Boolean	Optional. True, if the user is allowed to send
% polls, implies can_send_messages
%
% can_send_other_messages	Boolean	Optional. True, if the user is allowed
% to send animations, games, stickers and use inline bots, implies
% can_send_media_messages
%
% can_add_web_page_previews	Boolean	Optional. True, if the user is allowed
% to add web page previews to their messages, implies
% can_send_media_messages
%
% can_change_info	Boolean	Optional. True, if the user is allowed to
% change the chat title, photo and other settings. Ignored in public
% supergroups
%
% can_invite_users	Boolean	Optional. True, if the user is allowed to
% invite new users to the chat
%
% can_pin_messages	Boolean	Optional. True, if the user is allowed to pin
% messages. Ignored in public supergroups
%
chatpermissions = struct;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'can_send_messages'
            chatpermissions.can_send_messages = (varargin{2});
        case 'can_send_media_messages'
            chatpermissions.can_send_media_messages = (varargin{2});
        case 'can_send_polls'
            chatpermissions.can_send_polls = (varargin{2});
        case 'can_send_other_messages'
            chatpermissions.can_send_other_messages = (varargin{2});
        case 'can_add_web_page_previews'
            chatpermissions.can_add_web_page_previews = (varargin{2});
        case 'can_change_info'
            chatpermissions.can_change_info = (varargin{2});
        case 'can_invite_users'
            chatpermissions.can_invite_users = (varargin{2});
        case 'can_pin_messages'
            chatpermissions.can_pin_messages = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
chatpermissions = jsonencode(chatpermissions);
end

