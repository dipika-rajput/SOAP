public with sharing class ConsumeFlightStatus {
	
       String grant_type = 'password';
       String clientid = '3MVG9ZL0ppGP5UrBf6GFdYVB_X75L2DMfczVkVdX4oZ13zDqLw5MNP_30xIaXztZqPSGND4HQbnRO1Bgxd47h';
       String clientSecret = '1860021103593715104';
       String username = 'divya.rajput@eternussolutions.com';
       String password = 'jagatsing123$';
       public class deserializeResponse
       {
           public String Id;
           public String access_token;
       }
   public String Login()
   {
      
       String requestbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
       System.debug('***requestbody:-' + requestbody);
       Http httpInstance = new Http();
       HttpRequest request = new HttpRequest();
       request.setBody(requestbody);
       request.setMethod('POST');
       request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
       //response Handler
       HttpResponse response = httpInstance.send(request);
       System.debug('this is res:-'+response.getBody());
       deserializeResponse res1 = (deserializeResponse)JSON.deserialize(response.getBody(),deserializeResponse.class);
       System.debug('this is res1 :-'+res1);
       return res1.access_token;
       
   }
 
    public static void callflightGet(String AC,String FN)
    {
       ConsumeFlightStatus c1= new ConsumeFlightStatus();
      	HttpRequest req = new HttpRequest();
      	HttpResponse res = new HttpResponse();
      	Http http = new Http();
      	String accessToken = c1.Login();
        
      	if(accessToken != Null)
        {
          //System.debug('access token is not null');
            req.setHeader('Authorization','Bearer ' + accessToken);
          	req.setHeader('Content-Type','application/json');
          	req.setHeader('accept','application/json');
            req.setMethod('GET');
          //req.setBody(body);
         	//req.setEndpoint('https://ap2.salesforce.com/services/apexrest/FlightStat?Airline_Code__c='+AC+'&Flight_Number__c='+FN+'&Arrival_Time__c='+AT+'&Departure_Time__c='+DT); 
          	req.setEndpoint('https://ap2.salesforce.com/services/apexrest/FlightStat?Airline_Code__c='+AC+'&Flight_Number__c='+FN); 
          	System.debug('req****'+req);
            res = http.send(req); 
            System.debug('request of get:-'+req.getBody());
          	System.debug('response of get:----'+res.getBody());
          
        }
    }
   
}