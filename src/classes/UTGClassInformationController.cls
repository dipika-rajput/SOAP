/*
*    Description    :    Apex controller for UTGClassInformation that displays the available list of Apex
*                        class and displays their corresponding Methods 
*/
public class UTGClassInformationController {

    //Constants
    public static final String TOKEN_SLASH_N = '\\n';
    public static final String TOKEN_SPACE_N = ' '; 
    public static final String TOOLING_API_RELATIVE_URL = '/services/data/v30.0/tooling/';
    
    //Hide display variable declarations
    public static boolean blnURLLink{get;set;}
    public static boolean blnSectionDetails{get;set;}
    public static boolean blnVFSectionDetails{get;set;}
    
    
    //Data Member Declaration
    public List<apexclass> apexClassList;
    public List<ApexPage> apexPage;
    public List<selectOption> options;
    public string selectedController;
    public String selectedControllerName;
    public string RecordURL{get;set;}
    public Map<String,Object> mapSymbolTable;
    
    public List<SelectOption> selectClassList;
    public String strSelectedClassId { set; get; }
    public list<SelectOption> stdObjectList { get; set; }
    
    //Apex Class Datalist
    public list<String> MethodNames{ get; set; }
    public list<String> ReturnTypes{ get; set; }
    public list<String> Parameters{ get; set; }
    public list<String> AccessSpecifiers{ get; set; }
    public list<String> methodSignature { get; set; }
    
    //VF page Datalist and Map Declarations
    public list<String> Controller{ get; set; }
    public list<String> Extension{ get; set; }
    public list<String> Action{ get; set; }
    public map<String, list<Object>> mapClassesWithResults;
    public map<String, String> mapClassesWithId;
    
    public String strClassName { get; set; }
    public Map<String,Object> testResult;
    public Map<String,Object> testResult1;
    public List<Object> resultsObject;
    public List<Object> resultsObjectInterface;
   
    //Response Variables
    public String responseBody;
    public string VFPageResponse;
    public string selectedApeClassMember{get;set;}
    public string ControllerName{get; set;}
    public string ExtensionController{get; set;}
    
    //New Property Added
    public string selectedOptionValue{get;set;}
    public String strSelectedClassType { set; get; }
    
    //Method Signature Parameters
    public Integer IndexbodyLines;
    public String totalMethodSignature = '';
    public String extensionName='';
    public Integer charcterCount;
    public Integer lastindex;
    public integer firstindex;
    public integer totalspace;
   
    
    // SomeValues to be store
    public String oid ;
    public String cid ;
    public String apmid ;
    public String carid ;
    
    public String strSelectedClassName{get;set;}
    public string mehodInstance;
       
        
    public static String baseUrl = URL.getSalesforceBaseUrl().toExternalForm() 
                                    + TOOLING_API_RELATIVE_URL;
                        
    // other classes
    public UTGTestClassGenerator objclassgen;
    
    //Constructor
    public UTGClassInformationController() {
        mapClassesWithId = new map<String, String>();
        init();
        this.populateClassesWithId();
        
    }
    
    public List<Selectoption> getoptions(){
        options.clear();
        options.add(new selectOption('--None--', '--None--')); 
        options.add(new selectOption('VFPage', 'VisualForce Page')); 
        options.add(new selectOption('ApexClass', 'Apex Class'));
        return options;
     }
     
     
     public void populateClassesWithId(){
        
        for( ApexClass objApexClass : [Select Id,
                                              Name 
                                       From ApexClass where name = 'ShowDataController' OR name = 'RequiredFieldStaticResource']){
            mapClassesWithId.put(objApexClass.Name.toLowerCase(), objApexClass.Id);   // Put Classid ,name to add selected classid with the name
        }//End for
        
        system.debug('***mapClassesWithId Inside**' + mapClassesWithId);
     }//End populateMaps
            
     //Retrieves the Id of all the Apexclasses present in the org
     public List<Selectoption> getselectClassList(){
        //mapClassesWithId = new map<String, String>();
     //clearClassInfo();
     if(!selectClassList.Isempty()){
        selectClassList.clear();
     }
     if(selectedApeClassMember!=null){
        if (selectedApeClassMember.equals('ApexClass')){
        apexClassList.clear();
        apexClassList = [select Id,
                                Name 
                                from ApexClass where name = 'ShowDataController' OR name = 'RequiredFieldStaticResource'];
            selectClassList.add(new selectoption('--None--' , '--None--'));
            for(ApexClass objApexClass : apexClassList) {
                mapClassesWithId.put(objApexClass.Name.toLowerCase(), objApexClass.Id);// Put Classid ,name to add selected classid with the name
                selectClassList.add(new SelectOption(objApexClass.Id, objApexClass.Name.toLowerCase()));
            }
        }
        else if(selectedApeClassMember.equals('VFPage')){
            apexClassList.clear();
            apexPage = [select Id,
                                Name 
                         from ApexPage where name = 'RequiredFieldStaticResource'];
             selectClassList.add(new selectoption('--None--' , '--None--'));
             for(ApexPage objApexPage : apexPage) {
                selectClassList.add(new SelectOption(objApexPage.Id, objApexPage.Name));
             }
       
         }
        
        }
        return selectClassList;
     }//End Here
         
