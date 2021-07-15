MyBot=telegram_bot('');
% to tune webhook you need point next variables
url = ''; % HTTPS url to send updates to
certificate_path = ''; % *.pem, your public key certificate
ip_addres = ''; % Optional The fixed IP address which will be used to send webhook requests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% check state of bot %%%%%%%%%%%%%%%%%%%%%%
BotInfo = MyBot.getMe;
disp('This was returned by MyBot.getMe:');
disp(BotInfo);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% set webhook %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MyBot.setWebhook(url, 'certificate', certificate_path, 'ip_address', ip_addres)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% check webhok status %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MyBot.getWebhookInfo()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% delete webhook %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MyBot.deleteWebhook()
