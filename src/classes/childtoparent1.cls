/* Write a SOQL query on Contact to retrieve all active contacts belonging to 'media' Industry. Also
display the name of the account to which it is associated to*/
public with sharing class childtoparent1 
{
 	public void cp1()
	{
 		List<Contact>conlst = new List<Contact>();
 		conlst = [select Contact.firstname,Contact.Account.name,
          Contact.Account.Industry from Contact where Contact.Account.Industry ='media' ];
 		system.debug(conlst);
 	}   
}
//done