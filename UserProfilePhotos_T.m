function userprofilephotos = UserProfilePhotos_T(total_count, photos)
% UserProfilePhotos_T This object represent a user's profile pictures.
%
% total_count	Integer	Total number of profile pictures the target user
% has
%
% photos	Array of Array of PhotoSize	Requested profile pictures (in up
% to 4 sizes each)
%
userprofilephotos = struct;
userprofilephotos.total_count = total_count;
userprofilephotos.photos = photos;
end

