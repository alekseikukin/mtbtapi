function botcommand = BotCommand_T(command,description)
% BotCommand_T - This object represents a bot command.
%
% command	String	Text of the command, 1-32 characters. Can contain only
% lowercase English letters, digits and underscores.
%
% description	String	Description of the command, 3-256 characters.
%
botcommand = struct;
botcommand.command = command;
botcommand.description = description;
end

