/* 3.Prepare the following map structures :
 a. Account Name as key and AccountId as value*/
public with sharing class query3a {
public void query3()
{
	Map<String,Id> strmap = new Map<String,Id>();
	List <Account> lstacc = [Select a.name from Account a];
	for(Account acc: lstacc)
	{
  	 	strmap.put(acc.Name,acc.id);
   	}

	system.debug(strmap.keySet());
	system.debug(strmap.values());
}
}
//done