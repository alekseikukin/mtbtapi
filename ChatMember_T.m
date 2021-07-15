function chatmember = ChatMember_T(user,status, varargin)
% ChatMember_T  - This object contains information about one member of a chat.
%
% user	User	Information about the user
%
% status	String	The member's status in the chat. Can be “creator”,
% “administrator”, “member”, “restricted”, “left” or “kicked”
%
% custom_title	String	Optional. Owner and administrators only. Custom
% title for this user
%
% until_date	Integer	Optional. Restricted and kicked only. Date when
% restrictions will be lifted for this user; unix time
%
% can_be_edited	Boolean	Optional. Administrators only. True, if the bot is
% allowed to edit administrator privileges of that user
%
% can_post_messages	Boolean	Optional. Administrators only. True, if the
% administrator can post in the channel; channels only
%
% can_edit_messages	Boolean	Optional. Administrators only. True, if the
% administrator can edit messages of other users and can pin messages;
% channels only
%
% can_delete_messages	Boolean	Optional. Administrators only. True, if the
% administrator can delete messages of other users
%
% can_restrict_members	Boolean	Optional. Administrators only. True, if the
% administrator can restrict, ban or unban chat members
%
% can_promote_members	Boolean	Optional. Administrators only. True, if the
% administrator can add new administrators with a subset of their own
% privileges or demote administrators that he has promoted, directly or
% indirectly (promoted by administrators that were appointed by the user)
%
% can_change_info	Boolean	Optional. Administrators and restricted only.
% True, if the user is allowed to change the chat title, photo and other
% settings
%
% can_invite_users	Boolean	Optional. Administrators and restricted only.
% True, if the user is allowed to invite new users to the chat
%
% can_pin_messages	Boolean	Optional. Administrators and restricted only.
% True, if the user is allowed to pin messages; groups and supergroups only
%
% is_member	Boolean	Optional. Restricted only. True, if the user is a
% member of the chat at the moment of the request
%
% can_send_messages	Boolean	Optional. Restricted only. True, if the user is
% allowed to send text messages, contacts, locations and venues
%
% can_send_media_messages	Boolean	Optional. Restricted only. True, if the
% user is allowed to send audios, documents, photos, videos, video notes
% and voice notes
%
% can_send_polls	Boolean	Optional. Restricted only. True, if the user is
% allowed to send polls
%
% can_send_other_messages	Boolean	Optional. Restricted only. True, if the
% user is allowed to send animations, games, stickers and use inline bots
%
% can_add_web_page_previews	Boolean	Optional. Restricted only. True, if the
% user is allowed to add web page previews to their messages
%
chatmember = struct;
chatmember.user = user;
chatmember.status = status;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'custom_title'
            chatmember.custom_title = varargin{2};
        case 'until_date'
            chatmember.until_date = varargin{2};
        case 'can_be_edited'
            chatmember.can_be_edited = varargin{2};
        case 'can_post_messages'
            chatmember.can_post_messages = varargin{2};
        case 'can_edit_messages'
            chatmember.can_edit_messages = varargin{2};
        case 'can_delete_messages'
            chatmember.can_delete_messages = varargin{2};
        case 'can_restrict_members'
            chatmember.can_restrict_members = varargin{2};
        case 'can_promote_members'
            chatmember.can_promote_members = varargin{2};
        case 'can_change_info'
            chatmember.can_change_info = varargin{2};
        case 'can_invite_users'
            chatmember.can_invite_users = varargin{2};
        case 'can_pin_messages'
            chatmember.can_pin_messages = varargin{2};
        case 'is_member'
            chatmember.is_member = varargin{2};
        case 'can_send_messages'
            chatmember.can_send_messages = varargin{2};
        case 'can_send_media_messages'
            chatmember.can_send_media_messages = varargin{2};
        case 'can_send_polls'
            chatmember.can_send_polls = varargin{2};
        case 'can_send_other_messages'
            chatmember.can_send_other_messages = varargin{2};
        case 'can_add_web_page_previews'
            chatmember.can_add_web_page_previews = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
chatmember = jsonencode(chatmember);

end

