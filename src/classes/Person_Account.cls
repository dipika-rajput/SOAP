/* Query on Account object /records and if the account is person account print the ID of
that record. (Hint :
You have to enable person account */
public with sharing class Person_Account {
	public void datafetch()
 	{
 		List <Account> lstacc = [Select a.Name, a.Id From Account a];
 		Map<String,id>mapstr = new Map<String,id>();
 		for (Account acc : lstacc)
 		{
    		mapstr.put(acc.Name,acc.Id);
 		}
 		System.debug(lstacc);
 	}
}