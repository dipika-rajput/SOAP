public with sharing class query4 {
    
   public void q4()
    {
    	List<Account> l1 = new List<Account>();
        l1 = [SELECT AccountNumber,BillingCity,Fax,Phone FROM Account WHERE Enrollment_Year__c INCLUDES ('2010')] ;
    	system.debug(+l1);
    }
}