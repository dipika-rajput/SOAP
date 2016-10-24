global class ClosedWonOppoBatch implements Database.Batchable<sObject>
{
string query;
   

    global Database.querylocator start(Database.BatchableContext BC)
    {
        query = 'SELECT Contact.Account.Id FROM Contact WHERE Primary_Contact__c = True';
         System.debug('query rsult******** '+Database.getQueryLocator(query));
         return Database.getQueryLocator(query);
        
    }
     global void execute(Database.BatchableContext BC, List<Contact> scope) {
         System.debug('this is scope>>>>>'+scope);
         List<Id>AccIds = new List<Id>();
         System.debug('accIds'+AccIds);
         for(Contact c : Scope)
         {
             System.debug('c'+c);
           AccIds.add(c.Account.id);  
         }
        Double Aggregate = 0;
         List<String>OppoNames = new List<String>();
         List<Double>OppoAmount = new List<Double>();
       //  String query1 = 'SELECT Amount,Name from opportunity where opportunity.Account.Id : ACCIds';
         List<Opportunity>oppoList = new List<Opportunity>([SELECT Amount,Name from opportunity 
                                                            where opportunity.Account.Id IN : ACCIds]);
         
         for(Opportunity o : oppoList)
         {
             System.debug('o'+o);
             Aggregate = Aggregate + o.Amount;
             System.debug('agg:-'+Aggregate);
             OppoNames.add(o.Name);
             OppoAmount.add(o.Amount);
         }
         System.debug('This is aggregate:'+Aggregate);
         System.debug('this is opponames list'+OppoNames);
         
         List<Contact>email_IdofContacts = new List<Contact>([SELECT Id, Email from contact where
                                                           Primary_Contact__c = True]);
         List<String>emailData = new List<String>();
        // List<Id>
         for(Contact c : email_IdofContacts)
         {
             System.debug('c'+c);
             emailData.add(c.Email);
             
         }
         System.debug('this is mail list of all primary contacts'+emailData);
         //create a mail
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        // mail.setTargetObjectIds(List<Id> param1)
         String BodyText = '';
         BodyText += OppoNames;
         System.debug('opponames'+OppoNames);
         BodyText += OppoAmount;
         System.debug('OppoAmount'+OppoAmount);
         BodyText += Aggregate;
          System.debug('Agg:'+Aggregate);
        
         Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
           
            String[] toadd = new String[]{'dipika.rajput@eternussolutions.com','dipikarajput30@gmail.com'};
            mail1.setToAddresses(emailData);
            System.debug('mail list'+emailData);
            mail1.setSubject('Closed Won Opportunity Detail');
            mail1.setHtmlBody(BodyText);
            Messaging.sendEmail(new Messaging.singleEmailMessage[]{mail1});
         
    }   
    
    
    global void finish(Database.BatchableContext BC) {
        

        
    }
}


/*Anonymous Window Data
list<Contact>acclist = new list <Contact>([SELECT Contact.Account.Id FROM Contact WHERE Primary_Contact__c = True]);
System.debug('this is accound id list'+acclist);
List<Id>accIds = new list<Id>();
for(Contact c : acclist)
{
    accIds.add(c.Account.id);
    System.debug(c.Account.id);
}
list<opportunity>oppolist = new list<opportunity>([SELECT Amount,Name from opportunity where opportunity.Account.Id IN  : accIds]);
System.debug('this is oppo list'+oppolist);
 List<Contact>emailofContacts = new List<Contact>([SELECT Email from contact where
                                                           Primary_Contact__c = True]);
      
 public static  Double Aggregate = 0;
List<String>OppoNames = new List<String>();
List<Double>OppoAmount = new List<Double>();
for(Opportunity o : oppoList)
         {
             Aggregate = Aggregate + o.Amount;
              OppoNames.add(o.Name);
             OppoAmount.add(o.Amount);
             //System.debug('this is agg'+Aggregate);
         }
System.debug('this is agg'+Aggregate);
 System.debug('this is opponames list'+OppoNames);
System.debug('this is amount list'+OppoAmount);
 List<Contact>email_IdofContacts = new List<Contact>([SELECT Id, Email from contact where
                                                           Primary_Contact__c = True]);
         List<String>emailData = new List<String>();
        // List<Id>
         for(Contact c : email_IdofContacts)
         {
             emailData.add(c.Email);
             
         }
         System.debug('this is mail list of all primary contacts'+emailData);
         //create a mail
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        // mail.setTargetObjectIds(List<Id> param1)
         String BodyText = '';
         BodyText += OppoNames;
         System.debug('opponames'+OppoNames);
         BodyText += OppoAmount;
         System.debug('OppoAmount'+OppoAmount);
         BodyText += Aggregate;
          System.debug('Agg:'+Aggregate);
        
         Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
           String[] toadd = new String[]{'dipika.rajput@eternussolutions.com'};
            mail1.setToAddresses(toadd);
         System.debug('mail list'+emailData);
            mail1.setSubject('Closed Won Opportunity Detail');
            mail1.setHtmlBody(BodyText);
            Messaging.sendEmail(new Messaging.singleEmailMessage[]{mail1});
         
//ClosedWonOppoBatch c = new ClosedWonOppoBatch();
//Id batchId = Database.executeBatch(c);
         
*/