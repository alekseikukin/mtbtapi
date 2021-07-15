function iqresult = Invoice_T(title, description,...
    start_parameter, currency, total_amount, varargin)
% Invoice_T - This object contains basic information about an invoice.
%
% title	String	Product name
% 
% description	String	Product description
% 
% start_parameter	String	Unique bot deep-linking parameter that can be
% used to generate this invoice
% 
% currency	String	Three-letter ISO 4217 currency code
% 
% total_amount	Integer	Total price in the smallest units of the currency
% (integer, not float/double). For example, for a price of US$ 1.45 pass
% amount = 145. See the exp parameter in currencies.json, it shows the
% number of digits past the decimal point for each currency (2 for the
% majority of currencies).
%
iqresult = struct;
iqresult.title = title;
iqresult.description = description;
iqresult.start_parameter = start_parameter;
iqresult.currency = currency;
iqresult.total_amount = total_amount;
end