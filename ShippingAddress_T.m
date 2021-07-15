function iqresult = ShippingAddress_T(country_code, state,...
    city, street_line1, street_line2, post_code, varargin)
% ShippingAddress_T This object represents a shipping address.
%
% country_code	String	ISO 3166-1 alpha-2 country code
% 
% state	String	State, if applicable
% 
% city	String	City
% 
% street_line1	String	First line for the address
% 
% street_line2	String	Second line for the address
% 
% post_code	String	Address post code
%
iqresult = struct;
iqresult.country_code = country_code;
iqresult.state = state;
iqresult.city = city;
iqresult.street_line1 = street_line1;
iqresult.street_line2 = street_line2;
iqresult.post_code = post_code;
end