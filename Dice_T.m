function dice = Dice_T(emoji, value)
% Dice_T - This object represents an animated emoji that displays a random
% value.
%
% emoji	String	Emoji on which the dice throw animation is based
%
% value	Integer	Value of the dice, 1-6 for “🎲” and “🎯” base emoji, 1-5
% for “🏀” base emoji
%
dice = struct;
dice.emoji = (emoji);
dice.value = (value);

end