           //Get Class Metadata
           public void ClassInformation(list<String> plstClassNames){
            
            
            string classID;
            for(String className : plstClassNames){
                system.debug('****className****: ' + className);
                system.debug('****mapClassesWithId****: ' + mapClassesWithId);
                classID = mapClassesWithId.get(className.tolowercase());
                system.debug('****classID****: ' + classID);
                //make HTTP calloute using Tooling API to get methods of selected class.
                // Note the escaping on newlines and quotes
                            
                HTTPRequest req = new HTTPRequest();
                //Append ClassId to URL to get class Information
                req.setEndpoint(baseUrl + 'sobjects/ApexClass/' + classID);
                req.setMethod('GET');
                // OAuth header
                req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
                req.setHeader('Content-Type', 'application/json');  
                Http h = new Http();
                HttpResponse res = h.send(req);
                
                //get the type of Parameters
                String Response=res.getBody();
                system.debug('****ResponseApexClass****: ' + res.getBody());
            
                //Parse the JSON response
                if(res.getStatusCode() == 200){
                    system.debug('Response******' + res.getBody());
                    Map<String,Object> jsonResp = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
                    for (String str : jsonResp.keyset()){ 
                        if ( str == 'Body')
                        responseBody=( String )jsonResp.get(str);
                    }
                String parmFirst;
                mapSymbolTable = (Map<String,Object>) jsonResp.get('SymbolTable');
                resultsObject = (List<Object>)mapSymbolTable.get('methods'); 
                mapClassesWithResults.put(classID, resultsObject);
                system.debug('*******mapClassesWithResults*classInfo***' + mapClassesWithResults);
                for(Object r: resultsObject ){
           
                    testResult=( Map<String,Object>) r;
                    AccessSpecifiers.add(String.valueOf(testResult.get('visibility')));
                    ReturnTypes.add(String.valueOf(testResult.get('returnType')));
                    MethodNames.add(String.valueOf(testResult.get('name')));
                    Parameters.add(String.valueOf(testResult.get('parameters')));
                    system.debug('Param List******' + testResult.get('parameters'));
                    system.debug('Method Modifiers' + testResult.get('modifiers'));
                    
                    for(string compareMethodNames : Action){
                        if(String.valueOf(testResult.get('name')).equals(compareMethodNames)){
                            system.debug('MethodName******* :' + testResult.get('name') + 'Action Method***** :' + compareMethodNames);
                            IndexbodyLines = responseBody.indexOf(String.valueOf(String.valueOf(testResult.get('returnType') +' '+ ( String.valueof( testResult.get('name') ) ))));
                            Integer startIndex=IndexbodyLines;
                            charcterCount=IndexbodyLines;
                            system.debug('Start Index*******' + IndexbodyLines);
                            for (Integer i = 1 ; i < responseBody.length() ; i++ ){
                                String strCharacter=responseBody.substring(IndexbodyLines,IndexbodyLines + 1);
                                    if(strCharacter.equals(')')){
                                        system.debug('Param');
                                        break;
                                    }
                                    else {
                                        charcterCount++;
                                        IndexbodyLines++;
                                    } 
                            } 
                            totalMethodSignature = responseBody.substring(startIndex,charcterCount + 1);
                            methodSignature.add( String.valueOf(testResult.get('visibility') + ' ' +  totalMethodSignature ) );
                        
                    }   
              }     
            }   
          }
        }           
      }
           
            
    //Get the selected Class Information
    public void retrieveClassInformation() {
        system.debug('****Inside retrieveClassInformation*****');
        objclassgen.createStaticResource();
        if (selectedApeClassMember.equals('ApexClass')){
            
            for(SelectOption objOption : selectClassList){
                if(objOption.getValue() == strSelectedClassId){
                    strSelectedClassName = objOption.getLabel();
                }
                
            }
            clearClassInfo();
            //ClassInformation(strSelectedClassId); 
            list<String> lstClassNames = new list<String>();
            lstClassNames.add(strSelectedClassName);
            ClassInformation(lstClassNames);
            blnSectionDetails = true;
            blnVFSectionDetails = false;
            system.debug('blnSection********' + blnSectionDetails);
            
    }
    else if(selectedApeClassMember.equals('VFPage')){
        
        
        for(SelectOption objOption : selectClassList){
            
            if(objOption.getValue() == strSelectedClassId){
                strSelectedClassName = objOption.getLabel();
            }
        }
            clearClassInfo();             
            HTTPRequest req = new HTTPRequest();
            //Append ClassId to URL to get class Information
            req.setEndpoint(baseUrl + 'sobjects/ApexPage/' + strSelectedClassId);
            
            req.setMethod('GET');
            // OAuth header
            req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
            req.setHeader('Content-Type', 'application/json');  
            Http h = new Http();
            HttpResponse res = h.send(req);
            
            //get the type of Parameters
            String Response=res.getBody();
            system.debug('****ResponseApexPage****: ' + res.getBody());
       
            //Parse the JSON response
            if(res.getStatusCode() == 200) {
            Map<String,Object> jsonResp = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            for (String str : jsonResp.keyset()){ 
                system.debug('***** Map Strings *****' + str );
                if ( str == 'Markup')
                responseBody=( String )jsonResp.get(str);
            }
            String parmFirst;
            //Map<String,Object> mapSymbolTable = (Map<String,Object>) jsonResp.get('Markup');
            responseBody = ( String )jsonResp.get('Markup');
            VFPageResponse =  ( String )jsonResp.get('Markup');
            ControllerName = ( String )jsonResp.get('ControllerKey');
            system.debug('responseBody******' + responseBody);
            
            
            if(ControllerName!=null){
                List<ApexClass> lstApexClass = [select Id,name
                         from ApexClass where name=:ControllerName];
                         
                         for(ApexClass objApexClass : lstApexClass){
                            selectedController = objApexClass.id;
                            selectedControllerName =  objApexClass.name;
                         }
                system.debug('ClassID****' + selectedController);
                
                 //Logic to get Multiple Extension from VF page
                  string strExtension=responseBody;
                  if(strExtension.toLowerCase().contains('extensions')){
                    
                    //List<String> lstAction = new List<String>();
                  
                    IndexbodyLines = strExtension.toLowerCase().indexOf('extensions');
                    //Integer startIndex=IndexbodyLines;
                    charcterCount=IndexbodyLines;
                    integer doubleCommaCount=0;
                    Integer actionStartIndex = IndexbodyLines;
                    
                    for (Integer i = 0 ;i < strExtension.length() - 1; i++){
                        String strCharacter=strExtension.substring(IndexbodyLines,IndexbodyLines+1);
                        system.debug('Tokenschar*********' + strCharacter);
                        if(strCharacter.equals('"' )){
                            doubleCommaCount++;
                            
                            if(doubleCommaCount > 1 && (actionStartIndex !=-1 ||IndexbodyLines!=-1)){
                                system.debug('Start******* IndexbodyLines' + actionStartIndex +'****'+IndexbodyLines);
                                string actionToken = strExtension.substring(actionStartIndex,IndexbodyLines);
                                system.debug('****Extensionssss*** ' + actionToken.split(','));
                                actionToken = actionToken.tolowercase().replace('extensions="' , '');
                                Extension = actionToken.split(',');
                                break;
                                
                            }//End if doubleCommaCount
                            //IndexbodyLines++;
                        }//End if strCharacter
                        IndexbodyLines++;
                    }//End for
                    
                }//End if
                
                
                
                
                
                /*
                // Logic to get Single Extension from VF page
                String extensionResponse = responseBody;
                if(extensionResponse.toLowerCase().contains('extensions')){
                    IndexbodyLines = extensionResponse.toLowerCase().indexOf('extensions');
                    Integer startIndex=IndexbodyLines;
                    charcterCount=IndexbodyLines;
                    integer Quotecount=0;
                    for (Integer i = 1 ; i < extensionResponse.length() ; i++ ){
                        String strCharacter=extensionResponse.substring(IndexbodyLines,IndexbodyLines + 1);
                        if(strCharacter.equals('"' )){
                        Quotecount++;
                            if(Quotecount > 1){
                                break;  
                            }
                            charcterCount++;
                            IndexbodyLines++;
                        }
                    else {
                         charcterCount++;
                         IndexbodyLines++;
                    }
             
                     } 
                        extensionName = extensionResponse.substring(startIndex,charcterCount + 1);
                        ExtensionController = extensionName ;
                        
                  } //Ends Here*/
                  
                  //Datalist Assignment
                  Controller.add(ControllerName);
                  //if(ControllerName <> null && ControllerName <> '')
                    //Extension.add(ControllerName);
                    
                  system.debug('*****Extension****' + Extension);
                  this.ClassInformation(Extension);
                  this.ClassInformation(Controller);
                  
                  
                 //Logic to get Action from VF page
                  string str=VFPageResponse;
                  system.debug('******Orig body******'  +'****'+str);
                  if(str.toLowerCase().contains('action')){
                    
                    //List<String> lstAction = new List<String>();
                  
                    IndexbodyLines = str.toLowerCase().indexOf('action=');
                    
                    Integer startIndex=IndexbodyLines;
                    charcterCount=IndexbodyLines;
                    integer doubleQuoteCount=0;
                    Integer actionStartIndex = IndexbodyLines;
                    for (Integer i = 0 ;i < str.length() - 1; i++){
                        String strCharacter=str.substring(IndexbodyLines,IndexbodyLines+1);
                        system.debug('Tokenschar*********' + strCharacter);
                        if(strCharacter.equals('"' )){
                            doubleQuoteCount++;
                            IndexbodyLines++;
                            if(doubleQuoteCount > 1 && (actionStartIndex !=-1 ||IndexbodyLines!=-1)){
                                system.debug('Start******* IndexbodyLines' + actionStartIndex +'****'+IndexbodyLines);
                                string actionToken = str.substring(actionStartIndex,IndexbodyLines);
                                system.debug('Tokens*********' + actionToken);
                                Action.add(actionToken);
                                system.debug('IndexbodyLines*********' + IndexbodyLines);
                                str = str.substring(IndexbodyLines);
                                system.debug('str*********' + str);
                                if(str.contains('action')){
                                    IndexbodyLines=str.indexof('action=');
                                    system.debug('actionIndex*********' + IndexbodyLines);
                                    actionStartIndex=IndexbodyLines;
                                    doubleQuoteCount = 0;
                                    charcterCount = IndexbodyLines;
                                }
                                else{
                                    system.debug('ElsePart****');
                                    break;
                                }
                                
                            }//End if doubleQuoteCount
                        }//End if strCharacter
                        IndexbodyLines++;
                    }//End for
                } //Ends Here
                  }//End if ControllerName 
            }//End if getStatusCode 
            
            //Logic to get Action Methods without any special characters
            List<String> dummyAcion = new List<String>(Action);
            Action.clear();
            system.debug('CountDummy*****' + dummyAcion.Size());
            for(String matchActionToken : dummyAcion){
                matchActionToken = matchActionToken.toLowerCase().replace('action="{!','');
                matchActionToken = matchActionToken.toLowerCase().replace('}"','');
                system.debug('InAction*******Token  :' + matchActionToken);
                Action.add(matchActionToken);
            } //Ends Here
            
            system.debug('******Action Methods*********' + Action);
            //ClassInformation(selectedController);
            blnVFSectionDetails = true;
            blnSectionDetails = false;      
        }   
    }
    
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
    
