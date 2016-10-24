public class GoogleApiCallout {
   public class WrapperforSearch
{
    public String Links2;
    public String Titles2;
    public String Snippets2;
}
    @future (callout=true)
    public static void callingToApi(String emailbody,String idofrec)
    {
        System.debug('Inside function');
      String url = 'https://www.googleapis.com/customsearch/'+
      'v1?key=AIzaSyAm5ry8tQ1t8AArEeKPml-d333obLmH2sM&cx=011513297837430751657:jawchjbaore&q=';
      System.debug('url***'+url);
      url = url + emailbody;
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
      List<WrapperforSearch>WrapperLst2 = new List<WrapperforSearch>();
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
      
        List<Search_Result__c>Listofsearch = new List<Search_Result__c>();
      
        for(WrapperforSearch l1 : WrapperLst2)
        {
            Search_Result__c newsearchRec = new Search_Result__c();
        	newsearchRec.Email_Header__c = idofrec;
        	newsearchRec.Heading_Links__c = l1.Titles2;
            newsearchRec.Sub_Links__c = l1.Links2;
            newsearchRec.Information_related_to_topic__c = l1.Snippets2;
            Listofsearch.add(newsearchRec);
                    
             
        }
        insert Listofsearch;

        
  			Integer status = res.getStatusCode();
        	String StatusName = res.getStatus();
        
    }

}