function iqresult = SuccessfulPayment_T(currency, total_amount,...
    invoice_payload, telegram_payment_charge_id,...
    provider_payment_charge_id, varargin)
% SuccessfulPayment_T This object contains basic information about a successful payment.
%
% currency	String	Three-letter ISO 4217 currency code
% 
% total_amount	Integer	Total price in the smallest units of the currency
% (integer, not float/double). For example, for a price of US$ 1.45 pass
% amount = 145. See the exp parameter in currencies.json, it shows the
% number of digits past the decimal point for each currency (2 for the
% majority of currencies).
% 
% invoice_payload	String	Bot specified invoice payload
% 
% shipping_option_id	String	Optional. Identifier of the shipping option
% chosen by the user
% 
% order_info	OrderInfo	Optional. Order info provided by the user
% 
% telegram_payment_charge_id	String	Telegram payment identifier
% 
% provider_payment_charge_id	String	Provider payment identifier
%
iqresult = struct;
iqresult.currency = currency;
iqresult.total_amount = total_amount;
iqresult.invoice_payload = invoice_payload;
iqresult.telegram_payment_charge_id = telegram_payment_charge_id;
iqresult.provider_payment_charge_id = provider_payment_charge_id;
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'shipping_option_id'
            iqresult.shipping_option_id = varargin{2};
        case 'order_info'
            iqresult.order_info = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end % switch
    varargin(1:2) = [];
end % while isempty
end