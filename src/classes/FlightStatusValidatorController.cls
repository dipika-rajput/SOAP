public with sharing class FlightStatusValidatorController {

    //public String listofWrapper { get; set; }

    public String departureDate { get; set; }
    public String ArrivalDate { get; set; }
    public String FlightNum { get; set; }
    public String airlinecode { get; set; }
    //wrapper var init
    public String Airline{get;set;}
    public String FlightNo{get;set;}
    public DateTime Arrivaltime{get;set;}
    public DateTime Departuretime{get;set;}
    public String Airport{get;set;}
    public String Arrivalairportcode{get;set;}
    public String Arrivalterminal{get;set;}  
    public String Departureairportcode{get;set;}
    public String Departureerminal{get;set;}
    @TestVisible
    public  List<WrapperofResult>listofWrapper{get;set;}
    @TestVisible
    public WrapperofResult w{get;set;}
    Map<String,Object>mapofindividualobject = new Map<String,Object>();
    //listofWrapper = new List<WrapperofResult>();            
    
    String grant_type = 'password';
    String clientid = '3MVG9ZL0ppGP5UrBf6GFdYVB_X75L2DMfczVkVdX4oZ13zDqLw5MNP_30xIaXztZqPSGND4HQbnRO1Bgxd47h';
    String clientSecret = '1860021103593715104';
    String username = 'divya.rajput@eternussolutions.com';
    String password = 'jagatsing123$';
    public FlightStatusValidatorController ()
    {
       listofWrapper = new List<WrapperofResult>(); 
       callflightGet();
    }
    public class deserializeResponse
       {
           public String Id;
           public String access_token;
       }
       @TestVisible
       public class WrapperofResult
       {
         public String Airline{get;set;}
         public String FlightNo{get;set;}
         public DateTime Arrivaltime{get;set;}
         public  DateTime Departuretime{get;set;}
         public  String Airport{get;set;}
         public  String Arrivalairportcode{get;set;}
         public  String Arrivalterminal{get;set;}
         public  String Departureairportcode{get;set;}
         public  String Departureerminal{get;set;}
          
       
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
   public  void callflightGet()
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
            req.setEndpoint('https://ap2.salesforce.com/services/apexrest/FlightStat?Airline_Code__c='+airlinecode+'&Flight_Number__c='+FlightNum ); 
            System.debug('req****'+req);
            res = http.send(req); 
            String jsonResponse=res.getBody();
            System.debug('request of get:-'+req.getBody());
            System.debug('response of get:----'+res.getBody());
            List<Object> Listofjson = (List<Object>)JSON.deserializeUntyped(jsonResponse);
            System.debug('jsonResponse:-'+jsonResponse);
            //Object attributes = mapofjson.get('attributes');
        //System.debug('attributes:=-'+attributes);
       // Map<String,Object>mapofindividualobject = new Map<String,Object>();
        //List<WrapperofResult>listofWrapper = new List<WrapperofResult>();
          WrapperofResult w = new WrapperofResult();
         // List<WrapperofResult >listofWrapper = new List<WrapperofResult >();
            for(Object o : Listofjson)
            {
                mapofindividualobject = (Map<String,Object>)o;
                System.debug('mapofindividualobject'+mapofindividualobject);
                Object obj1 = mapofIndividualObject.get('Airport__c');
                Object obj2 = mapofIndividualObject.get('Arrival_Airport_Code__c');
                Object obj3 = mapofIndividualObject.get('Arrival_Terminal__c');
                //Object obj4 = mapofIndividualObject.get('Arrival_Time__c');
                Object obj5 = mapofIndividualObject.get('Departure_Airport_Code__c');
                Object obj6 = mapofIndividualObject.get('Departure_Terminal__c');
                //Object obj7 = mapofIndividualObject.get('Departure_Time__c');
                Object obj8 = mapofIndividualObject.get('Airline');
                System.debug('obj1:---'+obj1);
                System.debug('obj2:---'+obj2);
                System.debug('obj3:---'+obj3);
              //  System.debug('obj4:---'+obj4);
                System.debug('obj5:---'+obj5);
                System.debug('obj6:---'+obj6);
               // System.debug('obj7:---'+obj7);
                System.debug('obj8:---'+obj8);
                
                //Object obj2 = mapofIndividualObject.get('');
                //Object obj3 = mapofIndividualObject.get('');
                String o1 = (String)obj1;
                System.debug('o1:-'+o1);
                String o2 = (String)obj2;
                System.debug('o2:-'+o2);
                String o3 = (String)obj3;
                System.debug('o3:-'+o3);
                //String o4 = (String)obj4;
              //  System.debug('o1:-'+o4);
                String o5 = (String)obj5;
                System.debug('o5:-'+o5);
                String o6 = (String)obj6;
                System.debug('o6:-'+o6);
                //String o7 = (String)obj7;
                //System.debug('o1:-'+o7);
                String o8 = (String)obj8;
                System.debug('o8:-'+o8);
                //String o2 = (String)obj2;
                //System.debug('o2:--'+o2);
                //String o3 = (String)obj3;
                //System.debug('o3;;'+o3);
              
                w.Airport = o1;
                system.debug('w**'+w);
                w.Arrivalairportcode = o2;
                  system.debug('w**'+w);
                w.Arrivalterminal = o3;
                  system.debug('w**'+w);
                //w.Arrivaltime = o4;
                w.Departureairportcode = o5;
                  system.debug('w**'+w);
                w.Departureerminal = o6;
                  system.debug('w**'+w);
             // w.Departuretime = o7;
                w.Airline = o8;
                system.debug('w**'+w);
                listofWrapper.add(w);
                system.debug('listofWrapper:--------'+listofWrapper);
            }
          
        }
 
}}