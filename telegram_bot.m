classdef telegram_bot
    % TELEGRAMM_BOT - tool for working with telegram bots It can receive
    % and send telegtamm chat messages. 
    % Author Aleksei Kukin, 2021
    % You can get a token of a bot as
    % follow: https://core.telegram.org/bots#botfather
    % see also https://core.telegram.org/bots
    % and https://core.telegram.org/bots/api
    % and https://core.telegram.org/bots/faq
    %%
    properties
        token; % token of telegramm bot. see: https://core.telegram.org/bots#botfather
    end
    properties (Constant)%%
        api_address = 'https://api.telegram.org/bot';
    end
    properties  (Access = private)
        main_url;
    end
    %%% methods
    methods
        %%        function obj = telegram_bot(token)
        
        function obj = telegram_bot(token)
            % telegramm_bot.  Set token of this bot.
            %  to get token see: https://core.telegram.org/bots#botfather
            obj.token = token;
            obj.main_url =  [obj.api_address token '/'];
        end % init bot
        %%         function update_inform = getMe(obj)
        
        function update_inform = getMe(obj)
            % getMe A simple method for testing your bot's auth token.
            % Requires no parameters. Returns basic information about the
            % bot in form of a User object.
            send_string = [ obj.main_url  'getMe' ];
            update_inform = webread(send_string).result;
        end % function getMe
        %%
        function update_inform = logOut(obj)
            % Use this method to log out from the cloud Bot API server
            % before launching the bot locally. You must log out the bot
            % before running it locally, otherwise there is no guarantee
            % that the bot will receive updates. After a successful call,
            % you can immediately log in on a local server, but will not be
            % able to log in back to the cloud Bot API server for 10
            % minutes. Returns True on success. Requires no parameters.
            send_string = [ obj.main_url  'logOut' ];
            update_inform = webread(send_string).result;
        end % function logOut
        %%
        function update_inform = close(obj)
            % Use this method to close the bot instance before moving it
            % from one local server to another. You need to delete the
            % webhook before calling this method to ensure that the bot
            % isn't launched again after server restart. The method will
            % return error 429 in the first 10 minutes after the bot is
            % launched. Returns True on success. Requires no parameters.
            send_string = [ obj.main_url  'close' ];
            update_inform = webread(send_string).result;
        end % function close
        %%
        function update_inform = deleteWebhook(obj)
            % deleteWebhook Use this method to remove webhook integration
            % if you decide to switch back to getUpdates. Returns True on
            % success. Requires no parameters.
            send_string = [ obj.main_url  'deleteWebhook' ];
            update_inform = webread(send_string).result;
        end % function deleteWebhook
        %%
        function update_inform = getWebhookInfo(obj)
            % getWebhookInfo Use this method to get current webhook status.
            % Requires no parameters. On success, returns a WebhookInfo
            % object. If the bot is using getUpdates, will return an object
            % with the url field empty.
            send_string = [ obj.main_url  'getWebhookInfo' ];
            update_inform = webread(send_string).result;
        end % function getWebhookInfo
        %%
        function response = getUpdates(obj, varargin)
            % getUpdates Use this method to receive incoming updates using
            % long polling. An Array of Update objects is returned. Can
            % return an empty result if no a messages.
            %
            % offset	Integer	Optional	Identifier of the first update
            % to be returned. Must be greater by one than the highest among
            % the identifiers of previously received updates. By default,
            % updates starting with the earliest unconfirmed update are
            % returned. An update is considered confirmed as soon as
            % getUpdates is called with an offset higher than its
            % update_id. The negative offset can be specified to retrieve
            % updates starting from -offset update from the end of the
            % updates queue. All previous updates will forgotten.
            %
            % limit	Integer	Optional	Limits the number of updates to be
            % retrieved. Values between 1-100 are accepted. Defaults to
            % 100.
            %
            % timeout	Integer	Optional	Timeout in seconds for long
            % polling. Defaults to 0, i.e. usual short polling. Should be
            % positive, short polling should be used for testing purposes
            % only.
            %
            % allowed_updates	Array of String	Optional	A
            % JSON-serialized list of the update types you want your bot to
            % receive. For example, specify [“message”,
            % “edited_channel_post”, “callback_query”] to only receive
            % updates of these types. See Update for a complete list of
            % available update types. Specify an empty list to receive all
            % updates regardless of type (default). If not specified, the
            % previous setting will be used.
            % Please note that this parameter doesn't affect updates
            % created before the call to the getUpdates, so unwanted
            % updates may be received for a short period of time.
            %
            % ResponseTimeout Seconds to wait to receive the initial
            % response (header) from the server after sending the last
            % packet of a request, specified as an integer. The default
            % value is Inf. If this timeout is
            % exceeded, then MATLAB closes the connection and throws an
            % error.
            % Use ResponseTimeout to limit the wait time when sending a
            % request to a server through a proxy, since ConnectTimeout
            % only applies to the proxy connection time.
            % ResponseTimeout is equivalent to the Timeout property set by
            % weboptions.
            %
            comand = 'getUpdates';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.timeout =  '100';
            params.offset =  'None';
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'offset'
                        params.offset = (varargin{2});
                    case 'limit'
                        params.limit = (varargin{2});
                    case 'timeout'
                        params.timeout = (varargin{2});
                    case 'allowed_updates'
                        params.allowed_updates = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function  getUpdates
        %%
        function response = setWebhook(obj, url, varargin)
            % setWebhook Use this method to specify a url and receive
            % incoming updates via an outgoing webhook. Whenever there is
            % an update for the bot, we will send an HTTPS POST request to
            % the specified url, containing a JSON-serialized Update. In
            % case of an unsuccessful request, we will give up after a
            % reasonable amount of attempts. Returns True on success.
            %
            % If you'd like to make sure that the Webhook request comes
            % from Telegram, we recommend using a secret path in the URL,
            % e.g. https://www.example.com/<token>. Since nobody else knows
            % your bot's token, you can be pretty sure it's us.
            %
            % url	String	Required	HTTPS url to send updates to. Use
            % an empty string to remove webhook integration
            %
            % certificate	InputFile	Optional	Upload your public key
            % certificate so that the root certificate in use can be
            % checked. See our self-signed guide for details.
            %
            % max_connections	Integer	Optional	Maximum allowed number
            % of simultaneous HTTPS connections to the webhook for update
            % delivery, 1-100. Defaults to 40. Use lower values to limit
            % the load on your bot's server, and higher values to increase
            % your bot's throughput.
            %
            % allowed_updates	Array of String	Optional	A
            % JSON-serialized list of the update types you want your bot to
            % receive. For example, specify [“message”,
            % “edited_channel_post”, “callback_query”] to only receive
            % updates of these types. See Update for a complete list of
            % available update types. Specify an empty list to receive all
            % updates regardless of type (default). If not specified, the
            % previous setting will be used.
            % Please note that this parameter doesn't affect updates
            % created before the call to the setWebhook, so unwanted
            % updates may be received for a short period of time.
            %
            comand = 'setWebhook';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.url = url;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'allowed_updates'
                        params.allowed_updates =(varargin{2});
                    case 'max_connections'
                        params.max_connections =(varargin{2});
                    case 'ip_address'
                        params.ip_address =(varargin{2});
                    case 'certificate'
                        params.certificate = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'usepm'
                        usePM = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end % switch
                varargin(1:2) = [ ];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);            %
            response = resp.Body.Data; %extract data from ansver of server
        end % function setWebhook
        %%
        function response = sendMessage(obj, chat_id, text, varargin)
            % sendMessage Use this method to send text messages. On
            % success, the sent Message is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier
            % for the target chat or username of the target channel (in the
            % format @channelusername)
            %
            % text	String	Required	Text of the message to be sent,
            % 1-4096 characters after entities parsing
            %
            % parse_mode	String	Optional	Mode for parsing entities
            % in the message text. See formatting options for more details.
            %
            % disable_web_page_preview	Boolean	Optional	Disables link
            % previews for links in this message
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            comand = 'sendMessage';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            params.text = (text);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'parse_mode'
                        params.parse_mode = varargin{2};
                    case 'disable_web_page_preview'
                        params.disable_web_page_preview = varargin{2};
                    case 'disable_notification'
                        params.disable_notification = varargin{2};
                    case 'reply_to_message_id'
                        params.reply_to_message_id = varargin{2};
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendMessage
        %%
        function response = forwardMessage(obj, chat_id, from_chat_id,...
                message_id, varargin)
            % forwardMessage Use this method to forward messages of any
            % kind. On success, the sent Message is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % from_chat_id	Integer or String	Required	Unique identifier for
            % the chat where the original message was sent (or channel
            % username in the format @channelusername)
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % message_id	Integer	Required	Message identifier in the chat
            % specified in from_chat_id
            %
            comand = 'forwardMessage';
            params = struct;
            usePM = false;
            params.chat_id = (chat_id);
            params.from_chat_id = (from_chat_id);
            params.message_id = (message_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'disable_notification'
                        params.disable_notification = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function forwardMessage
        %%
        function response = sendPhoto(obj, chat_id, varargin)
            % sendPhoto - Use this method to send photos. On success,
            % the sent Message is returned.
            %
            % Parameter	Type	Required	Description
            %
            % chat_id	-Integer or String -	Required	Unique
            % identifier for the target chat or username of the
            % target channel (in the format @channelusername)
            %
            %  photo_file -	upload file and send
            %  photo_url - send photo by url
            %  photo_id - send photo by id
            %             Photo to send. Pass a file_id as String to send a photo that
            %             exists on the Telegram servers (recommended), pass an HTTP
            %             URL as a String for Telegram to get a photo from the
            %             Internet, or upload a new photo using multipart/form-data.
            %
            % caption -	String -	Optional	Photo caption (may also be
            % used when resending photos by file_id), 0-1024 characters
            % after entities parsing
            %
            % parse_mode -	String -	Optional	Mode for parsing entities in
            % the photo caption. See formatting options for more details.
            %
            % disable_notification -	Boolean -	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id -	Integer -	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %             ReplyKeyboardMarkup or
            %             ReplyKeyboardRemove or
            %             ForceReply -	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendPhoto';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'photo_id'
                        params.photo =(varargin{2});
                    case 'photo_url'
                        params.photo =(varargin{2});
                    case 'photo_file'
                        params.photo = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'caption'
                        params.caption = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification =(varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id =(varargin{2});
                    case 'reply_markup'
                        params.reply_markup =(varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function sendPhoto
        %%
        function response = sendAudio(obj, chat_id, varargin)
            %           sendAudio
            % Use this method to send audio files, if you want Telegram
            % clients to display them in the music player.
            %             Your audio must be in the .MP3 or .M4A format.
            % On success, the sent Message is returned. Bots can currently
            % send audio files of up to 50 MB in size, this limit may be
            % changed in the future. For sending voice messages, use the
            % sendVoice method instead.
            %
            % chat_id -	Integer or String -	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % audio_file
            % audio_url
            % audio_id - InputFile or String -	Required	Audio file to send. Pass a
            % file_id as String to send an audio file that exists on the
            % Telegram servers (recommended), pass an HTTP URL as a String
            % for Telegram to get an audio file from the Internet, or
            % upload a new one using multipart/form-data. More info on
            % Sending Files »
            %
            % caption -	String -	Optional.	Audio caption, 0-1024
            % characters after entities parsing
            %
            % parse_mode -	String -	Optional.	Mode for parsing entities
            % in the audio caption. See formatting options for more
            % details.
            %
            % duration -	Integer -	Optional.	Duration of the audio in
            % seconds
            %
            % performer -	String -	Optional.	Performer
            %
            % title -	String -	Optional.	Track name
            %
            % thumbf -	InputFile or
            % thumbs - String -	Optional.	Thumbnail of the file
            % sent; can be ignored if thumbnail generation for the file is
            % supported server-side. The thumbnail should be in JPEG format
            % and less than 200 kB in size. A thumbnail‘s width and height
            % should not exceed 320. Ignored if the file is not uploaded
            % using multipart/form-data. Thumbnails can’t be reused and can
            % be only uploaded as a new file, so you can pass
            % “attach://<file_attach_name>” if the thumbnail was uploaded
            % using multipart/form-data under <file_attach_name>. More info
            % on Sending Files »
            %
            % disable_notification - Boolean	Optional.	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id -	Integer	Optional.	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %                   ReplyKeyboardMarkup or
            %                   ReplyKeyboardRemove or
            %                   ForceReply    -     Optional.	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendAudio';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'audio_id'
                        params.audio =(varargin{2});
                    case 'audio_url'
                        params.audio =(varargin{2});
                    case 'audio_file'
                        params.audio = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'caption'
                        params.caption = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = (varargin{2});
                    case 'duration'
                        params.duration = (varargin{2});
                    case 'performer'
                        params.performer = (varargin{2});
                    case 'title'
                        params.title = (varargin{2});
                    case 'thumbf'
                        params.thumb = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'thumbs'
                        params.thumb = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %% function sendAudio
        %%
        function response = sendDocument(obj, chat_id, varargin)
            % sendDocument Use this method to send general files. On
            % success, the sent Message is returned. Bots can currently
            % send files of any type of up to 50 MB in size, this limit may
            % be changed in the future.
            %
            % chat_id -	Integer or String -	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % document_id,
            % document_url,
            % document_file -	String -	File to send. Pass a
            % file_id as String to send a file that exists on the Telegram
            % servers (recommended), pass an HTTP URL as a String for
            % Telegram to get a file from the Internet, or upload a new one
            %
            % thumbf -	InputFile (pass to file) or
            % thumbs - String -	Optional.	Thumbnail of the file
            % sent; can be ignored if thumbnail generation for the file is
            % supported server-side. The thumbnail should be in JPEG format
            % and less than 200 kB in size. A thumbnail‘s width and height
            % should not exceed 320. Ignored if the file is not uploaded
            % using multipart/form-data. Thumbnails can’t be reused and can
            % be only uploaded as a new file, so you can pass
            % “attach://<file_attach_name>” if the thumbnail was uploaded
            % using multipart/form-data under <file_attach_name>. More info
            % on Sending Files »
            %
            % caption -	String -	Optional.	Audio caption, 0-1024
            % characters after entities parsing
            %
            % parse_mode -	String -	Optional.	Mode for parsing entities
            % in the audio caption. See formatting options for more
            % details.
            %
            % disable_notification - Boolean -	Optional.	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id -	Integer - Optional.	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %                   ReplyKeyboardMarkup or
            %                   ReplyKeyboardRemove or
            %                   ForceReply  -  Optional.	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendDocument';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'document_id'
                        params.document =(varargin{2});
                    case 'document_url'
                        params.document =(varargin{2});
                    case 'document_file'
                        params.document = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'thumbf'
                        params.thumb = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'thumbs'
                        params.thumb = (varargin{2});
                    case 'caption'
                        params.caption = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function sendDocument
        %%
        function response = sendVideo(obj, chat_id, varargin)
            % sendVideo - Use this method to send video files, Telegram
            % clients support mp4 videos (other formats may be sent as
            % Document). On success, the sent Message is returned. Bots can
            % currently send video files of up to 50 MB in size, this limit
            % may be changed in the future.
            %
            % chat_id -	Integer or String -	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % video_id,  -	InputFile or String -	video to send. Pass a
            % file_id as String to send a video that exists on the Telegram
            % servers (recommended), pass an HTTP URL as a String for
            % Telegram to get a video from the Internet, or upload a new
            % video using multipart/form-data.
            %
            % video_id, video_url, video_file -	String - video to send. Pass a
            % video_id as String to send a file that exists on the Telegram
            % servers (recommended), pass an HTTP URL as a String for
            % Telegram to get a file from the Internet, or upload a new one
            %
            % thumbf -	InputFile or
            % thumbs - String -	Optional.	Thumbnail of the file
            % sent; can be ignored if thumbnail generation for the file is
            % supported server-side. The thumbnail should be in JPEG format
            % and less than 200 kB in size. A thumbnail‘s width and height
            % should not exceed 320. Ignored if the file is not uploaded
            % using multipart/form-data. Thumbnails can’t be reused and can
            % be only uploaded as a new file, so you can pass
            % “attach://<file_attach_name>” if the thumbnail was uploaded
            % using multipart/form-data under <file_attach_name>. More info
            % on Sending Files »
            %
            % caption -	String -	Optional.	Audio caption, 0-1024
            % characters after entities parsing
            %
            % parse_mode -	String -	Optional.	Mode for parsing entities
            % in the audio caption. See formatting options for more
            % details.
            %
            % disable_notification - Boolean -	Optional.	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id -	Integer - Optional.	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %                   ReplyKeyboardMarkup or
            %                   ReplyKeyboardRemove or
            %                   ForceReply     -     Optional.	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            % duration - Integer - Optional	Duration of sent video in
            %seconds
            %
            %  width -	Integer -	Optional	Video width
            %
            % height -	Integer -	Optional	Video height
            %
            % supports_streaming	Boolean	Optional	Pass True, if the
            % uploaded video is suitable for streaming
            %
            comand = 'sendVideo';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'video_id'
                        params.video =(varargin{2});
                    case 'video_url'
                        params.video =(varargin{2});
                    case 'video_file'
                        params.video = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'duration'
                        params.duration =(varargin{2});
                    case 'width'
                        params.width =(varargin{2});
                    case 'height'
                        params.height =(varargin{2});
                    case 'thumbf'
                        params.thumb = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'thumbs'
                        params.thumb = (varargin{2});
                    case 'caption'
                        params.caption = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = (varargin{2});
                    case 'supports_streaming'
                        params.supports_streaming = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function sendVideo
        %%
        function response = sendAnimation(obj, chat_id, varargin)
            % sendAnimation  - Use this method to send animation files (GIF
            % or H.264/MPEG-4 AVC video without sound). On success, the
            % sent Message is returned. Bots can currently send animation
            % files of up to 50 MB in size, this limit may be changed in
            % the future.
            %
            % chat_id -	Integer or String -	Required	Unique identifier
            % for the target chat or username of the target channel (in the
            % format @channelusername)
            %
            % animation_id,
            % animation_url,
            % animation_file -	String -	File to send. Pass a
            % file_id as String to send a file that exists on the Telegram
            % servers (recommended), pass an HTTP URL as a String for
            % Telegram to get a file from the Internet, or upload a new one
            %
            % duration	Integer	Optional	Duration of sent animation in
            % seconds
            %
            % width	Integer	Optional	Animation width
            %
            % height	Integer	Optional	Animation height
            %
            % thumbf -	InputFile or
            % thumbs - String -	Optional.	Thumbnail of the file
            % sent; can be ignored if thumbnail generation for the file is
            % supported server-side. The thumbnail should be in JPEG format
            % and less than 200 kB in size. A thumbnail‘s width and height
            % should not exceed 320. Ignored if the file is not uploaded
            % using multipart/form-data. Thumbnails can’t be reused and can
            % be only uploaded as a new file, so you can pass
            % “attach://<file_attach_name>” if the thumbnail was uploaded
            % using multipart/form-data under <file_attach_name>. More info
            % on Sending Files »
            %
            % caption	String	Optional	Animation caption (may also be
            % used when resending animation by file_id), 0-1024 characters
            % after entities parsing
            %
            % parse_mode	String	Optional	Mode for parsing entities
            % in the animation caption. See formatting options for more
            % details.
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %                                  ReplyKeyboardMarkup or
            %                                  ReplyKeyboardRemove or
            %                                  ForceReply       -     Optional.	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendAnimation';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'animation_id'
                        params.animation = (varargin{2});
                    case 'animation_url'
                        params.animation = (varargin{2});
                    case 'animation_file'
                        params.animation = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'duration'
                        params.duration = (varargin{2});
                    case 'width'
                        params.width = (varargin{2});
                    case 'height'
                        params.height = (varargin{2});
                    case 'thumbf'
                        params.thumb = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'thumbs'
                        params.thumb = (varargin{2});
                    case 'caption'
                        params.caption = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function sendAnimation
        %%
        function response = sendVoice(obj, chat_id, varargin)
            % sendVoiceUse - this method to send audio files, if you want
            % Telegram clients to display the file as a playable voice
            % message. For this to work, your audio must be in an .OGG file
            % encoded with OPUS (other formats may be sent as Audio or
            % Document). On success, the sent Message is returned. Bots can
            % currently send voice messages of up to 50 MB in size, this
            % limit may be changed in the future.
            %
            % chat_id -	Integer or String -	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % voice_id,
            % voice_url,
            % voice_file -	InputFile or String -	Required	Audio file to send. Pass a
            % file_id as String to send an audio file that exists on the
            % Telegram servers (recommended), pass an HTTP URL as a String
            % for Telegram to get an audio file from the Internet, or
            % upload a new one using multipart/form-data. More info on
            % Sending Files »
            %
            % caption -	String -	Optional.	Audio caption, 0-1024
            % characters after entities parsing
            %
            % parse_mode -	String -	Optional.	Mode for parsing entities
            % in the audio caption. See formatting options for more
            % details.
            %
            % duration -	Integer -	Optional.	Duration of the audio in
            % seconds
            %
            % disable_notification - Boolean	Optional.	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id -	Integer	Optional.	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %                   ReplyKeyboardMarkup or
            %                   ReplyKeyboardRemove or
            %                   ForceReply     -    Optional.	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            usePM = false;
            ResponseTimeout = Inf;
            comand = 'sendVoice';
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'voice_id'
                        params.voice =(varargin{2});
                    case 'voice_url'
                        params.voice =(varargin{2});
                    case 'voice_file'
                        params.voice = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'caption'
                        params.caption = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = (varargin{2});
                    case 'duration'
                        params.duration =(varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function sendVoice
        %%
        function response = sendVideoNote(obj, chat_id, varargin)
            % sendVideoNoteAs of v.4.0, Telegram clients support rounded
            % square mp4 videos of up to 1 minute long. Use this method to
            % send video messages. On success, the sent Message is
            % returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % video_note	InputFile or String	Required	Video note to send.
            % Pass a file_id as String to send a video note that exists on
            % the Telegram servers (recommended) or upload a new video
            % using multipart/form-data. More info on Sending Files ».
            % Sending video notes by a URL is currently unsupported
            %
            % duration	Integer	Optional	Duration of sent video in
            % seconds
            %
            % length	Integer	Optional	Video width and height, i.e.
            % diameter of the video message
            %
            % thumbf -	InputFile or
            % thumbs - String -	Optional.	Thumbnail of the file
            % sent; can be ignored if thumbnail generation for the file is
            % supported server-side. The thumbnail should be in JPEG format
            % and less than 200 kB in size. A thumbnail‘s width and height
            % should not exceed 320. Ignored if the file is not uploaded
            % using multipart/form-data. Thumbnails can’t be reused and can
            % be only uploaded as a new file, so you can pass
            % “attach://<file_attach_name>” if the thumbnail was uploaded
            % using multipart/form-data under <file_attach_name>. More info
            % on Sending Files »
            %
            % disable_notification - Boolean	Optional.	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id -	Integer	Optional.	If the message is a
            % reply, ID of the original message
            %
            % reply_markup -	InlineKeyboardMarkup or
            %                   ReplyKeyboardMarkup or
            %                   ReplyKeyboardRemove or
            %                   ForceReply      -    Optional.	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendVideoNote';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'video_note_id'
                        params.video_note =(varargin{2});
                    case 'video_note_url'
                        params.video_note =(varargin{2});
                    case 'video_note_file'
                        params.video_note = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'duration'
                        params.duration =(varargin{2});
                    case 'length'
                        params.length =(varargin{2});
                    case 'thumbf'
                        params.thumb = ...
                            matlab.net.http.io.FileProvider((varargin{2}));
                    case 'thumbs'
                        params.thumb = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function sendVideoNote
        %%
        function response = sendMediaGroup(obj, chat_id, varargin)
            % sendMediaGroup - Use this method to send a group of photos or
            % videos as an album. On success, an array of the sent Messages
            % is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % media	Array of InputMediaPhoto and InputMediaVideo	Required	A
            % JSON-serialized array describing photos and videos to be
            % sent, must include 2-10 items
            %
            % disable_notification	Boolean	Optional	Sends the messages
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the messages are
            % a reply, ID of the original message
            %
            comand = 'sendMediaGroup';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'media'
                        params.media =(varargin{2});
                    case 'disable_notification'
                        params.disable_notification =(varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id =(varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %% function sendMediaGroup (didn't end, check "while loop"and description)
        function response = sendLocation(obj, chat_id, latitude,...
                longitude, varargin)
            % sendLocation Use this method to send point on the map. On
            % success, the sent Message is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % latitude	Float number	Required	Latitude of the location
            %
            % longitude	Float number	Required	Longitude of the location
            %
            % live_period	Integer	Optional	Period in seconds for which
            % the location will be updated (see Live Locations, should be
            % between 60 and 86400.
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendLocation';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = (chat_id);
            params.latitude = (latitude);
            params.longitude = (longitude);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'live_period'
                        params.live_period = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendLocation
        %%
        function response = editMessageLiveLocation(obj, latitude,...
                longitude, varargin)
            % editMessageLiveLocation Use this method to edit live location
            % messages. A location can be edited until its live_period
            % expires or editing is explicitly disabled by a call to
            % stopMessageLiveLocation. On success, if the edited message
            % was sent by the bot, the edited Message is returned,
            % otherwise True is returned.
            %
            % chat_id	Integer or String	Optional	Required if
            % inline_message_id is not specified. Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the message
            % to edit
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            % latitude	Float number	Required	Latitude of new location
            %
            % longitude	Float number	Required	Longitude of new location
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for a new inline keyboard.
            %
            comand = 'editMessageLiveLocation';
            ResponseTimeout = Inf;
            usePM = false;
            params = struct;
            params.latitude = (latitude);
            params.longitude = (longitude);
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function editMessageLiveLocation
        %%
        function response = stopMessageLiveLocation(obj, varargin)
            % stopMessageLiveLocation Use this method to stop updating a
            % live location message before live_period expires. On success,
            % if the message was sent by the bot, the sent Message is
            % returned, otherwise True is returned.
            %
            % chat_id	Integer or String	Optional	Required if
            % inline_message_id is not specified. Unique identifier for
            % the target chat or username of the target channel (in the
            % format @channelusername)
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the
            % message with live location to stop
            %
            % inline_message_id	String	Optional	Required if chat_id
            % and message_id are not specified. Identifier of the
            % inline message
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for a new inline keyboard.
            %
            comand = 'stopMessageLiveLocation';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function stopMessageLiveLocation(didn't end, check "while loop")
        %%
        function response = sendVenue(obj, chat_id, latitude, longitude,...
                title, address,  varargin)
            % sendVenue Use this method to send information about a venue.
            % On success, the sent Message is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % latitude	Float number	Required	Latitude of the venue
            %
            % longitude	Float number	Required	Longitude of the venue
            %
            % title	String	Required	Name of the venue
            %
            % address	String	Required	Address of the venue
            %
            % foursquare_id	String	Optional	Foursquare identifier of
            % the venue
            %
            % foursquare_type	String	Optional	Foursquare type of the
            % venue, if known. (For example, “arts_entertainment/default”,
            % “arts_entertainment/aquarium” or “food/icecream”.)
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendVenue';
            params = struct;
            usePM = false;
            params.chat_id = (chat_id);
            params.latitude = (latitude);
            params.longitude = (longitude);
            params.title = (title);
            params.address = (address);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'foursquare_id'
                        params.foursquare_id = (varargin{2});
                    case 'foursquare_type'
                        params.foursquare_type = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendVenue
        %%
        function response = sendContact(obj, chat_id, phone_number,...
                first_name, varargin)
            % sendContact Use this method to send phone contacts. On
            % success, the sent Message is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % phone_number	String	Required	Contact's phone number
            %
            % first_name	String	Required	Contact's first name
            %
            % last_name	String	Optional	Contact's last name
            %
            % vcard	String	Optional	Additional data about the contact
            % in the form of a vCard, 0-2048 bytes
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove
            % keyboard or to force a reply from the user.
            %
            comand = 'sendContact';
            usePM = false;
            params = struct;
            params.chat_id = chat_id;
            params.phone_number = phone_number;
            params.first_name = first_name;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'last_name'
                        params.last_name = varargin{2};
                    case 'vcard'
                        params.vcard = varargin{2};
                    case 'disable_notification'
                        params.disable_notification = varargin{2};
                    case 'reply_to_message_id'
                        params.reply_to_message_id = varargin{2};
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendContact
        %%
        function response = sendPoll(obj, chat_id, question, options, varargin)
            % sendPoll Use this method to send a native poll. On
            % success, the sent Message is returned.
            %
            % chat_id Integer or String Required Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % question	String	Required	Poll question, 1-255 characters
            %
            % options	Array of String	Required	A JSON-serialized list of
            % answer options, 2-10 strings 1-100 characters each
            %
            % is_anonymous	Boolean	Optional	True, if the poll needs to
            % be anonymous, defaults to True
            %
            % type	String	Optional	Poll type, “quiz” or “regular”,
            % defaults to “regular”
            %
            % allows_multiple_answers	Boolean	Optional	True, if the
            % poll allows multiple answers, ignored for polls in quiz mode,
            % defaults to False
            %
            % correct_option_id	Integer	Optional	0-based identifier of
            % the correct answer option, required for polls in quiz mode
            %
            % explanation	String	Optional	Text that is shown when a
            % user chooses an incorrect answer or taps on the lamp icon in
            % a quiz-style poll, 0-200 characters with at most 2 line feeds
            % after entities parsing
            %
            % explanation_parse_mode	String	Optional	Mode for
            % parsing entities in the explanation. See formatting options
            % for more details.
            %
            % open_period	Integer	Optional	Amount of time in seconds
            % the poll will be active after creation, 5-600. Can't be used
            % together with close_date.
            %
            % close_date	Integer	Optional	Point in time (Unix
            % timestamp) when the poll will be automatically closed. Must
            % be at least 5 and no more than 600 seconds in the future.
            % Can't be used together with open_period.
            %
            % is_closed	Boolean	Optional	Pass True, if the poll needs to
            % be immediately closed. This can be useful for poll preview.
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendPoll';
            usePM = false;
            params = struct;
            params.chat_id = chat_id;
            params.question = question;
            params.options = options;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'phone_number'
                        params.phone_number = varargin{2};
                    case 'is_anonymous'
                        params.is_anonymous = varargin{2};
                    case 'type'
                        params.type = varargin{2};
                    case 'allows_multiple_answers'
                        params.allows_multiple_answers = varargin{2};
                    case 'correct_option_id'
                        params.correct_option_id = varargin{2};
                    case 'explanation'
                        params.explanation = varargin{2};
                    case 'explanation_parse_mode'
                        params.explanation_parse_mode = varargin{2};
                    case 'open_period'
                        params.open_period = varargin{2};
                    case 'close_date'
                        params.close_date = varargin{2};
                    case 'is_closed'
                        params.is_closed = varargin{2};
                    case 'disable_notification'
                        params.disable_notification = varargin{2};
                    case 'reply_to_message_id'
                        params.reply_to_message_id = varargin{2};
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendPoll (check requaed and optional paramiters)
        %%
        function response = sendDice(obj, chat_id, varargin)
            % sendDice Use this method to send a dice, which will have a
            % random value from 1 to 6. On success, the sent Message is
            % returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % emoji	String	Optional	Emoji on which the dice throw
            % animation is based. Currently, must be one of “🎲” or “🎯”.
            % Defauts to “🎲”
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendDice';
            usePM = false;
            ResponseTimeout = Inf;
            params = struct;
            params.chat_id = chat_id;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'emoji'
                        params.emoji = varargin{2};
                    case 'disable_notification'
                        params.disable_notification = varargin{2};
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendDice
        %%
        function response = sendChatAction(obj, chat_id, action,...
                varargin)
            % sendChatAction Use this method when you need to tell the user
            % that something is happening on the bot's side. The status is
            % set for 5 seconds or less (when a message arrives from your
            % bot, Telegram clients clear its typing status). Returns True
            % on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % action	String	Required Type of action to broadcast. Choose
            % one, depending on what the user is about to receive: typing
            % for text messages, upload_photo for photos, record_video or
            % upload_video for videos, record_audio or upload_audio for
            % audio files, upload_document for general files, find_location
            % for location data, record_video_note or upload_video_note for
            % video notes.
            %
            comand = 'sendChatAction';
            params = struct;
            params.chat_id = chat_id;
            params.action = action;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end
        %%
        function response = getUserProfilePhotos(obj, user_id, varargin)
            % getUserProfilePhotos Use this method to get a list of profile
            % pictures for a user. Returns a UserProfilePhotos object.
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            % offset	Integer	Optional	Sequential number of the first
            % photo to be returned. By default, all photos are returned.
            %
            % limit	Integer	Optional	Limits the number of photos to be
            % retrieved. Values between 1-100 are accepted. Defaults to
            % 100.
            %
            comand = 'getUserProfilePhotos';
            usePM = false;
            params = struct;
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'offset'
                        params.offset = varargin{2};
                    case 'limit'
                        params.limit = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function getUserProfilePhotos
        %%
        function response = getFile(obj, file_id,...
                varargin)
            % getFile Use this method to get basic info about a file and
            % prepare it for downloading. For the moment, bots can download
            % files of up to 20MB in size. On success, a File object is
            % returned. The file can then be downloaded via the link
            % https://api.telegram.org/file/bot<token>/<file_path>, where
            % <file_path> is taken from the response. It is guaranteed that
            % the link will be valid for at least 1 hour. When the link
            % expires, a new one can be requested by calling getFile again.
            %
            % file_id	String	Required	File identifier to get info about
            %
            comand = 'getFile';
            params = struct;
            params.file_id = (file_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function getFile
        %%
        function response = kickChatMember(obj, chat_id, user_id, varargin)
            % kickChatMember Use this method to kick a user from a group, a
            % supergroup or a channel. In the case of supergroups and
            % channels, the user will not be able to return to the group on
            % their own using invite links, etc., unless unbanned first.
            % The bot must be an administrator in the chat for this to work
            % and must have the appropriate admin rights. Returns True on
            % success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target group or username of the target supergroup or channel
            % (in the format @channelusername)
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            % until_date	Integer	Optional	Date when the user will be
            % unbanned, unix time. If user is banned for more than 366 days
            % or less than 30 seconds from the current time they are
            % considered to be banned forever
            %
            comand = 'kickChatMember';
            params = struct;
            params.chat_id = (chat_id);
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'until_date'
                        params.until_date = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function kickChatMember
        %%
        function response = unbanChatMember(obj, chat_id, user_id,...
                varargin)
            % unbanChatMember Use this method to unban a previously kicked
            % user in a supergroup or channel. The user will not return to
            % the group or channel automatically, but will be able to join
            % via link, etc. The bot must be an administrator for this to
            % work. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            comand = 'unbanChatMember';
            params = struct;
            params.chat_id = (chat_id);
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function unbanChatMember
        %%
        function response = restrictChatMember(obj, chat_id, user_id,...
                permissions, varargin)
            % restrictChatMember Use this method to restrict a user in a
            % supergroup. The bot must be an administrator in the
            % supergroup for this to work and must have the appropriate
            % admin rights. Pass True for all permissions to lift
            % restrictions from a user. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target supergroup (in the
            % format @supergroupusername)
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            % permissions	ChatPermissions	Required	New user permissions
            %
            % until_date	Integer	Optional	Date when restrictions will
            % be lifted for the user, unix time. If user is restricted for
            % more than 366 days or less than 30 seconds from the current
            % time, they are considered to be restricted forever
            %
            comand = 'restrictChatMember';
            params = struct;
            params.chat_id = (chat_id);
            params.user_id = (user_id);
            params.permissions = permissions;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'until_date'
                        params.until_date = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function restrictChatMember
        %%
        function response = promoteChatMember(obj, chat_id, user_id, varargin)
            % promoteChatMember Use this method to promote or demote a user
            % in a supergroup or a channel. The bot must be an
            % administrator in the chat for this to work and must have the
            % appropriate admin rights. Pass False for all boolean
            % parameters to demote a user. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            % can_change_info	Boolean	Optional	Pass True, if the
            % administrator can change chat title, photo and other settings
            %
            % can_post_messages	Boolean	Optional	Pass True, if the
            % administrator can create channel posts, channels only
            %
            % can_edit_messages	Boolean	Optional	Pass True, if the
            % administrator can edit messages of other users and can pin
            % messages, channels only
            %
            % can_delete_messages	Boolean	Optional	Pass True, if the
            % administrator can delete messages of other users
            %
            % can_invite_users	Boolean	Optional	Pass True, if the
            % administrator can invite new users to the chat
            %
            % can_restrict_members	Boolean	Optional	Pass True, if the
            % administrator can restrict, ban or unban chat members
            %
            % can_pin_messages	Boolean	Optional	Pass True, if the
            % administrator can pin messages, supergroups only
            %
            % can_promote_members	Boolean	Optional	Pass True, if the
            % administrator can add new administrators with a subset of
            % their own privileges or demote administrators that he has
            % promoted, directly or indirectly (promoted by administrators
            % that were appointed by him)
            %
            comand = 'promoteChatMember';
            usePM = false;
            params = struct;
            params.chat_id = (chat_id);
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'can_change_info'
                        params.can_change_info = varargin{2};
                    case 'can_post_messages'
                        params.can_post_messages = varargin{2};
                    case 'can_edit_messages'
                        params.can_edit_messages = varargin{2};
                    case 'can_delete_messages'
                        params.can_delete_messages = varargin{2};
                    case 'can_invite_users'
                        params.can_invite_users = varargin{2};
                    case 'can_restrict_members'
                        params.can_restrict_members = varargin{2};
                    case 'can_pin_messages'
                        params.can_pin_messages = varargin{2};
                    case 'can_promote_members'
                        params.can_promote_members = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function promoteChatMember
        %%
        function response = setChatAdministratorCustomTitle(obj, chat_id,...
                user_id, custom_title,...
                varargin)
            % setChatAdministratorCustomTitle Use this method to set a
            % custom title for an administrator in a supergroup promoted by
            % the bot. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target supergroup (in the
            % format @supergroupusername)
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            % custom_title	String	Required	New custom title for the
            % administrator; 0-16 characters, emoji are not allowed
            %
            comand = 'setChatAdministratorCustomTitle';
            params = struct;
            params.chat_id = (chat_id);
            params.user_id = (user_id);
            params.custom_title = custom_title;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function setChatAdministratorCustomTitle
        %%
        function response = setChatPermissions(obj, chat_id, permissions,...
                varargin)
            %  setChatPermissions Use this method to set default chat
            %  permissions for all members. The bot must be an
            %  administrator in the group or a supergroup for this to work
            %  and must have the can_restrict_members admin rights. Returns
            %  True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target supergroup (in the
            % format @supergroupusername)
            %
            % permissions	ChatPermissions	Required	New default chat
            % permissions
            %
            comand = 'setChatPermissions';
            params = struct;
            params.chat_id = (chat_id);
            params.permissions = permissions;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function setChatPermissions
        %%
        function response = exportChatInviteLink(obj, chat_id,...
                varargin)
            % exportChatInviteLink Use this method to generate a new invite
            % link for a chat; any previously generated link is revoked.
            % The bot must be an administrator in the chat for this to work
            % and must have the appropriate admin rights. Returns the new
            % invite link as String on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'exportChatInviteLink';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function exportChatInviteLink
        %%
        function response = setChatPhoto(obj, chat_id, photo,...
                varargin)
            % setChatPhoto Use this method to set a new profile photo for
            % the chat. Photos can't be changed for private chats. The bot
            % must be an administrator in the chat for this to work and
            % must have the appropriate admin rights. Returns True on
            % success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % photo	InputFile	Required	New chat photo, uploaded using
            % multipart/form-data
            %
            comand = 'setChatPhoto';
            params = struct;
            params.chat_id = (chat_id);
            params.photo = ...
                matlab.net.http.io.FileProvider((photo));
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function setChatPhoto
        %%
        function response = deleteChatPhoto(obj, chat_id,...
                varargin)
            % deleteChatPhoto Use this method to delete a chat photo. Photos
            % can't be changed for private chats. The bot must be an
            % administrator in the chat for this to work and must have the
            % appropriate admin rights. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'deleteChatPhoto';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function deleteChatPhoto
        %%
        function response = setChatTitle(obj, chat_id, title,...
                varargin)
            % setChatTitle Use this method to change the title of a chat.
            % Titles can't be changed for private chats. The bot must be an
            % administrator in the chat for this to work and must have the
            % appropriate admin rights. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % title	String	Required	New chat title, 1-255 characters
            %
            comand = 'setChatTitle';
            params = struct;
            params.chat_id = (chat_id);
            params.title = title;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function setChatTitle
        %%
        function response = setChatDescription(obj, chat_id, varargin)
            % setChatDescription Use this method to change the description
            % of a group, a supergroup or a channel. The bot must be an
            % administrator in the chat for this to work and must have the
            % appropriate admin rights. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % description	String	Optional	New chat description, 0-255
            % characters
            comand = 'setChatDescription';
            usePM = false;
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'description'
                        params.description = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%  function setChatDescription
        %%
        function response = pinChatMessage(obj, chat_id, message_id,...
                varargin)
            % pinChatMessage Use this method to pin a message in a group, a
            % supergroup, or a channel. The bot must be an administrator in
            % the chat for this to work and must have the
            % 'can_pin_messages' admin right in the supergroup or
            % 'can_edit_messages' admin right in the channel. Returns True
            % on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Required	Identifier of a message to pin
            %
            % disable_notification	Boolean	Optional	Pass True, if it is
            % not necessary to send a notification to all chat members
            % about the new pinned message. Notifications are always
            % disabled in channels.
            %
            comand = 'pinChatMessage';
            params = struct;
            params.chat_id = (chat_id);
            params.message_id = (message_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'disable_notification'
                        params.disable_notification = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%%  function pinChatMessage
        %%
        function response = unpinChatMessage(obj, chat_id,...
                varargin)
            % unpinChatMessage Use this method to unpin a message in a
            % group, a supergroup, or a channel. The bot must be an
            % administrator in the chat for this to work and must have the
            % 'can_pin_messages' admin right in the supergroup or
            % 'can_edit_messages' admin right in the channel. Returns True
            % on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'unpinChatMessage';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end%%  function unpinChatMessage
        %%
        function response = leaveChat(obj, chat_id,...
                varargin)
            % leaveChat Use this method for your bot to leave a group,
            % supergroup or channel. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'leaveChat';
            params = struct;
            params.chat_id = string(chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function leaveChat
        %%
        function response = getChat(obj, chat_id,...
                varargin)
            % getChat Use this method to get up to date information about
            % the chat (current name of the user for one-on-one
            % conversations, current username of a user, group or channel,
            % etc.). Returns a Chat object on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'getChat';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function getChat
        %%
        function response = getChatAdministrators(obj, chat_id,...
                varargin)
            % getChatAdministrators Use this method to get a list of
            % administrators in a chat. On success, returns an Array of
            % ChatMember objects that contains information about all chat
            % administrators except other bots. If the chat is a group or a
            % supergroup and no administrators were appointed, only the
            % creator will be returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'getChatAdministrators';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function getChatAdministrators
        %%
        function response = getChatMembersCount(obj, chat_id,...
                varargin)
            % getChatMembersCount Use this method to get the number of
            % members in a chat. Returns Int on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'getChatMembersCount';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function getChatMembersCount
        %%
        function response = getChatMember(obj, chat_id, user_id,...
                varargin)
            % getChatMember Use this method to get information about a
            % member of a chat. Returns a ChatMember object on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % user_id	Integer	Required	Unique identifier of the target user
            %
            comand = 'getChatMember';
            params = struct;
            params.chat_id = (chat_id);
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function getChatMember
        %%
        function response = setChatStickerSet(obj, chat_id, sticker_set_name,...
                varargin)
            % setChatStickerSet Use this method to set a new group sticker
            % set for a supergroup. The bot must be an administrator in the
            % chat for this to work and must have the appropriate admin
            % rights. Use the field can_set_sticker_set optionally returned
            % in getChat requests to check if the bot can use this method.
            % Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target supergroup (in the
            % format @supergroupusername)
            %
            % sticker_set_name	String	Required	Name of the sticker set to be
            % set as the group sticker set
            %
            comand = 'setChatStickerSet';
            params = struct;
            params.chat_id = (chat_id);
            params.sticker_set_name = sticker_set_name;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function setChatStickerSet
        %%
        function response = deleteChatStickerSet(obj, chat_id,...
                varargin)
            % deleteChatStickerSet Use this method to delete a group
            % sticker set from a supergroup. The bot must be an
            % administrator in the chat for this to work and must have the
            % appropriate admin rights. Use the field can_set_sticker_set
            % optionally returned in getChat requests to check if the bot
            % can use this method. Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            comand = 'deleteChatStickerSet';
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function deleteChatStickerSet
        %%
        function response = answerCallbackQuery(obj, callback_query_id,...
                varargin)
            % answerCallbackQuery Use this method to send answers to
            % callback queries sent from inline keyboards. The answer will
            % be displayed to the user as a notification at the top of the
            % chat screen or as an alert. On success, True is returned.
            %
            % callback_query_id	String	Required	Unique identifier for the query
            % to be answered
            %
            % text	String	Optional	Text of the notification. If not
            % specified, nothing will be shown to the user, 0-200
            % characters
            %
            % show_alert	Boolean	Optional	If true, an alert will be
            % shown by the client instead of a notification at the top of
            % the chat screen. Defaults to false.
            %
            % url	String	Optional	URL that will be opened by the
            % user's client. If you have created a Game and accepted the
            % conditions via @Botfather, specify the URL that opens your
            % game — note that this will only work if the query comes from
            % a callback_game button. Otherwise, you may use links like
            % t.me/your_bot?start=XXXX that open your bot with a parameter.
            %
            % cache_time	Integer	Optional	The maximum amount of time
            % in seconds that the result of the callback query may be
            % cached client-side. Telegram apps will support caching
            % starting in version 3.14. Defaults to 0.
            %
            comand = 'answerCallbackQuery';
            params = struct;
            params.callback_query_id = (callback_query_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'text'
                        params.text = varargin{2};
                    case 'show_alert'
                        params.show_alert = varargin{2};
                    case 'url'
                        params.url = varargin{2};
                    case 'cache_time'
                        params.cache_time = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function answerCallbackQuery
        %%
        function response = setMyCommands(obj, commands, varargin)
            % setMyCommands Use this method to change the list of the bot's
            % commands. Returns True on success.
            %
            % commands	Array of BotCommand	Required	A JSON-serialized list of
            % bot commands to be set as the list of the bot's commands. At
            % most 100 commands can be specified.
            %
            comand = 'setMyCommands';
            params = struct;
            params.commands = commands;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function setMyCommands
        %%
        function response = getMyCommands(obj)
            % getMyCommands Use this method to get the current list of the
            % bot's commands. Requires no parameters. Returns Array of
            % BotCommand on success.
            comand = 'getMyCommands';
            params = struct;
            url_string = [obj.main_url, comand];
            option = weboptions('MediaType','application/json');
            response  = webwrite(url_string, params, option).result;
        end% function getMyCommands
        %%
        function response = editMessageText(obj, text, varargin)
            % editMessageText Use this method to edit text and game
            % messages. On success, if edited message is sent by the bot,
            % the edited Message is returned, otherwise True is returned.
            %
            % chat_id	Integer or String	Optional	Required if
            % inline_message_id is not specified. Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the message
            % to edit
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            % text	String	Required	New text of the message, 1-4096 characters
            % after entities parsing
            %
            % parse_mode	String	Optional	Mode for parsing entities
            % in the message text. See formatting options for more details.
            %
            % disable_web_page_preview	Boolean	Optional	Disables link
            % previews for links in this message
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for an inline keyboard.
            comand = 'editMessageText';
            usePM = false;
            params = struct;
            params.text = text;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'parse_mode'
                        params.parse_mode = varargin{2};
                    case 'disable_web_page_preview'
                        params.disable_web_page_preview = varargin{2};
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function editMessageText
        %%
        function response = editMessageCaption(obj, varargin)
            % editMessageCaption Use this method to edit captions of
            % messages. On success, if edited message is sent by the bot,
            % the edited Message is returned, otherwise True is returned.
            %
            % chat_id	Integer or String	Optional	Required if
            % inline_message_id is not specified. Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the message
            % to edit
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            % caption	String	Optional	New caption of the message,
            % 0-1024 characters after entities parsing
            %
            % parse_mode	String	Optional	Mode for parsing entities
            % in the message caption. See formatting options for more
            % details.
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for an inline keyboard.
            %
            comand = 'editMessageCaption';
            usePM = false;
            params = struct;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'caption'
                        params.caption = varargin{2};
                    case 'parse_mode'
                        params.parse_mode = varargin{2};
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function editMessageCaption
        %%
        function response = editMessageMedia(obj,media, varargin)
            % editMessageMedia Use this method to edit animation, audio,
            % document, photo, or video messages. If a message is a part of
            % a message album, then it can be edited only to a photo or a
            % video. Otherwise, message type can be changed arbitrarily.
            % When inline message is edited, new file can't be uploaded.
            % Use previously uploaded file via its file_id or specify a
            % URL. On success, if the edited message was sent by the bot,
            % the edited Message is returned, otherwise True is returned.
            %
            % chat_id	Integer or String	Optional	Required if
            % inline_message_id is not specified. Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the message
            % to edit
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            % media	InputMedia	Required	A JSON-serialized object for a new
            % media content of the message
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for a new inline keyboard.
            %
            usePM = false;
            comand = 'editMessageMedia';
            params = struct;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id =(varargin{2});
                    case 'message_id'
                        params.message_id =(varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id =(varargin{2});
                    case 'reply_markup'
                        params.reply_markup =(varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'allowed_updates'
                        params.allowed_updates = (varargin{2});
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                params.media = media;
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function editMessageMedia
        %%
        function response = editMessageReplyMarkup(obj, varargin)
            % editMessageReplyMarkup Use this method to edit only the reply
            % markup of messages. On success, if edited message is sent by
            % the bot, the edited Message is returned, otherwise True is
            % returned.
            %
            % chat_id	Integer or String	Optional	Required if
            % inline_message_id is not specified. Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the message
            % to edit
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for an inline keyboard.
            %
            comand = 'editMessageReplyMarkup';
            usePM = false;
            params = struct;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function editMessageReplyMarkup
        %%
        function response = stopPoll(obj, chat_id, message_id, varargin)
            % stopPoll Use this method to stop a poll which was sent by the
            % bot. On success, the stopped Poll with the final results is
            % returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Required	Identifier of the original message
            % with the poll
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for a new message inline keyboard.
            %
            comand = 'stopPoll';
            usePM = false;
            params = struct;
            params.chat_id = (chat_id);
            params.message_id = (message_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function stopPoll
        %%
        function response = deleteMessage(obj, chat_id, message_id,...
                varargin)
            % deleteMessage Use this method to delete a message, including
            % service messages, with the following limitations:
            % - A message can only be deleted if it was sent less than 48
            % hours ago.
            % - A dice message in a private chat can only be deleted if it
            % was sent more than 24 hours ago.
            % - Bots can delete outgoing messages in private chats, groups,
            % and supergroups.
            % - Bots can delete incoming messages in private chats.
            % - Bots granted can_post_messages permissions can delete
            % outgoing messages in channels.
            % - If the bot is an administrator of a group, it can delete
            % any message there.
            % - If the bot has can_delete_messages permission in a
            % supergroup or a channel, it can delete any message there.
            % Returns True on success.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % message_id	Integer	Required	Identifier of the message to delete
            %
            comand = 'deleteMessage';
            params = struct;
            params.chat_id = chat_id;
            params.message_id = message_id;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function deleteMessage
        %%
        function response = sendSticker(obj, chat_id, varargin)
            %  sendSticker Use this method to send static .WEBP or animated
            %  .TGS stickers. On success, the sent Message is returned.
            %
            % chat_id	Integer or String	Required	Unique identifier for the
            % target chat or username of the target channel (in the format
            % @channelusername)
            %
            % sticker_id or sticker_url or sticker_file
            % InputFile or String	Required	Sticker to send. Pass a
            % file_id as String to send a file that exists on the Telegram
            % servers (recommended), pass an HTTP URL as a String for
            % Telegram to get a .WEBP file from the Internet, or upload a
            % new one using multipart/form-data. More info on Sending Files
            % »
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup or ReplyKeyboardMarkup or
            % ReplyKeyboardRemove or ForceReply	Optional	Additional
            % interface options. A JSON-serialized object for an inline
            % keyboard, custom reply keyboard, instructions to remove reply
            % keyboard or to force a reply from the user.
            %
            comand = 'sendSticker';
            usePM = false;
            params = struct;
            params.chat_id = (chat_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'sticker_id'
                        params.video =(varargin{2});
                    case 'sticker_url'
                        params.video =(varargin{2});
                    case 'sticker_file'
                        params.sticker_file = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function sendSticker(didn't end)
        %%
        function response = getStickerSet(obj, name, varargin)
            % getStickerSet Use this method to get a sticker set. On
            % success, a StickerSet object is returned.
            %
            % name	String	Required	Name of the sticker set
            %
            comand = 'getStickerSet';
            params = struct;
            params.name = name;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function getStickerSet
        %%
        function response = uploadStickerFile(obj, user_id, png_sticker,...
                varargin)
            % uploadStickerFile Use this method to upload a .PNG file with a
            % sticker for later use in createNewStickerSet and
            % addStickerToSet methods (can be used multiple times). Returns
            % the uploaded File on success.
            %
            % user_id	Integer	Required	User identifier of sticker file owner
            %
            % png_sticker	InputFile	Required	PNG image with the sticker,
            % must be up to 512 kilobytes in size, dimensions must not
            % exceed 512px, and either width or height must be exactly
            % 512px.
            %
            comand = 'uploadStickerFile';
            params = struct;
            params.user_id = (user_id);
            params.png_sticker = ...
                matlab.net.http.io.FileProvider((png_sticker));
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function uploadStickerFile(didn't end, check "while loop")
        %%
        function response = createNewStickerSet(obj, user_id, name, title,...
                emojis, varargin)
            % createNewStickerSet Use this method to create a new sticker
            % set owned by a user. The bot will be able to edit the sticker
            % set thus created. You must use exactly one of the fields
            % png_sticker or tgs_sticker. Returns True on success.
            %
            % user_id	Integer	Required	User identifier of created sticker set
            % owner
            %
            % name	String	Required	Short name of sticker set, to be used in
            % t.me/addstickers/ URLs (e.g., animals). Can contain only
            % english letters, digits and underscores. Must begin with a
            % letter, can't contain consecutive underscores and must end in
            % “_by_<bot username>”. <bot_username> is case insensitive.
            % 1-64 characters.
            %
            % title	String	Required	Sticker set title, 1-64 characters
            %
            % png_sticker_id or png_sticker_url or png_sticker_file
            % InputFile or String	Optional	PNG image with the sticker,
            % must be up to 512 kilobytes in size, dimensions must not
            % exceed 512px, and either width or height must be exactly
            % 512px. Pass a file_id as a String to send a file that already
            % exists on the Telegram servers, pass an HTTP URL as a String
            % for Telegram to get a file from the Internet, or upload a new
            % one using multipart/form-data.
            %
            % tgs_sticker	InputFile	Optional	TGS animation with the
            % sticker, uploaded using multipart/form-data. See
            % https://core.telegram.org/animated_stickers#technical-requirements
            % for technical requirements
            %
            % emojis	String	Required	One or more emoji corresponding to the
            % sticker
            %
            % contains_masks	Boolean	Optional	Pass True, if a set of
            % mask stickers should be created
            %
            % mask_position	MaskPosition	Optional	A JSON-serialized
            % object for position where the mask should be placed on faces
            %
            comand = 'createNewStickerSet';
            usePM = false;
            params = struct;
            params.user_id = (user_id);
            params.name = (name);
            params.title = (title);
            params.emojis = (emojis);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'png_sticker_id'
                        params.video =(varargin{2});
                    case 'png_sticker_url'
                        params.video =(varargin{2});
                    case 'png_sticker_file'
                        params.video = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'tgs_sticker'
                        params.tgs_sticker = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'contains_masks'
                        params.contains_masks = (varargin{2});
                    case 'mask_position'
                        params.mask_position = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end% function createNewStickerSet(didn't end, check "while loop")
        %%
        function response = addStickerToSet(obj, user_id, name,  emojis, varargin)
            % addStickerToSet Use this method to add a new sticker to a set
            % created by the bot. You must use exactly one of the fields
            % png_sticker or tgs_sticker. Animated stickers can be added to
            % animated sticker sets and only to them. Animated sticker sets
            % can have up to 50 stickers. Static sticker sets can have up
            % to 120 stickers. Returns True on success.
            %
            % user_id	Integer	Required	User identifier of sticker set owner
            %
            % name	String	Required	Sticker set name
            %
            % png_sticker_id or png_sticker_url or png_sticker_file
            % InputFile or String	Optional	PNG image with
            % the sticker, must be up to 512 kilobytes in size, dimensions
            % must not exceed 512px, and either width or height must be
            % exactly 512px. Pass a file_id as a String to send a file that
            % already exists on the Telegram servers, pass an HTTP URL as a
            % String for Telegram to get a file from the Internet, or
            % upload a new one using multipart/form-data.
            %
            % tgs_sticker	InputFile	Optional	TGS animation with the
            % sticker, uploaded using multipart/form-data. See
            % https://core.telegram.org/animated_stickers#technical-requirements
            % for technical requirements
            %
            % emojis	String	Required	One or more emoji corresponding to the
            % sticker
            %
            % mask_position	MaskPosition	Optional	A JSON-serialized
            % object for position where the mask should be placed on faces
            %
            comand = 'addStickerToSet';
            usePM = false;
            params = struct;
            params.user_id = (user_id);
            params.name = (name);
            params.emojis = (emojis);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'png_sticker_id'
                        params.video =(varargin{2});
                    case 'png_sticker_url'
                        params.video =(varargin{2});
                    case 'png_sticker_file'
                        params.video = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'tgs_sticker'
                        params.tgs_sticker = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'mask_position'
                        params.mask_position = varargin{2};
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function addStickerToSet
        %%
        function response = setStickerPositionInSet(obj, sticker, position,...
                varargin)
            % setStickerPositionInSet Use this method to move a sticker in
            % a set created by the bot to a specific position. Returns True
            % on success.
            %
            % sticker	String	Required File identifier of the sticker
            %
            % position	Integer	Required New sticker position in the set,
            % zero-based
            %
            comand = 'setStickerPositionInSet';
            params = struct;
            params.sticker = sticker;
            params.position = (position);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function setStickerPositionInSet
        %%        function response = deleteStickerFromSet(obj, sticker, varargin)
        function response = deleteStickerFromSet(obj, sticker, varargin)
            % deleteStickerFromSet Use this method to delete a sticker from
            % a set created by the bot. Returns True on success.
            %
            % sticker	String	Required	File identifier of the sticker
            %
            comand = 'deleteStickerFromSet';
            params = struct;
            params.sticker = sticker;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            resp = sendMFD(obj,  params, comand,...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function deleteStickerFromSet
        %%        function response = setStickerSetThumb(obj, name, user_id, varargin)
        function response = setStickerSetThumb(obj, name, user_id, varargin)
            % setStickerSetThumb Use this method to set the thumbnail of a
            % sticker set. Animated thumbnails can be set for animated
            % sticker sets only. Returns True on success.
            %
            % name	String	Required	Sticker set name
            %
            % user_id	Integer	Required	User identifier of the sticker set
            % owner
            %
            % thumbf - pass to InputFile or
            % thumbs - String -	Optional.	A PNG image with the
            % thumbnail, must be up to 128 kilobytes in size and have width
            % and height exactly 100px, or a TGS animation with the
            % thumbnail up to 32 kilobytes in size; see
            % https://core.telegram.org/animated_stickers#technical-requirements
            % for animated sticker technical requirements. Pass a file_id
            % as a String to send a file that already exists on the
            % Telegram servers, pass an HTTP URL as a String for Telegram
            % to get a file from the Internet, or upload a new one using
            % multipart/form-data. More info on Sending Files ». Animated
            % sticker set thumbnail can't be uploaded via HTTP URL.
            %
            comand = 'setStickerSetThumb';
            usePM = false;
            params = struct;
            params.name = (name);
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'thumbf'
                        params.thumb = ...
                            matlab.net.http.io.FileProvider(string(varargin{2}));
                    case 'thumbs'
                        params.thumb = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function setStickerSetThumb
        %%        function response = answerInlineQuery(obj, inline_query_id, results, varargin)
        function response = answerInlineQuery(obj, inline_query_id, results, varargin)
            % answerInlineQuery - Use this method to send answers to an
            % inline query. On success, True is returned.
            % No more than 50 results per query are allowed.
            %
            % inline_query_id	String	Required	Unique identifier for the
            % answered query
            %
            % results	Array of InlineQueryResult	Required	A JSON-serialized
            % array of results for the inline query
            %
            % cache_time	Integer	Optional	The maximum amount of time
            % in seconds that the result of the inline query may be cached
            % on the server. Defaults to 300.
            %
            % is_personal	Boolean	Optional	Pass True, if results may
            % be cached on the server side only for the user that sent the
            % query. By default, results may be returned to any user who
            % sends the same query
            %
            % next_offset	String	Optional	Pass the offset that a
            % client should send in the next query with the same text to
            % receive more results. Pass an empty string if there are no
            % more results or if you don't support pagination. Offset
            % length can't exceed 64 bytes.
            %
            % switch_pm_text	String	Optional	If passed, clients will
            % display a button with specified text that switches the user
            % to a private chat with the bot and sends the bot a start
            % message with the parameter switch_pm_parameter
            %
            % switch_pm_parameter	String	Optional	Deep-linking
            % parameter for the /start message sent to the bot when user
            % presses the switch button. 1-64 characters, only A-Z, a-z,
            % 0-9, _ and - are allowed.
            % Example: An inline bot that sends YouTube videos can ask the
            % user to connect the bot to their YouTube account to adapt
            % search results accordingly. To do this, it displays a
            % 'Connect your YouTube account' button above the results, or
            % even before showing any. The user presses the button,
            % switches to a private chat with the bot and, in doing so,
            % passes a start parameter that instructs the bot to return an
            % oauth link. Once done, the bot can offer a switch_inline
            % button so that the user can easily return to the chat where
            % they wanted to use the bot's inline capabilities.
            comand = 'answerInlineQuery';
            params = struct;
            usePM = false; % on/off progress monitor
            params.inline_query_id = inline_query_id;
            params.results = results;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'cache_time'
                        params.cache_time = (varargin{2});
                    case 'is_personal'
                        params.is_personal = (varargin{2});
                    case 'next_offset'
                        params.next_offset = (varargin{2});
                    case 'switch_pm_text'
                        params.switch_pm_text = (varargin{2});
                    case 'switch_pm_parameter'
                        params.switch_pm_parameter = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function answerInlineQuery
        %% function response = sendInvoice()
        function response = sendInvoice(obj, chat_id, title, description, payload,...
                provider_token, start_parameter, currency, prices,  varargin)
            % sendInvoice Use this method to send invoices. On success, the sent Message is returned.
            %
            % chat_id	Integer	Required	Unique identifier for the target
            % private chat
            %
            % title	String	Required	Product name, 1-32 characters
            %
            % description	String	Required	Product description, 1-255
            % characters
            %
            % payload	String	Required	Bot-defined invoice payload, 1-128
            % bytes. This will not be displayed to the user, use for your
            % internal processes.
            %
            % provider_token	String	Required	Payments provider token,
            % obtained via Botfather
            %
            % start_parameter	String	Required	Unique deep-linking parameter
            % that can be used to generate this invoice when used as a
            % start parameter
            %
            % currency	String	Required	Three-letter ISO 4217 currency code,
            % see more on currencies
            %
            % prices	Array of LabeledPrice	Required	Price breakdown, a
            % JSON-serialized list of components (e.g. product price, tax,
            % discount, delivery cost, delivery tax, bonus, etc.)
            %
            % provider_data	String	Optional	JSON-encoded data about the
            % invoice, which will be shared with the payment provider. A
            % detailed description of required fields should be provided by
            % the payment provider.
            %
            % photo_url	String	Optional	URL of the product photo for
            % the invoice. Can be a photo of the goods or a marketing image
            % for a service. People like it better when they see what they
            % are paying for.
            %
            % photo_size	Integer	Optional	Photo size
            %
            % photo_width	Integer	Optional	Photo width
            %
            % photo_height	Integer	Optional	Photo height
            %
            % need_name	Boolean	Optional	Pass True, if you require the
            % user's full name to complete the order
            %
            % need_phone_number	Boolean	Optional	Pass True, if you
            % require the user's phone number to complete the order
            %
            % need_email	Boolean	Optional	Pass True, if you require
            % the user's email address to complete the order
            %
            % need_shipping_address	Boolean	Optional	Pass True, if you
            % require the user's shipping address to complete the order
            %
            % send_phone_number_to_provider	Boolean	Optional	Pass True,
            % if user's phone number should be sent to provider
            %
            % send_email_to_provider	Boolean	Optional	Pass True, if
            % user's email address should be sent to provider
            %
            % is_flexible	Boolean	Optional	Pass True, if the final
            % price depends on the shipping method
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for an inline keyboard. If empty, one
            % 'Pay total price' button will be shown. If not empty, the
            % first button must be a Pay button.
            %
            comand = 'sendInvoice';
            params = struct;
            usePM = false; % on/off progress monitor
            params.chat_id = chat_id;
            params.title = title;
            params.description = description;
            params.payload = payload;
            params.provider_token = provider_token;
            params.start_parameter = start_parameter;
            params.currency = currency;
            params.prices = prices;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'provider_data'
                        params.provider_data = (varargin{2});
                    case 'photo_url'
                        params.photo_url = (varargin{2});
                    case 'photo_size'
                        params.photo_size = (varargin{2});
                    case 'photo_width'
                        params.photo_width = (varargin{2});
                    case 'photo_height'
                        params.photo_height = (varargin{2});
                    case 'need_name'
                        params.need_name = (varargin{2});
                    case 'need_phone_number'
                        params.need_phone_number = (varargin{2});
                    case 'need_email'
                        params.need_email = (varargin{2});
                    case 'need_shipping_address'
                        params.need_shipping_address = (varargin{2});
                    case 'send_phone_number_to_provider'
                        params.send_phone_number_to_provider = (varargin{2});
                    case 'send_email_to_provider'
                        params.send_email_to_provider = (varargin{2});
                    case 'is_flexible'
                        params.is_flexible = (varargin{2});
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendInvoice
        %%        function response = answerShippingQuery(obj, shipping_query_id, ok, varargin)
        function response = answerShippingQuery(obj, shipping_query_id, ok, varargin)
            % answerShippingQuery If you sent an invoice requesting a
            % shipping address and the parameter is_flexible was specified,
            % the Bot API will send an Update with a shipping_query field
            % to the bot. Use this method to reply to shipping queries. On
            % success, True is returned.
            %
            % shipping_query_id	String	Required	Unique identifier for the query
            % to be answered
            %
            % ok	Boolean	Required	Specify True if delivery to the specified
            % address is possible and False if there are any problems (for
            % example, if delivery to the specified address is not
            % possible)
            %
            % shipping_options	Array of ShippingOption	Optional
            % Required if ok is True. A JSON-serialized array of available
            % shipping options.
            %
            % error_message	String	Optional	Required if ok is False.
            % Error message in human readable form that explains why it is
            % impossible to complete the order (e.g. "Sorry, delivery to
            % your desired address is unavailable'). Telegram will display
            % this message to the user.
            %
            comand = 'answerShippingQuery';
            params = struct;
            usePM = false; % on/off progress monitor
            params.shipping_query_id = shipping_query_id;
            params.ok = ok;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'shipping_options'
                        params.shipping_options = (varargin{2});
                    case 'error_message'
                        params.error_message = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function answerShippingQuery
        %%        function response = answerPreCheckoutQuery(obj, pre_checkout_query_id, ok, varargin)
        function response = answerPreCheckoutQuery(obj, pre_checkout_query_id, ok, varargin)
            % answerPreCheckoutQuery Once the user has confirmed their
            % payment and shipping details, the Bot API sends the final
            % confirmation in the form of an Update with the field
            % pre_checkout_query. Use this method to respond to such
            % pre-checkout queries. On success, True is returned. Note: The
            % Bot API must receive an answer within 10 seconds after the
            % pre-checkout query was sent.
            %
            % pre_checkout_query_id	String	Required	Unique identifier for the
            % query to be answered
            %
            % ok	Boolean	Required Specify True if everything is alright
            % (goods are available, etc.) and the bot is ready to proceed
            % with the order. Use False if there are any problems.
            %
            % error_message	String	Optional	Required if ok is False.
            % Error message in human readable form that explains the reason
            % for failure to proceed with the checkout (e.g. "Sorry,
            % somebody just bought the last of our amazing black T-shirts
            % while you were busy filling out your payment details. Please
            % choose a different color or garment!"). Telegram will display
            % this message to the user.
            %
            comand = 'answerPreCheckoutQuery';
            params = struct;
            usePM = false; % on/off progress monitor
            params.pre_checkout_query_id = pre_checkout_query_id;
            params.ok = ok;
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'error_message'
                        params.error_message = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end % function answerPreCheckoutQuery
        %% function response = sendGame()
        function response = sendGame(obj, chat_id,...
                game_short_name, varargin)
            % sendGame Use this method to send a game. On success, the sent
            % Message is returned.
            %
            % chat_id	Integer	Required	Unique identifier for the target chat
            %
            % game_short_name	String	Required	Short name of the game, serves
            % as the unique identifier for the game. Set up your games via
            % Botfather.
            %
            % disable_notification	Boolean	Optional	Sends the message
            % silently. Users will receive a notification with no sound.
            %
            % reply_to_message_id	Integer	Optional	If the message is a
            % reply, ID of the original message
            %
            % reply_markup	InlineKeyboardMarkup	Optional	A
            % JSON-serialized object for an inline keyboard. If empty, one
            % 'Play game_title' button will be shown. If not empty, the
            % first button must launch the game.
            %
            comand = 'sendGame';
            params = struct;
            usePM = false; % on/off progress monitor
            params.chat_id = (chat_id);
            params.game_short_name = (game_short_name);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'disable_notification'
                        params.disable_notification = (varargin{2});
                    case 'reply_to_message_id'
                        params.reply_to_message_id = (varargin{2});
                    case 'reply_markup'
                        params.reply_markup = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function sendGame
        %%        function response = setGameScore(obj, user_id, score, varargin)
        function response = setGameScore(obj, user_id, score, varargin)
            % setGameScore Use this method to set the score of the
            % specified user in a game. On success, if the message was sent
            % by the bot, returns the edited Message, otherwise returns
            % True. Returns an error, if the new score is not greater than
            % the user's current score in the chat and force is False.
            %
            % user_id	Integer	Required	User identifier
            %
            % score	Integer	Required	New score, must be non-negative
            %
            % force	Boolean	Optional	Pass True, if the high score is
            % allowed to decrease. This can be useful when fixing mistakes
            % or banning cheaters
            %
            % disable_edit_message	Boolean	Optional	Pass True, if the
            % game message should not be automatically edited to include
            % the current scoreboard
            %
            % chat_id	Integer	Optional	Required if inline_message_id
            % is not specified. Unique identifier for the target chat
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the sent
            % message
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            comand = 'setGameScore';
            params = struct;
            usePM = false; % on/off progress monitor
            params.user_id = (user_id);
            params.score = (score);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'force'
                        params.force = (varargin{2});
                    case 'disable_edit_message'
                        params.disable_edit_message = (varargin{2});
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function setGameScore
        %%        function response = getGameHighScores(obj, user_id,  varargin)
        function response = getGameHighScores(obj, user_id,  varargin)
            % getGameHighScores Use this method to get data for high score
            % tables. Will return the score of the specified user and
            % several of their neighbors in a game. On success, returns an
            % Array of GameHighScore objects.
            %
            % user_id	Integer	Required	Target user id
            %
            % chat_id	Integer	Optional	Required if inline_message_id
            % is not specified. Unique identifier for the target chat
            %
            % message_id	Integer	Optional	Required if
            % inline_message_id is not specified. Identifier of the sent
            % message
            %
            % inline_message_id	String	Optional	Required if chat_id and
            % message_id are not specified. Identifier of the inline
            % message
            %
            comand = 'getGameHighScores';
            params = struct;
            usePM = false; % on/off progress monitor
            params.user_id = (user_id);
            ResponseTimeout = Inf;
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'chat_id'
                        params.chat_id = (varargin{2});
                    case 'message_id'
                        params.message_id = (varargin{2});
                    case 'inline_message_id'
                        params.inline_message_id = (varargin{2});
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            %send request
            resp = sendMFD(obj,  params, comand,...
                'usepm', usePM, ...
                'MediaType', 'application/json', ...
                'ResponseTimeout', ResponseTimeout);
            response = resp.Body.Data; %extract data from ansver of server
        end %  function getGameHighScores
    end % methods
    methods (Access = private)
        %% [resp, req, hist] = sendMFD()
        function  [resp, req, hist] = sendMFD(obj,  message2send,...
                comand, varargin) % send multipart/form-data
            % sendMFD - this function send data by http
            ResponseTimeout = Inf; % Response Timeout from server
            usePM = false; % on/off progress monitor
            % MessageMediaType For upploading files to telegram must be
            % 'multipart/form-data' for simple json text can be
            % 'application/json'
            MessageMediaType = 'multipart/form-data';
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'usepm'
                        usePM = varargin{2};
                    case 'responsetimeout'
                        ResponseTimeout = varargin{2};
                    case 'mediatype'
                        MessageMediaType = varargin{2};
                    otherwise
                        error(['Unexpected option: ' varargin{1}])
                end %switch
                varargin(1:2) = [];
            end % while isempty
            % convert structure to cell array
            if isstruct(message2send)
                message2send = fullstructure2cellarray(message2send);
            else
            end
            % concatenate url for request
            url_string = [ obj.main_url, (comand)];
            url_for_request = matlab.net.URI(url_string);
            % set method of request POST
            method = matlab.net.http.RequestMethod.POST;
            % set mediatype of request.
            type1 = matlab.net.http.MediaType(MessageMediaType);
            acceptField = matlab.net.http.field.AcceptField(type1);
            % concatenate headers
            header = [acceptField];%  contentTypeField];
            % prepare message to sending
            formProvider =...
                matlab.net.http.io.MultipartFormProvider(message2send{ : } );
            % prepate request
            request = matlab.net.http.RequestMessage(method, header, formProvider);
            % set options for request
            options =  matlab.net.http.HTTPOptions('SavePayload', true,...
                'ProgressMonitorFcn', @FilesProgressMonitor,...
                'UseProgressMonitor', usePM, ...
                'ResponseTimeout', ResponseTimeout) ;
            % send request
            [resp, req, hist] = request.send(url_for_request,   options);
        end% function sendMFD
    end % private methods
end % class


  % Author Aleksei Kukin, 2021
