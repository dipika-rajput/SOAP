global class googleAPiResponseBatch implements  Database.Batchable<sObject>, Database.Stateful
{
    String query;
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        query = 'Select id ,Email_Body__c ,Contact__r.Email, (Select id,Heading_Links__c,Information_related_to_topic__c,Sub_Links__c from Search_Result__r)from Email_Handler__c where Contact__r.Email != Null '; 
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<Email_Handler__c>ConEmailResultList)
    { 
        //System.debug('ConEmailResultList:-'+ConEmailResultList);
       // List<String>conEmailList = new List<String>();
       // i need to fetch child records in parent to child relationship
        String links;
        String titles;
        String info;
          List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
       
        for(Email_Handler__c e : ConEmailResultList)
        {
            for(Search_Result__c s : e.Search_Result__r)
            {
                 info = s.Information_related_to_topic__c; 
                 titles = s.Heading_Links__c;
                 links = s.Sub_Links__c;
                //System.debug('info:-----'+info);
                //System.debug('title:********'+titles);
                //System.debug('links****'+links);
         
         String emailofcon;
        String emailbody;
        ID idofcon;
       
            //System.debug('e::::::::::::'+e);
            emailofcon = e.Contact__r.Email;
            emailbody = info+titles+links;
            idofcon = e.Contact__r.id;
            //system.debug('emails of con:-'+emailofcon);
            //System.debug('email body:-'+emailbody);
            System.debug('id of contact :-'+idofcon);
          
        
       
       //send email
       
       
      	Integer used = Limits.getEmailInvocations();
        Integer emailLimit = Limits.getLimitEmailInvocations();
       System.debug('used mails:---'+used);
       System.debug('email limit:--'+emailLimit);
       if(used >= emailLimit)
       {
       		System.debug('Your Email Limit is exceeded!!!!!!!!!!!!!!!!!!!!!!!!!!');
       		
       }
       Else
       {
        	EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Response_from_google'];
        //System.debug('email template :-'+et);
       
       		 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          //  System.debug('mail:--'+mail);
                
             mail.setTargetObjectId(idofcon);
               
             mail.setSubject('Response of your query');
             mail.setHtmlBody(emailbody);
             mail.setTemplateId(et.id);
             myEmails.add(mail);
                System.debug('individual mail:-'+mail);
              System.debug('my Mails*****'+myEmails);
             System.debug('You have made ' + Limits.getEmailInvocations() + ' email calls out of ' + Limits.getLimitEmailInvocations() + ' allowed');
 
            Messaging.sendEmail(myEmails);
             //System.debug('mail sent'+myEmails);
            
       }
         }
          //	 Messaging.sendEmail(myEmails);
            // System.debug('mail sent'+myEmails);  
         //System.debug('final mail:-'+myEmails);
        }
       		 //Messaging.sendEmail(myEmails);
             //System.debug('mail sent'+myEmails);
        
    }
    global void finish(Database.BatchableContext BC)
    {
        
    }
}