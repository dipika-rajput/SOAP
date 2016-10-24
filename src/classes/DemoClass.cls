public class DemoClass {
    public void fetchDomainContact()
    {
     	List<Contact>contactlist = new List<Contact>();
        contactlist = [select id ,Email_Domain__c from Contact ];
        //list emailid = contactlist.Email_Domain__c;
        Map<Id,String>mapstr = new Map<Id,string>();
        for(contact c : contactlist)
        {
            mapstr.put(c.Id,c.Email_Domain__c);
        }
         System.debug(mapstr);
    
                                            
       }

}