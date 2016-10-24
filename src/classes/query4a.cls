/* Create a multi-select picklist on Account object called as 'Enrollment Year' with values - 2010, 2011,
2012, 2013, 2014, 2015 and 2016. Get all account records where in selected 'Enrollment Year' is:
 b. 2013 and 2014*/
public with sharing class query4a {
    public void q4a()
    {
    	List<Account> lstacc = new List<Account>();
        lstacc = [SELECT AccountNumber,BillingCity,Fax,Phone FROM Account WHERE Enrollment_Year__c INCLUDES ('2010')] ;
    	system.debug(+lstacc);
    }
}
//done