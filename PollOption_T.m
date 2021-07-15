function polloption = PollOption_T(text, voter_count)
% PollOption_T This object contains information about one answer option in a
% poll.
%
% text	String	Option text, 1-100 characters
%
% voter_count	Integer	Number of users that voted for this option
%
polloption = struct;
polloption.text = (text);
polloption.voter_count = (voter_count);
end