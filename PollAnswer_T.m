function pollanswer = PollAnswer_T(poll_id, user, option_ids)
% PollAnswer_T This object represents an answer of a user in a non-anonymous
% poll.
%
% poll_id	String	Unique poll identifier
%
% user	User	The user, who changed the answer to the poll
%
% option_ids	Array of Integer	0-based identifiers of answer options,
% chosen by the user. May be empty if the user retracted their vote.
%
pollanswer = struct;
pollanswer.poll_id = poll_id;
pollanswer.user = user;
pollanswer.option_ids = option_ids;
end