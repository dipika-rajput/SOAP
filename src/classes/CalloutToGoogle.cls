public class CalloutToGoogle {
    public String callingGoogle()
    {
		//List<Email_Handler__c> e = new List<Email_Handler__c>([Select id,Email_Body__c,Email_Subject__c from Email_Handler__c ]);
        String url = 'https://www.google.com/search?q=';
        String body = 'Facebook+Login';
        url = url + body;
        System.debug('url:->'+url);
        Http h= new Http();
        System.debug('http h:->'+h);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        System.debug('req::::'+req);
   
        HttpResponse res = h.send(req);
        String HtmlFormat = res.getBody();     
        //System.debug('res:--'+HtmlFormat);
  		Integer status = res.getStatusCode();
        String StatusName = res.getStatus();
        return HtmlFormat;
    }
    

}