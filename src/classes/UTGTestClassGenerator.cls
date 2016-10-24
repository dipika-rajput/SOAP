/*
*    Description    :    Apex controller for UTGClassInformation that displays the available list of Apex
*                        class and displays their corresponding Methods 
*/

public with sharing class UTGTestClassGenerator {	
    //Constants
    public static final String TOKEN_SLASH_N = '\\n';
    public static final String TOOLING_API_RELATIVE_URL = '/services/data/v30.0/tooling/';
    
    //Data Member Declaration
    public List<ApexClass> apexClassList { get; set; } 
    public List<SelectOption> selectClassList { get; set; } 
    public String strSelectedClassId { set; get; }
    public list<SelectOption> stdObjectList { get; set; }
    public list<String> MethodNames{ get; set; }
    public list<String> ReturnTypes{ get; set; }
    public list<String> Parameters{ get; set; }
    public list<String> AccessSpecifiers{ get; set; }
    public list<String> methodSignature { get; set; }
    public String strClassName { get; set; }
    public Map<String,Object> testResult;
    public Map<String,Object> testResult1;
    public List<Object> resultsObject;
    public List<Object> resultsObject1;
    public String responseBody;
    
    //Method Signature Parameters
    public Integer IndexbodyLines;
    public String totalMethodSignature = '';
    public Integer charcterCount;
    
    // SomeValues to be store
    public String oid ;
    public String cid ;
    public String apmid ;
    public String carid ;
    
    String strSelectedClassName;
       
        
    public static String baseUrl = URL.getSalesforceBaseUrl().toExternalForm() 
                                    + TOOLING_API_RELATIVE_URL;
                        
    
    //Constructor
    public UTGTestClassGenerator() {
        init();
    }
        
    //public Methods
    // create a http request with required endpoint and request method
    public HttpRequest createHttpRequest(String endpoint, String method) {
        HttpRequest req = new
        HttpRequest();
        endpoint += '';
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(endpoint);
        req.setMethod(method);
        return req;
    
    }   
    public string createMetadataContainer() {
    	String nameMetaContainer = '"M '+ String.valueof(system.now())+'"';
        HttpRequest req = createHttpRequest(baseUrl+'sobjects/MetadataContainer','POST');
        req.setBody('{"Name":'+nameMetaContainer+'}');
        String response = getResponse(req);
        system.debug('****Response***' + response);
        Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response);
        cid = (String)rmp.get('id'); // used to save containerId
        system.debug('Metadata Container ID' + cid);
        return cid;
    }
    
     public void createStaticResource() {
    	String nameMetaContainer = '"M '+ String.valueof(system.now())+'"';
        HttpRequest req = createHttpRequest(baseUrl+'sobjects/StaticResource','POST');
        
        req.setBody('{"Name":"SR3456" , "ContentType":"application/json"}');
        system.debug('****Req**' + req);
        String response = getResponse(req);
        system.debug('****Response***' + response);
       // Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response);
       // cid = (String)rmp.get('id'); // used to save containerId
        //system.debug('Metadata Container ID' + cid);
       // return cid;
    }
    
    // mid: MetadaContainserId
    // axid: apexclass Id
    // classBody: Apex class body (updated)
    public void createApexClassMember(String mid, String axid, String classBody) {
       
        HttpRequest req = createHttpRequest(baseUrl+'sobjects/ApexClassMember','POST');
        
        req.setBody('{"MetadataContainerId" : "'+mid+'", "ContentEntityId" : "'+axid+'", "Body": "'+classbody+'"}');
        String response = getResponse(req);
        system.debug('*******Response Apex Class******' + response);
        system.debug('*******classbody******' + classbody);
        Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response);
        apmid = (String)rmp.get('id'); // Store ApexClassMember Id
    }
    
    
    public void createContainerAsyncRequest(String mid){
    	
        HttpRequest req = createHttpRequest(baseUrl+'sobjects/containerAsyncRequest','POST');
        
        req.setBody('{"MetadataContainerId" : "'+mid+'", "isCheckOnly": "false"}');
        String response = getResponse(req);
        system.debug('***Async Response*****'+response);
        Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(response);
        carid = (String)rmp.get('id');
    }  
    
    public void init(){
    	
    	strSelectedClassName = '';
        apexClassList = new List<ApexClass>();
        selectClassList = new List<SelectOption>();
        strSelectedClassId = '';
        methodSignature = new List<String>();
        MethodNames=new List<String>();
        ReturnTypes=new List<String>();
        Parameters=new List<String>();
        AccessSpecifiers=new List<String>();
        testResult=new Map<String,Object>();   
        resultsObject=new List<Object>();   
    }   
      
     //Method to generate initial copy of test class
     public String createInitialCopy(String pStrClassBody){
         system.debug('***inside createInitialCopy***');
         HTTPRequest req = new HTTPRequest();
         req.setEndpoint(baseUrl + 'sobjects/ApexClass');
         req.setMethod('POST');                    
         req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
         req.setHeader('Content-Type', 'application/json');
         req.setBody('{"Body" : "' + pStrClassBody + '"}');                              
         HttpResponse res = new Http().send(req);
         system.debug('Initial Copy Response**********'+res.getBody()); 
         
         
       // Map<String,Object> rmp = (Map<String,Object>)JSON.deserializeuntyped(res.getBody());
        Map<String, Object> rmp = (Map<String, Object>)(JSON.deserializeUntyped(res.getBody()));
        return (String)rmp.get('id'); 

     }
     
     //private methods
     // used receive response by sending a http request
    private String getResponse(HttpRequest req) {
        try {
            Http
            httpreq = new Http();
            HttpResponse
            res = httpreq.send(req);
            String reqresponse = res.getBody();
            return
            reqresponse;
        }
         catch (Exception e){
            return
        'Error:' +e.getMessage();
         }      
    }   
    
   
}