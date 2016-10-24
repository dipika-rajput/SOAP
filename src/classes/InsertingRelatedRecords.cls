public class InsertingRelatedRecords {
    public void demoAssociation()
    {
       /* List<Contact>EmailDomainlist = new List<Contact>();
        EmailDomainlist = [select Email_Domain__c from contact];
        system.debug(EmailDomainlist);
        Map<Id,String>ContactDomainMap = new Map<Id,String>();
     	for(Contact conmap : EmailDomainlist)
        {
        	ContactDomainMap.put(conmap.Id,conmap.Email_Domain__c);   
        }
        system.debug(ContactDomainMap);*/
        
    	try 
        {
        	Account acct = new Account(Name='Eternus Solutions',Website_Domain__c = 'gmail.com');
        	insert acct;
			ID acctID = acct.ID;
        	Contact con = new Contact(
		    First_Name__c= 'johnson',
       	 	College_Name__c='DY PATIL',
	     	FirstName='Joe',LastName='Smith',
		 	Phone='415.555.1212',
        	Email_Domain__c = 'gmail.com',
		 	AccountId=acctID);

	    	insert con;

		} 
        catch(DmlException e) 
        {
			System.debug('An unexpected error has occurred: ' + e.getMessage());
		}
         
    }
}