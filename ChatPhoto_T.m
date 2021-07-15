function chat_photo = ChatPhoto_T(small_file_id, small_file_unique_id, ...
    big_file_id, big_file_unique_id)
%ChatPhoto_T - This object represents a chat photo.
%
% small_file_id	String	File identifier of small (160x160) chat photo. This
% file_id can be used only for photo download and only for as long as the
% photo is not changed.
%
% small_file_unique_id	String	Unique file identifier of small (160x160)
% chat photo, which is supposed to be the same over time and for different
% bots. Can't be used to download or reuse the file.
%
% big_file_id	String	File identifier of big (640x640) chat photo. This
% file_id can be used only for photo download and only for as long as the
% photo is not changed.
%
% big_file_unique_id	String	Unique file identifier of big (640x640)
% chat photo, which is supposed to be the same over time and for different
% bots. Can't be used to download or reuse the file.
%
chat_photo = struct;
chat_photo.small_file_id = (small_file_id);
chat_photo.small_file_unique_id = (small_file_unique_id);
chat_photo.big_file_id = (big_file_id);
chat_photo.big_file_unique_id = (big_file_unique_id);
end

