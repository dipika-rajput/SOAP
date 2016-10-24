/*Query on all Contact records and add them to the List. Print that contents of this list*/

public with sharing class query1 {
	public void query()
	{
		List<contact> lstcon = new List<Contact>([select ID,Email ,phone ,Birthdate from Contact]);
		system.debug(+lstcon);
	}
    
}