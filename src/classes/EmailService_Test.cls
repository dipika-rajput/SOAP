@IsTest
public class EmailService_Test {  
          
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
            
            //email.ccAddresses = new String[] {'Test Domain <' + contactEmail + '>'};
            
            ProcessJobApplicantEmail process = new ProcessJobApplicantEmail();
    
            Test.startTest();
            // pass email & enveloper object as parameters here
            process.handleInboundEmail(email, env);
            Test.stopTest();
           
          
    
        } 
        
       /* public static testMethod void testEmailSubject(){
        Contact con=new Contact(FirstName='Dipika',LastName='Rajput',Email='Demo@test.com');
        insert con;  
            // Create a new email and envelope object (Mandatory)
            Messaging.InboundEmail email  = new Messaging.InboundEmail();
            Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
    
            // Create the email body
            email.plainTextBody = 'Demo';
            email.fromAddress ='Demo@test.com';
            
            String contactEmail = 'test@domain.com';
            email.fromname ='Dipika Rajput';
            
            //email.ccAddresses = new String[] {'Test Domain <' + contactEmail + '>'};
            
            ProcessJobApplicantEmail process = new ProcessJobApplicantEmail();
    
            Test.startTest();
            // pass email & enveloper object as parameters here
            process.handleInboundEmail(email, env);
            Test.stopTest();
    
           // System.assert (result.success, 'InboundEmailResult returned a failure message');
    
             Email_Handler__c eh= [select Id,Email_Body__c,Email_Subject__c from Email_Handler__c where Email_Body__c = :email.plainTextBody];
            
            Contact [] c = [select firstname,lastname from Contact where email='Demo@test.com'];
            system.debug('----contact : '+c);
            
    
        } */
}