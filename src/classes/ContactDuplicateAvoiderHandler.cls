//This class is for avoiding duplicate email in contacts. 
public class ContactDuplicateAvoiderHandler {
    public void duplicateHandling(List<Contact>connew , Map<Id,Contact>conoldmap)
    {
        //this Map is for storing contact and email.
        Map<string,Contact>contactMap = new Map<string,Contact>();
        //This loop is for iteratating on newly created contact to 
        //check duplicate email with previously created contact.
   		 for(Contact c : connew)
    	{
        	if((c.Email_ID__c != null) || (c.Email_ID__c != conoldmap.get(c.id).Email_ID__c))
                                 
        	{
                //This will give you error message if it is alreday present.
          		if(contactMap.containsKey(c.Email_ID__c))
          		{
           			c.Email_ID__c.addError('Another new contact has the'+'same email address');   
          		}
                //else it will keep that email in Map.
                else
                {
                    contactMap.put(c.Email_ID__c,c); 
                } 
           
            }
   		}
        //Here we are querying on contact to take email from Map.
    for(Contact c:[select Email_ID__c from Contact where Email_ID__c IN : contactMap.keySet()])
    {
        Contact newContact = contactMap.get(c.Email_ID__c);
        newContact.addError('A contact with this email'+'address already exist');
    } 
  	}

}