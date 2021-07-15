function iqresult = InlineQueryResultVoice_T(id, voice_url, ...
    title,  varargin)
% InlineQueryResultVoice_T Represents a link to a voice recording in an
% .OGG container encoded with OPUS. By default, this voice recording will
% be sent by the user. Alternatively, you can use input_message_content to
% send a message with the specified content instead of the the voice
% message.
%
% type	String	Type of the result, must be voice
%
% id	String	Unique identifier for this result, 1-64 bytes
%
% voice_url	String	A valid URL for the voice recording
%
% title	String	Optional. Title for the result
%
% caption	String	Optional. Caption, 0-1024 characters after entities
% parsing
%
% parse_mode	String	Optional. Mode for parsing entities in the caption.
% See formatting options for more details.
%
% caption_entities	Array of MessageEntity	Optional. List of special
% entities that appear in the caption, which can be specified instead of
% parse_mode
%
% voice_duration	Integer	Optional. Optional. Audio duration in seconds
%
% reply_markup	InlineKeyboardMarkup	Optional. Inline keyboard attached
% to the message
%
% input_message_content	InputMessageContent	Optional. Content of the
% message to be sent instead of the audio
%
iqresult = struct;
iqresult.type = 'voice';
iqresult.id = id;
iqresult.audio_url = voice_url;
iqresult.title = title;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'caption'
            iqresult.caption = varargin{2};
        case 'parse_mode'
            iqresult.parse_mode = varargin{2};
        case 'caption_entities'
            iqresult.caption_entities = varargin{2};
        case 'voice_duration'
            iqresult.audio_duration = varargin{2};
        case 'reply_markup'
            iqresult.reply_markup = varargin{2};
        case 'input_message_content'
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end