@IsTest
public class Demo_Email_Handler_class_Test {  
          
        public static testMethod void testEmail(){
        Contact con=new Contact(FirstName='Dipika',LastName='Rajput',Email='Demo@test.com');
        insert con; 
       
            // Create a new email and envelope object (Mandatory)
            Messaging.InboundEmail email  = new Messaging.InboundEmail();
            Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
    
            // Create the email body
            email.plainTextBody = 'Demo';
            email.fromAddress ='Demo@test.com';
            email.subject = 'Subject';
            String contactEmail = 'test@domain.com';
            email.fromname ='Dipika Rajput';
            
            Email_Handler__c e1 = new Email_Handler__c(Email_Body__c ='Demo',Email_Subject__c='Subject'); 
            insert e1; 
            Demo_Email_Handler_clasd process = new Demo_Email_Handler_clasd();
    
            Test.startTest();
            //
             Demo_Email_Handler_class_MockTest fakeResponse = new Demo_Email_Handler_class_MockTest(200,'Complete','{"items": [{"Title": "content of heading","Snippet": "this is Snippet", "Link":"This is link"}]}'
                                                 );
            Test.setMock(HttpCalloutMock.class, fakeResponse);
             //Map<String, Object> mapofjson = (Map<String, Object>)JSON.deserializeUntyped('[{"Name": "sForceTest1"}');
            // pass email & enveloper object as parameters here
            process.handleInboundEmail(email, env);
            Test.stopTest();
            // Querying on email Handler  for long text area field  
            List<Email_Handler__c>emailHandlerLst = new List<Email_Handler__c>();
            for(Email_Handler__c e : [select Id,Email_Body__c,Email_Subject__c
            from Email_Handler__c])
            {
                System.debug('Email_Handler__c e :--'+e);
                if(e.Email_Body__c.contains(email.plainTextBody))
                {
                    System.debug('e.Email_Body__c.contains(email.plainTextBody)'+e.Email_Body__c.contains(email.plainTextBody));
                    System.debug('e***'+e);
                    emailHandlerLst.add(e);
                    System.debug('emailHandlerLst--'+emailHandlerLst);
                }
                System.debug('emailHandlerLst:---'+emailHandlerLst);
            }
            Contact c = new Contact(firstname = email.fromname,lastname=' emailLast');
            insert c;
             //Contact  c = [select firstname,lastname from Contact where email='Demo@test.com'];
            system.debug('----contact : '+c);
            
          
            
          
    
        } 
        
      
}