function keyboardbuttonpolltype = KeyboardButtonPollType_T(varargin)
% KeyboardButtonPollType_T - This object represents type of a poll, which is
% allowed to be created and sent when the corresponding button is pressed.
%
% type - String	Optional. If quiz is passed, the user will be allowed to
% create only polls in the quiz mode. If regular is passed, only regular
% polls will be allowed. Otherwise, the user will be allowed to create a
% poll of any type.
%
keyboardbuttonpolltype = struct;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'type'
            keyboardbuttonpolltype.type = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end
end

