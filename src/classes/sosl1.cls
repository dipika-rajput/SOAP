/*1. Find the word 'test' in all name fields returning Contact, Account, Lead and User.*/
public with sharing class sosl1
{
	public void returningData()
	{
        List<List<SObject>> searchList = [FIND 'TEST' IN ALL FIELDS returning 
                                        contact(name),account(name),lead(name),user(name)];
    	System.debug(searchlist);
    }
    
}
//done