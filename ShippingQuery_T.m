function iqresult = ShippingQuery_T(id, from, invoice_payload, shipping_address, varargin)
% ShippingQuery_T This object contains information about an incoming shipping query.
%
% id	String	Unique query identifier
%
% from	User	User who sent the query
%
% invoice_payload	String	Bot specified invoice payload
%
% shipping_address	ShippingAddress	User specified shipping address
%
iqresult = struct;
iqresult.id = id;
iqresult.from = from;
iqresult.invoice_payload = invoice_payload;
iqresult.shipping_address = shipping_address;
end