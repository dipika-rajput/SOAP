public class googleApiqueryResultController {
@TestVisible public Map<Id,List<listofWrapper>>emailHandlerMap{get;set;}
public List<Email_Handler__c>emailHandler{get;set;}
public String Links{get;set;}
public String Titles{get;set;}
public String Snippets{get;set;}
public String Links2{get;set;}
public String Titles2{get;set;}
public String Snippets2{get;set;}
@TestVisible public listofWrapper lstwrapper{get;set;}
public WrapperforSearch lstwrapper2{get;set;}
@TestVisible public List<listofWrapper>lstwrapperList{set;get;}
public List<WrapperforSearch>WrapperLst2{get;set;}
public String SearchQueryString{get;set;}
@TestVisible
public List<listofWrapper> resultHandler{get;set;}
public String selectedQueryId{get;set;}
//callout varaibles
public HttpRequest req{get;set;}
public HttpResponse res{get;set;}
public Http h {get;set;}
public String url{get;set;}
public String jsonResponse{get;set;}

public googleApiqueryResultController()
{
  WrapperLst2 = new List<WrapperforSearch>();
    emailHandlerMap = new Map<Id,List<listofWrapper>>(); 
    emailHandler = new List<Email_Handler__c>(); 
    searchQuery();
    getemailHand();
    //searchQuery();
    //resultHandler();
    //lstwrapper = new listofWrapper();
    //lstwrapperList= new List<listofWrapper>();
}
public class WrapperforSearch
{
    public String Links2{get;set;}
    public String Titles2{get;set;}
    public String Snippets2{get;set;}
}
@TestVisible
public class listofWrapper
{
       public String Links{get;set;}
        public String Snippets{get;set;}
        public String Titles{get;set;}
        public listofWrapper(String Links,String Snippets,String Titles)
        {
           this.Links =  Links;
           this.Snippets = Snippets;
           this.Titles = Titles;
          
        }
}
public void getemailHand()
{
lstwrapperList= new List<listofWrapper>();

emailHandler = [Select id ,Email_Body__c ,Contact__r.Email,
 (Select id,Heading_Links__c,Information_related_to_topic__c,Sub_Links__c from Search_Result__r)
 from Email_Handler__c where Contact__r.Email != Null]; 

 
  for(Email_Handler__c e:emailHandler)
 {
 for(Search_Result__c s : e.Search_Result__r)
 {          
  lstwrapper = new listofWrapper(s.Sub_Links__c,s.Information_related_to_topic__c,s.Heading_Links__c);
                lstwrapper.Snippets = s.Information_related_to_topic__c; 
                system.debug('inside getemail hand snippet'+ lstwrapper.Snippets);
                 lstwrapper.Titles = s.Heading_Links__c;
                 system.debug('inside getemail hand titles'+lstwrapper.Titles);
                 lstwrapper.Links = s.Sub_Links__c;
                  system.debug('inside getemail hand links'+lstwrapper.Links);
                  System.debug('inside getemail hand******* '+lstwrapper);
                   if(emailHandlerMap.containsKey(e.id) == False)
                   {
                           System.debug('Selected Query Id in ~~~~~~'+selectedQueryId);
                         emailHandlerMap.put(e.id,new List<listofWrapper>{lstwrapper}); 
                         System.debug('first record:**'+emailHandlerMap);
                   }
                   else
                   {
                        emailHandlerMap.get(e.id).add(lstwrapper);  
                        System.debug('whole list in format of Map<id,List<wrapper>>****'+emailHandlerMap);
                   }               
  }
  }
 }
 public void resultHandler()
 {
 
 lstwrapperList= new List<listofWrapper>();
        // Snippets = s.Information_related_to_topic__c;  
                
               System.debug('id of selected%%%%'+selectedQueryId);
               System.debug('keyset of map^^^^'+emailHandlerMap.keyset());
                 lstwrapperList = emailHandlerMap.get(selectedQueryId);
                 System.debug('First List query records#################'+lstwrapperList );   
               // System.debug('lstwrapperList:-----'+lstwrapperList);
               // System.debug('title:********'+titles);
                //System.debug('links****'+links);   
      //return lstwrapperList;
     // System.debug(emailHandler);
 }
 //result searching from google 
 //@Future(Callout = True)
 public  void searchQuery()
 {   
    
      System.debug('Inside function');
      String url = 'https://www.googleapis.com/customsearch/'+
      'v1?key=AIzaSyAm5ry8tQ1t8AArEeKPml-d333obLmH2sM&cx=011513297837430751657:jawchjbaore&q=';
      System.debug('url***'+url);
      url = url + SearchQueryString;
       System.debug('final url_'+url);
      Http h = new Http();
      System.debug('http h:->'+h);
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod('GET');
      req.setHeader('charset','UTF8');
      req.setHeader('Content-Type','application/json');
      req.setHeader('accept','application/json');
      System.debug('req***'+req);
      HttpResponse res = h.send(req);
      System.debug('res:::'+res);
      String jsonResponse = res.getBody();
      System.debug('jsonResponse ::'+jsonResponse);
      Map<String, Object> mapofjson = (Map<String, Object>)JSON.deserializeUntyped(jsonResponse);
      Object itemValue = mapofjson.get('items');
      List<Object>listofObject = new List<Object>();
      listofObject = (List<Object>)itemValue;
      System.debug('listofobject:--'+listofObject); 
      Map<String,Object>mapofIndividualObject = new Map<String,Object>();
      List<WrapperforSearch> lstWrapper2 = new List<WrapperforSearch>();
     // List<WrapperforSearch>WrapperLst2 = new List<WrapperforSearch>();
      for(Object o : listofObject)
        {
            mapofIndividualObject = (Map<String,Object>)o;
            Object obj = mapofIndividualObject.get('title');
            System.debug('obj:---'+obj);
            Object obj2 = mapofIndividualObject.get('snippet');
            Object obj3 = mapofIndividualObject.get('link');
            String o1 = (String)obj;
            System.debug('o1:-'+o1);
            String o2 = (String)obj2;
             System.debug('o2:--'+o2);
            String o3 = (String)obj3;
             System.debug('o3;;'+o3);
           WrapperforSearch l = new WrapperforSearch();
          
                    l.Titles2 = o1;
                    l.Snippets2 = o2;
                    l.Links2 = o3;
                    
                    System.debug('l1*********'+l);
                    WrapperLst2.add(l); 
            
                    System.debug('Wrppper list::::'+WrapperLst2);    
        }
         
      
      
     
       
 }
 
    


}