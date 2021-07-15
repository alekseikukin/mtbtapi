function iqresult = MaskPosition_T(point, x_shift,...
    y_shift, scale, varargin)
% MaskPosition_T This object describes the position on faces where a mask
% should be placed by default.
%
% point	String	The part of the face relative to which the mask should be
% placed. One of “forehead”, “eyes”, “mouth”, or “chin”.
% 
% x_shift	Float number	Shift by X-axis measured in widths of the mask
% scaled to the face size, from left to right. For example, choosing -1.0
% will place mask just to the left of the default mask position.
% 
% y_shift	Float number	Shift by Y-axis measured in heights of the mask
% scaled to the face size, from top to bottom. For example, 1.0 will place
% the mask just below the default mask position.
% 
% scale	Float number
iqresult = struct;
iqresult.point = point;
iqresult.x_shift = x_shift;
iqresult.y_shift = y_shift;
iqresult.scale = scale;
end