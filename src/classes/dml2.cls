/*2. Delete all inactive Account records created in last 90 days*/
public with sharing class dml2
{
	public void recordCheck()
    {
		Account[]acc=[Select Name, Id  From Account where  Active__c='No' and CreatedDate = LAST_90_DAYS];
		try
		{
  			delete acc;
		}    
		catch(DmlException e){}
    
	}
}
//done