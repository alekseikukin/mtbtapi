function iqresult = ShippingOption_T(id, title, prices, varargin)
% ShippingOption_T This object represents one shipping option.
%
% id	String	Shipping option identifier
% 
% title	String	Option title
% 
% prices	Array of LabeledPrice	List of price portions
%
iqresult = struct;
iqresult.id = id;
iqresult.title = title;
iqresult.prices = prices;
end