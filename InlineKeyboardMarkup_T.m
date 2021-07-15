function IKM = InlineKeyboardMarkup_T(inline_keyboard)
% InlineKeyboardMarkup_T - This object represents an inline keyboard that
% appears right next to the message it belongs to.

% inline_keyboard	Array of Array of InlineKeyboardButton	Array of button
% rows, each represented by an Array of InlineKeyboardButton objects Note:
% This will only work in Telegram versions released after 9 April, 2016.
% Older clients will display unsupported message.

IKM = struct('inline_keyboard', inline_keyboard);
end

