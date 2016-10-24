public class AssociationContactTriggerHandler 
{
    public void conaccAssociation(List<Contact>conlst)
    {
        Set<String> emailDomain = new Set<String>();
    //this for loop is for checking newly created contact for fetching the email field and store it in set
   for (Contact ct : conlst)
   {
       emailDomain.add(ct.Email_Domain__c);
       system.debug('this is email domain of contact'+emaildomain); 
   }
     //Here checking whether that set is empty or not if it is not empty it will enter into loop
    if (!emailDomain.isEmpty())
    {
        	 System.debug('inside if:::**');
            //map<String,Account> mapdomaintoaccount = new map<String,Account>();
            list<Account> lst = [select id,Website_Domain__c from Account where Website_Domain__c in : emailDomain ];
        	System.debug('list of account matches::'+lst);
          	//for assignment of account id to the contact id
          	
       	       Map<String,Account>emailaccMap = new Map<String,Account>();
        	   System.debug('this is emailacccMap:-'+emailaccMap);
        	   for(Account acc : lst)
               {
                   emailaccMap.put(acc.Website_Domain__c,acc);
                   System.debug('this is acc:---'+acc);
               
        		if(acc.Website_Domain__c != Null)
                {
        		for(Contact c : conlst)
                {
                    Account a = emailaccMap.get(c.Email_Domain__c);
                    c.AccountId = a.id;
                    System.debug('got d account id:--'+c.AccountId);
                }
                }
               }
        	
              
                  //this code is for creating new account if it is not present 
               list<contact> conNeedAccounts = new list<contact>();
        		System.debug('this is con needed account list:-'+conNeedAccounts);
                  for (contact c : conlst)
                  {
                      System.debug('this is first contact who need account:-'+c);
                    if(string.isBlank(c.AccountId))
                      {
                          System.debug('this is inside if after con needed');
                       		conNeedAccounts.add(c);
                          System.debug('this is conNeddAccounts:--'+conNeedAccounts);
                      }
                  }
        		  //we are checking size of list if it is greater than 0 then enter into loop
                  if(conNeedAccounts.size() > 0)
                  {
                      list<Account>newAccounts = new list<Account>();
                      Map<String,Contact>contactbyEmailkey = new Map<String,Contact>();
                     //now create account for each contact
                    	for(Contact c : conNeedAccounts)
                    	 {
                       		 String accountName = c.FirstName + ''+c.LastName;
                       		 String Emailofcontact = c.Email_Domain__c;
                        	 Account newAcc = new Account(name = accountName,Website_Domain__c = Emailofcontact);
                        	 newAccounts.add(newAcc);
                        	 insert newAccounts;
                        	 for(Contact ct : conlst)
                         	{
                        		ct.AccountId = newAcc.id;
                         	}
                         }
                  }
           }
    }
}