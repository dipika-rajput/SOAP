public with sharing class query4b {
    public void q4b()
    {
    	List<account>lstacc = new List<account>();
        lstacc = [SELECT AccountNumber,BillingCity,Fax,Phone FROM 
                  Account WHERE Enrollment_Year__c INCLUDES ('2013','2014')] ;
    	system.debug(+lstacc);
    }
}