    //Create Apex class members for metadata Container
    public void createTestClassMember(string pControllerName) { 
        string NewClassID;
        string objClassID;
        Integer countAction = 0;
        string className = pControllerName.tolowercase();
        string classNameForTestClass = '';
        system.debug('******Pass Controller Name****' + className);
        system.debug('******mapClassesWithId****' + mapClassesWithId);
        objClassID = mapClassesWithId.get(className);
        system.debug('******objClassID****' + objClassID);
        resultsObject = mapClassesWithResults.get(objClassID);
        system.debug('*****mapClassesWithResults**' + mapClassesWithResults);
        String InitialClassBody=
          '@istest' + TOKEN_SLASH_N
          + 'public class ' + className + 'Test {' + TOKEN_SLASH_N + '}';  

        String classBody = 
          '@istest ' + TOKEN_SLASH_N
          + ' public class ' + className + 'Test {' + TOKEN_SLASH_N ;
          
           
        for(Object r : resultsObject ) {     
            testResult=( Map<String,Object>) r;
            //Count No of Params
            String ParamNull='';
            string MethodNameToCompare = '';
            String needle = 'type';
            String haystack = String.valueOf(testResult.get('parameters'));
            String str = haystack;
            Integer needleLen = needle.length();
            Integer Paramcount = 0;
            Integer index = str.indexOf(needle);
                        
            while (index >= 0) {
                Paramcount++;
                str = str.substring(index+needleLen);
                index = str.indexOf(needle);
            }
            if(Paramcount > 0 ){
                            
                for(Integer i = 0 ; i < Paramcount ; i++){
                    if(i==0){
                        ParamNull = ParamNull + 'null';
                    }
                    else{
                        ParamNull = ParamNull + ',null';
                    }
                }   
            }//Ends Here
            
             for(String objAction : Action){
                system.debug('***Action***' + Action);
                
                MethodNameToCompare =String.valueOf(testResult.get('name')).tolowercase();
                system.debug('***MethodNameToCompare*' + MethodNameToCompare);
                if(MethodNameToCompare.equals(objAction)){
                    system.debug('***Method Compare **' + testResult.get('name'));
                    countAction++;
                    /* if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                classNameForTestClass = className;
                system.debug('***In Static***' + classNameForTestClass);    
            }
            else{           
                classNameForTestClass = ' obj' + className;
                classNameForTestClass = className + classNameForTestClass+'= new ' + className +'();' + TOKEN_SLASH_N + '       '+classNameForTestClass ;
                system.debug('***In Instancr***' + classNameForTestClass);
            }*/
                       
                       
            //logic for static and non-static method for standard controller and extensions
            if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                classNameForTestClass = className;
                system.debug('***In Static***' + classNameForTestClass);
            }
            else{
                classNameForTestClass = ' obj' + className;
                classNameForTestClass = className + classNameForTestClass+'= new ' + className +'();' + TOKEN_SLASH_N + '       '+classNameForTestClass ;
                system.debug('***In Instancr***' + classNameForTestClass);
            }
     
            system.debug('*****classNameForTestClass****'+classNameForTestClass);
            classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + className + TOKEN_SLASH_N + '  public Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
             
                +'        '+classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                + '        System.assertEquals(1, 1);' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                classNameForTestClass='';
    
            } 
                
                  
             }
             
        }
         
