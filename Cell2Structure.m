function [structure] = Cell2Structure(cellin)
%Cell2Structure - convert cell array of headers and filds to structured
%array
filds1 = {};
headers1 = {};
for i=1:max(size(cellin))/2
filds1(end+1,1) = cellin(2);
headers1(end+1,1) = cellin(1);
cellin(1:2) = [];
end
structure = cell2struct(filds1, headers1);
end

