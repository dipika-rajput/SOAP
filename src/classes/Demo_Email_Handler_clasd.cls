global class Demo_Email_Handler_clasd implements Messaging.InboundEmailHandler 
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.Inboundenvelope envelope) 
    {
       System.debug('inside code');
        Email_Handler__c em = new Email_Handler__c();
        System.debug('em before :--'+em);
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug('result:--'+result);
        em.Email_Subject__c = email.subject;
        System.debug('email sub:--'+em.Email_Subject__c);
        em.Email_Body__c = email.plainTextBody;
        System.debug('email body:--'+em.Email_Body__c);
        System.debug('em after:-'+em);
        em.Name = email.subject;
        //need to assign contact name to this email handler 
        
        insert em;
        System.debug('after insert em:='+em);
       
        
        String add = email.fromAddress;
        system.debug('add:-'+add);
        
            System.debug('inside for:-address:--'+add);
             List<Contact>conList = new List<Contact>([Select email,Name from contact where Email = :add]);
        //need to update contact lookup field of emailheader eg. that particular contact to that emailhandler
            em.Contact__c = conList[0].id;
             update em;
             system.debug('conList:--'+conList[0]);
             if(conList.size() == 0)
             {
                Contact contact = new Contact();
                String str =email.fromName;
                System.debug('from name:--'+str);
                contact.LastName = str;
                System.debug('lastname of contact:--'+contact.LastName);
                contact.Email = add;
                System.debug('email of contact:-'+contact.Email);
                
                insert contact;
                 
                 //update em;
             }
             else
             {
                 System.debug('inside else beause contact with same name already present');
                 
             }
         
        
        result.success = true;
        
        return result;
        
        
       
    }
}