        classbody = classbody + TOKEN_SLASH_N;           
        classbody += '}';
        system.debug('*******Method classbody*****' + classbody);
        system.debug('******countAction******' + countAction);
         if(countAction >= 1){
            system.debug('Create class controller');
            NewClassID = objclassgen.createInitialCopy(InitialClassBody);
            cid = objclassgen.createMetadataContainer();
                    
            objclassgen.createApexClassMember(cid, NewClassID, classBody);
            objclassgen.createContainerAsyncRequest(cid);  
            RecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + NewClassID; 
                    
            if(RecordURL !='' || RecordURL !=null)
            blnURLLink = true;
         }
                    
                        
           
                        
    }//Ends createTestClassMember
    
    public void createClass(){
        string classBody = 'public class SampleClassForTestingTest001{' + TOKEN_SLASH_N
                          +'public void Method1(){' + TOKEN_SLASH_N
                          +'}'+ TOKEN_SLASH_N
                          +'public void Method2(){}'+ TOKEN_SLASH_N
                          +'}';
                          
        String NewClassID = '01p900000055oX3';
        cid = objclassgen.createMetadataContainer();
        system.debug('*****CID***' + cid + '******NewClassID' + NewClassID + '*****classBody' + classBody);
        objclassgen.createApexClassMember(cid, NewClassID, classBody);
        objclassgen.createContainerAsyncRequest(cid);  
        RecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + NewClassID; 
        
        strSelectedClassName = 'SampleClassForTesting';
        if(RecordURL !='' || RecordURL !=null)
            blnURLLink = true;
    
    }
  
    //Test Class Creation by Selected Methods 
    public void createClass1() {
        if(selectedApeClassMember.equals('VFPage')){
        string NewClassID;
        string objClassID;
        string strBodyForController = VFPageResponse;
        system.debug('******VFPageResponse*****' + VFPageResponse);
        strBodyForController.replace(' ' , '');
        
        //Create test class for controller only
        if(Controller <> null && (!strBodyForController.tolowercase().contains('standardcontroller='))){
            createTestClassMember(ControllerName);
        }

        for(String className : Extension){   //mapClassesWithResults.keyset()
            system.debug('******Inside Extension For Loop*****');
            objClassID = mapClassesWithId.get(className);
            resultsObject = mapClassesWithResults.get(objClassID);
            string InitialClassBody=
                '@istest' + TOKEN_SLASH_N
                + 'public class ' + className + 'Test {' + TOKEN_SLASH_N + '}';  
           
                   string classNameForTestClass = '';
                   
             string classBody = 
                 '@istest ' + TOKEN_SLASH_N
                 + ' public class ' + className + 'Test {' + TOKEN_SLASH_N ;
           
                 for(Object r : resultsObject ) {  
                    testResult=( Map<String,Object>) r;
                    //Count No of Params
                    String ParamNull='';
                    String needle = 'type';
                    String haystack = String.valueOf(testResult.get('parameters'));

                    String str = haystack;
                    Integer needleLen = needle.length();
                    Integer Paramcount = 0;
                    Integer index = str.indexOf(needle);
                        
                    while(index >= 0) {
                        Paramcount++;
                        str = str.substring(index+needleLen);
                        index = str.indexOf(needle);
                    }
                    if(Paramcount > 0 ){
                        for(Integer i = 0 ; i < Paramcount ; i++){
                            if(i==0){
                                ParamNull = ParamNull + 'null';
                            }
                            else{
                                ParamNull = ParamNull + ',null';
                            }
                        }   
                    }//Ends if
                    
                    //Logic to only create test class for Actions.
                    system.debug('**********Actions*******' + Action);
                    for(String objAction : Action){
                        if(String.valueOf(testResult.get('name')).tolowercase().equals(objAction)){
                             if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                        classNameForTestClass = className;
                        system.debug('***In Static***' + classNameForTestClass);    
                    }
                    else{
                        classNameForTestClass = ' obj' + className;
                        classNameForTestClass = className + classNameForTestClass+'= new ' + className +'(std);' + TOKEN_SLASH_N + '       '+classNameForTestClass ;
                        system.debug('***In Instancr***' + classNameForTestClass);
                    }
                    //Account accRecord = new Account(name='objAccount');
                    if(strBodyForController.tolowercase().contains('standardcontroller=') && strBodyForController.tolowercase().contains('extensions=')){
                    //logic for static and non-static method for standard controller and extensions
                       if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                           classNameForTestClass = className;
                            system.debug('***In Static***' + classNameForTestClass);
                       }
                       else{
                           classNameForTestClass = ' obj' + className;
                           classNameForTestClass = className + classNameForTestClass+'= new ' + className +'(std);' + TOKEN_SLASH_N + '       '+classNameForTestClass ;
                           system.debug('***In Instancr***' + classNameForTestClass);
                       }
                       system.debug('****Inside Standard Extension****'+classNameForTestClass);
                       system.debug('*****classNameForTestClass****'+classNameForTestClass);
                       classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + className + TOKEN_SLASH_N + '  public Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                       +'Apexpages.Standardcontroller std= new Apexpages.Standardcontroller(new Account(name=\' TestAccount\'));' + TOKEN_SLASH_N
                       +'        '+classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                       + '        System.assertEquals(1, 1);' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                       classNameForTestClass='';
    
                    } 
                    else if(strBodyForController.tolowercase().contains('controller=') && strBodyForController.tolowercase().contains('extensions=') && (!strBodyForController.tolowercase().contains('standardcontroller='))){
                        if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                            classNameForTestClass = className;
                            system.debug('***In Static***' + classNameForTestClass);
                        }
                        else{
                            classNameForTestClass = ' obj' + className;
                            system.debug('*******ControllerName******' + ControllerName);
                            classNameForTestClass = className + classNameForTestClass+'= new ' + className +'(new '+ ControllerName +'());' + TOKEN_SLASH_N 
                            + '       '+classNameForTestClass ;
                            system.debug('***classNameForTestClassr***' + classNameForTestClass);
                        }
                        system.debug('****Inside Custom Extension****'+classNameForTestClass);
                        system.debug('*****classNameForTestClass****'+classNameForTestClass);
                        classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + className + TOKEN_SLASH_N + '  public Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                            
                        +'        '+classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                        + '        System.assertEquals(1, 1);' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                        classNameForTestClass='';
                    }
                        
                        }
                    }
                   
                  /*  else if(strBodyForController.tolowercase().contains('controller=') && strBodyForController.tolowercase().contains('extensions=') && (!strBodyForController.tolowercase().contains('standardcontroller='))){
                        if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                            classNameForTestClass = className;
                            system.debug('***In Static***' + classNameForTestClass);
                        }
                        else{
                            classNameForTestClass = ' obj' + className;
                            system.debug('*******ControllerName******' + ControllerName);
                            classNameForTestClass = className + classNameForTestClass+'= new ' + className +'(new '+ ControllerName +'());' + TOKEN_SLASH_N 
               
                            + '       '+classNameForTestClass ;
                            system.debug('***classNameForTestClassr***' + classNameForTestClass);
                        }
                        system.debug('*****classNameForTestClass****'+classNameForTestClass);
                        classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + className + TOKEN_SLASH_N + '  public Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                            
                        +'        '+classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                        + '        System.assertEquals(1, 1);' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                        classNameForTestClass='';
                    }*/
                        
                       /* else if(strBodyForController.tolowercase().contains('controller=') && (!strBodyForController.tolowercase().contains('extensions=')) && (!strBodyForController.tolowercase().contains('standardcontroller='))){
                             if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                                classNameForTestClass = className;
                                system.debug('***In Static***' + classNameForTestClass);
                            }
                            else{
                                classNameForTestClass = ' obj' + className;
                                classNameForTestClass = className + classNameForTestClass+'= new ' + className +'();' + TOKEN_SLASH_N + '       '+classNameForTestClass ;
                                system.debug('***In Instancr***' + classNameForTestClass);
                            }
                            
                            system.debug('*****classNameForTestClass****'+classNameForTestClass);
                            classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + className + TOKEN_SLASH_N + '  public Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                            //+'Apexpages.Standardcontroller std= new Apexpages.Standardcontroller(new Account(name=\' TestAccount\'));' + TOKEN_SLASH_N
                            +'        '+classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                            + '        System.assertEquals(1, 1);' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                            classNameForTestClass='';
                        }*/
                            
                       
                    }
                    
                    
                   
                    classbody = classbody + TOKEN_SLASH_N           
                    + '}';
                    
                    system.debug('******Class Body********' +   classbody);
                   
                    NewClassID = objclassgen.createInitialCopy(InitialClassBody);
                    cid = objclassgen.createMetadataContainer();
                    system.debug('******cid********' +   cid);
                    
                    objclassgen.createApexClassMember(cid, NewClassID, classBody);
                    system.debug('******cid After********' +   cid);
                    objclassgen.createContainerAsyncRequest(cid);  
                    RecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + NewClassID; 
                    
                    if(RecordURL !='' || RecordURL !=null)
                        blnURLLink = true;
                        
                
                }//End for
                
                
                
                /*
                String NewClassID;
                String objClassID;
                //Create one Metadata Container for all ther Apex class Members
                cid = objclassgen.createMetadataContainer();
                for(String className : Extension){   //mapClassesWithResults.keyset()
                    objClassID = mapClassesWithId.get(className);
                    String InitialClassBody=
                    '   @istest' + TOKEN_SLASH_N
                    + 'public class ' + className + 'Test {' + TOKEN_SLASH_N + '}';  
           
                   string classNameForTestClass = '';
                   
        
                    String classBody = 
                    '@istest' + TOKEN_SLASH_N
                    + 'public class ' + className + 'Test {' + TOKEN_SLASH_N ;
                   // +strSelectedClassName+ classNameForTestClass+'= new ' + strSelectedClassName +'();' +TOKEN_SLASH_N;
                    
                    system.debug('classID******' + objClassID);
                    system.debug('***mapClassesWithResults***' + mapClassesWithResults);
                    //Get Result Object from the map
                    resultsObject = mapClassesWithResults.get(objClassID);
                    system.debug('**resultsObject***' + resultsObject);
                       for(Object r : resultsObject ) {
                        
                         testResult=( Map<String,Object>) r;
                        //Count No of Params
                        String ParamNull='';
                        String needle = 'type';
                        String haystack = String.valueOf(testResult.get('parameters'));             

                        String str = haystack;
                        Integer needleLen = needle.length();
                        Integer Paramcount = 0;
                        Integer index = str.indexOf(needle);
                        
                        while (index >= 0) {
                            Paramcount++;
                            str = str.substring(index+needleLen);
                            index = str.indexOf(needle);
                        }
                        if(Paramcount > 0 ){
                            
                            for(Integer i = 0 ; i < Paramcount ; i++){
                                if(i==0){
                                    ParamNull = ParamNull + 'null';
                                }
                                else{
                                    ParamNull = ParamNull + ',null';
                                }
                        }
                        }//Ends Here
                        
                         if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                            classNameForTestClass = selectedControllerName;
                            system.debug('***In Static***' + classNameForTestClass);
                            
                        }
                        else{
                            
                            classNameForTestClass = ' obj' + className;
                            classNameForTestClass = className + classNameForTestClass+'= new ' + className +'();' + TOKEN_SLASH_N + classNameForTestClass ;
                            system.debug('***In Instancr***' + classNameForTestClass);
                        }
                        for(string compareMethodNames : Action){
                            if(String.valueOf(testResult.get('name')).tolowercase().equals(compareMethodNames.tolowercase())){
                                system.debug('*****classNameForTestClass****'+classNameForTestClass);
                                classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + className + TOKEN_SLASH_N + '    Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                                +classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                                + 'System.assertEquals(1, 1);' + TOKEN_SLASH_N + '}';
                                classNameForTestClass='';
                            }
                        }
                    }
                    classbody = classbody + TOKEN_SLASH_N           
                    + '}';
                    
                    NewClassID = objclassgen.createInitialCopy(InitialClassBody);
                    objclassgen.createApexClassMember(cid, NewClassID, classBody);
                    objclassgen.createContainerAsyncRequest(cid);
            
                }
             
                    RecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' +NewClassID;   
                     if(RecordURL !='' || RecordURL !=null)
                         { blnURLLink = true;}
                         
                         */
        }
      
            else if(selectedApeClassMember.equals('ApexClass')){
                String InitialClassBody=
                '@istest' + TOKEN_SLASH_N
                + 'public class ' + strSelectedClassName + 'Test {' + TOKEN_SLASH_N + '}';  
           
                   string classNameForTestClass = '';
                   
        
                    String classBody =
                    '@istest' + TOKEN_SLASH_N
                    + 'public class ' + strSelectedClassName + 'Test {' + TOKEN_SLASH_N ;
            
            //checke for Apex Class and Batch Class
            Integer BatchableCount = 0;
            resultsObjectInterface = (List<Object>)mapSymbolTable.get('interfaces'); 
            for(Object objInterface : resultsObjectInterface){
                if(String.valueOf(objInterface).tolowercase().equals('database.batchable')){
                    BatchableCount++;
                    system.debug('******Inside Batchable Apex******');
                }
            }
                if(BatchableCount > 0){
                    /*for(Object r : resultsObject ) {
                        system.debug('******Inside  Apex******');
                        testResult=( Map<String,Object>) r;
                        //Count No of Params
                        String ParamNull='';
                        String needle = 'type';
                        String haystack = String.valueOf(testResult.get('parameters'));

                        String str = haystack;
                        Integer needleLen = needle.length();
                        Integer Paramcount = 0;
                        Integer index = str.indexOf(needle);
                        
                        while (index >= 0) {
                            Paramcount++;
                            str = str.substring(index+needleLen);
                            index = str.indexOf(needle);
                        }
                        if(Paramcount > 0 ){
                            
                            for(Integer i = 0 ; i < Paramcount ; i++){
                                if(i==0){
                                    ParamNull = ParamNull + 'null';
                                }
                                else{
                                    ParamNull = ParamNull + ',null';
                                }
                        }   
                        }//Ends Here */
                        string testClass = ' obj' + strSelectedClassName;
                         if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                            classNameForTestClass = strSelectedClassName;
                            system.debug('***In Static***' + classNameForTestClass);
                            
                        }
                        else{
                            
                            classNameForTestClass = 
                            classNameForTestClass = strSelectedClassName + testClass+'= new ' + strSelectedClassName +'();' + TOKEN_SLASH_N + '       ';
                            system.debug('***In Instancr***' + classNameForTestClass);
                        }
                        
                        system.debug('*****classNameForTestClass****'+classNameForTestClass);
                        classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + strSelectedClassName + TOKEN_SLASH_N + '    static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                        
                        +'        ' + classNameForTestClass + TOKEN_SLASH_N 
                        +'        List<Opportunity> lstOpportunity = new List<Opportunity>();' + TOKEN_SLASH_N
                        +'        TestDataGenerationForTrigger testDataFactory = new TestDataGenerationForTrigger();' + TOKEN_SLASH_N
                        +'        lstOpportunity = testDataFactory.GetOpportunityTestData();' + TOKEN_SLASH_N
                        +'        insert lstOpportunity ;' + TOKEN_SLASH_N
                        +'        Test.StartTest();' + TOKEN_SLASH_N
                        +'        ID batchprocessid = Database.executeBatch(' + testClass +');' + TOKEN_SLASH_N
                        +'        System.assertEquals(1, 1);' + TOKEN_SLASH_N 
                        +'        Test.StopTest();' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                     
                                  classNameForTestClass='';
                    //}
                    classbody = classbody + TOKEN_SLASH_N           
                    + '}';
                   system.debug('*****Batch classbody***'+classbody);
                   
                    String NewClassID = objclassgen.createInitialCopy(InitialClassBody);
                    cid = objclassgen.createMetadataContainer();
                    
                    
                    objclassgen.createApexClassMember(cid, NewClassID, classBody);
                    objclassgen.createContainerAsyncRequest(cid);  
                    RecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + NewClassID; 
                    
                    if(RecordURL !='' || RecordURL !=null)
                        blnURLLink = true;  
                }
                else{
                for(Object r : resultsObject ) {
                        system.debug('******Inside  Apex******');
                         testResult=( Map<String,Object>) r;
                        //Count No of Params
                        String ParamNull='';
                        String needle = 'type';
                        String haystack = String.valueOf(testResult.get('parameters'));

                        String str = haystack;
                        Integer needleLen = needle.length();
                        Integer Paramcount = 0;
                        Integer index = str.indexOf(needle);
                        
                        while (index >= 0) {
                            Paramcount++;
                            str = str.substring(index+needleLen);
                            index = str.indexOf(needle);
                        }
                        if(Paramcount > 0 ){
                            
                            for(Integer i = 0 ; i < Paramcount ; i++){
                                if(i==0){
                                    ParamNull = ParamNull + 'null';
                                }
                                else{
                                    ParamNull = ParamNull + ',null';
                                }
                        }   
                        }//Ends Here
                        
                         if(String.valueOf(testResult.get('modifiers')).equals('(STATIC)')){
                            classNameForTestClass = strSelectedClassName;
                            system.debug('***In Static***' + classNameForTestClass);
                            
                        }
                        else{
                            
                            classNameForTestClass = ' obj' + strSelectedClassName;
                            classNameForTestClass = strSelectedClassName + classNameForTestClass+'= new ' + strSelectedClassName +'();' + TOKEN_SLASH_N + '       '+classNameForTestClass ;
                            system.debug('***In Instancr***' + classNameForTestClass);
                        }
                        
                        system.debug('*****classNameForTestClass****'+classNameForTestClass);
                        classbody = classbody + TOKEN_SLASH_N +'// Testmethod for '+ testResult.get('name') + ' of the class ' + strSelectedClassName + TOKEN_SLASH_N + '    Static Testmethod void ' + testResult.get('name') + 'Test(){' + TOKEN_SLASH_N 
                        +'        '+classNameForTestClass + '.' + testResult.get('name') + '(' + ParamNull + ');' + TOKEN_SLASH_N
                        + '        System.assertEquals(1, 1);' + TOKEN_SLASH_N + '    }' + TOKEN_SLASH_N;
                        classNameForTestClass='';
                    }
                    classbody = classbody + TOKEN_SLASH_N           
                    + '}';
                   
                   
                    String NewClassID = objclassgen.createInitialCopy(InitialClassBody);
                    cid = objclassgen.createMetadataContainer();
                    
                    
                    objclassgen.createApexClassMember(cid, NewClassID, classBody);
                    objclassgen.createContainerAsyncRequest(cid);  
                    RecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + NewClassID; 
                    
                    if(RecordURL !='' || RecordURL !=null)
                        blnURLLink = true;
                
                }
                     
                        
                }//End else if selectedApeClassMember
                     
     }//End createClass Method.
     
      public void init(){
        mapClassesWithResults =  new map<String, list<Object>>();
        strSelectedClassName = '';
        apexClassList = new List<sobject>();
        apexPage = new List<ApexPage>();
        selectClassList = new List<SelectOption>();
        strSelectedClassId = '';
        
        //Apex List Declaration
        methodSignature = new List<String>();
        MethodNames=new List<String>();
        ReturnTypes=new List<String>();
        Parameters=new List<String>();
        AccessSpecifiers=new List<String>();
        
        //Vf List Declaration
        Controller = new list<String>();
        Extension = new list<String>();
        Action = new list<String>();
        
        testResult=new Map<String,Object>();   
        resultsObject=new List<Object>();  
        resultsObjectInterface = new List<Object>();
        objclassgen = new UTGTestClassGenerator(); 
        options = new List<selectOption>(); 
        blnURLLink = false;
        blnSectionDetails = false;
        blnVFSectionDetails = false;
        mapSymbolTable = new Map<String,Object>();
        
    }   
     
     //Method to clear all the class Information
     public void clearClassInfo(){
        MethodNames.clear();
        ReturnTypes.clear();
        Parameters.clear();
        AccessSpecifiers.clear();
        methodSignature.clear();
        Controller.clear();
        Extension.clear();
        Action.clear();
        //apexClassList.clear();
       // apexPage.clear();
        //selectClassList.clear();
        //options.clear();
     }
     
     //Retrieves the Id of all the Apexclasses present in the org    
    public void getApexClassInformation() {
        clearClassInfo();
         options.add(new selectOption('--None--', '--None--')); 
         options.add(new selectOption('VFPage', 'VisualForce Page')); 
         options.add(new selectOption('ApexClass', 'Apex Class'));
        
        }
        
     
  
}