function poll = Poll_T(id, question, options, total_voter_count,...
    is_closed, is_anonymous, type, allows_multiple_answers, varargin)
% Poll_T This object contains information about a poll.
%
% id	String	Unique poll identifier
%
% question	String	Poll question, 1-255 characters
%
% options	Array of PollOption	List of poll options
%
% total_voter_count	Integer	Total number of users that voted in the poll
%
% is_closed	Boolean	True, if the poll is closed
%
% is_anonymous	Boolean	True, if the poll is anonymous
%
% type	String	Poll type, currently can be “regular” or “quiz”
%
% allows_multiple_answers	Boolean	True, if the poll allows multiple
% answers
%
% correct_option_id	Integer	Optional. 0-based identifier of the correct
% answer option. Available only for polls in the quiz mode, which are
% closed, or was sent (not forwarded) by the bot or to the private chat
% with the bot.
%
% explanation	String	Optional. Text that is shown when a user chooses an
% incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200
% characters
%
% explanation_entities	Array of MessageEntity	Optional. Special entities
% like usernames, URLs, bot commands, etc. that appear in the explanation
%
% open_period	Integer	Optional. Amount of time in seconds the poll will
% be active after creation
%
% close_date	Integer	Optional. Point in time (Unix timestamp) when the
% poll will be automatically closed
%
poll = struct;
poll.id = (id);
poll.question = (question);
poll.options = (options);
poll.total_voter_count = (total_voter_count);
poll.is_closed = (is_closed);
poll.is_anonymous = (is_anonymous);
poll.type = (type);
poll.allows_multiple_answers = (allows_multiple_answers);
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'correct_option_id'
            poll.correct_option_id = (varargin{2});
        case 'explanation'
            poll.explanation = (varargin{2});
        case 'explanation_entities'
            poll.explanation_entities = (varargin{2});
        case 'open_period'
            poll.open_period = (varargin{2});
        case 'close_date'
            poll.close_date = (varargin{2});
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end