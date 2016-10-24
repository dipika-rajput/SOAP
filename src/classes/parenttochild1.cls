/*1. Write a SOQL query on Account and find all associated contact records of the Account which
contains the word 'John'. Print all Account and Contact records retrieved above.*/
public with sharing class parenttochild1 
{
	public void ptc1()
	{
		List<Account>lsAcc = new List<Account>();
		lsAcc = [select Account.Name,(select contact.firstname,contact.lastname from 
                                   Account.contacts where contact.Name = 'john')from Account  ];	
		system.debug(lsAcc);
	}
    
}

 //done