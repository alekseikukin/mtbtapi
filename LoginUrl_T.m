function log_url = LoginUrl_T(url,varargin)
%LoginUrl_T  This object represents a parameter of the inline keyboard button
%used to automatically authorize a user. Serves as a great replacement for
%the Telegram Login Widget when the user is coming from Telegram. All the
%user needs to do is tap/click a button and confirm that they want to log
%in
%
% url	String	An HTTP URL to be opened with user authorization data added
% to the query string when the button is pressed. If the user refuses to
% provide authorization data, the original URL without information about
% the user will be opened. The data added is the same as described in
% Receiving authorization data. NOTE: You must always check the hash of the
% received data to verify the authentication and the integrity of the data
% as described in Checking authorization.
%
% forward_text	String	Optional. New text of the button in forwarded
% messages.
%
% bot_username	String	Optional. Username of a bot, which will be used for
% user authorization. See Setting up a bot for more details. If not
% specified, the current bot's username will be assumed. The url's domain
% must be the same as the domain linked with the bot. See Linking your
% domain to the bot for more details.
%
% request_write_access	Boolean	Optional. Pass True to request the
% permission for your bot to send messages to the user.
%
log_url = struct;
log_url.url = url;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'forward_text'
            log_url.forward_text = varargin{2};
        case 'bot_username'
            log_url.bot_username = varargin{2};
        case 'request_write_access'
            log_url.request_write_access = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end

