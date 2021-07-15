function iqresult = ChosenInlineResult_T(result_id, from,...
    varargin)
% ChosenInlineResult_T - Represents a result of an inline query that was
% chosen by the user and sent to their chat partner.
%
% result_id	String	The unique identifier for the result that was chosen
% 
% from	User	The user that chose the result
% 
% location	Location	Optional. Sender location, only for bots that
% require user location
% 
% inline_message_id	String	Optional. Identifier of the sent inline
% message. Available only if there is an inline keyboard attached to the
% message. Will be also received in callback queries and can be used to
% edit the message.
% 
% query	String	The query that was used to obtain the result
%
iqresult = struct;
iqresult.result_id = result_id;
iqresult.from = from;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'location'
            iqresult.location = varargin{2};
        case 'inline_message_id'
            iqresult.inline_message_id = varargin{2};
        case 'query'
            iqresult.query = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end