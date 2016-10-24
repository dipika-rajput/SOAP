/* Write a SOQL query to find all Account records which have at least an opportunity record which is
'Closed Won'.*/
public with sharing class parenttochild2 
{
	public void ptc2()
	{
		List <Account>lsAcc = new List<Account>();
		lsAcc = [select Account.id,(select opportunity.StageName from
                                Account.opportunities where opportunity.StageName = 'Closed Won')from Account];
		System.debug(lsAcc);
	}
    
}
//done