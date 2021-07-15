function [fields_res] = json_string_cheker(fieldnames_res, fields_res)
% chek filds in the structure that need to be converted into a json stirng
for i = 1:max(size(fieldnames_res))
    if chek_fild_name(fieldnames_res{i})
        if isstruct(fields_res{i})
            fields_res{i} = jsonencode(fields_res{i});
        end
    end
end
end

function res = chek_fild_name(FR)
list_of_names = {'keyboard', 'reply_markup', 'from', 'sender_chat', 'chat',...
    'forward_from', 'forward_from_chat', 'forward_from_message_id', ...
    'via_bot','contact', 'location', 'new_chat_members', 'left_chat_member',...
    'invoice','successful_payment', 'passport_data', 'commands', 'callback_query', ...
    'chat_member','my_chat_member', 'permissions', 'new_chat_photo', 'venue', ...
    'chosen_inline_result','inline_query', 'results', 'explanation_entities',...
    'options', 'mask_position', 'request_poll'};
res = sum(cellfun(@(x)(lower(string(x))==lower(string(FR))), list_of_names));
end

