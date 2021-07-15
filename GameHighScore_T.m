function iqresult = GameHighScore_T(position, user, score, varargin)
% GameHighScore_T - This object represents one row of the high scores table
% for a game.
%
% position	Integer	Position in high score table for the game
% 
% user	User	User
% 
% score	Integer	Score
%
iqresult = struct;
iqresult.position = position;
iqresult.user = user;
iqresult.score = score;
end