// Find all the Account Names starting with ‘a’. Print that count and update all those
//accounts with New Name as ‘Updated via update DML operation’
public with sharing class soqlsosl3 {
	public void ss3()
	{
		try {
    		List<Account> acc = new List<Account>();
    		acc = [Select Name From Account a where Name like 'a%'];
    		if(!acc.isEmpty())
    		{
    			Account a = acc[0];
    			a.Name= 'Updated via update DML operation';
    			update a;
    			system.debug(a);
    		}
    		
  
		}
	catch (DmlException e) 
	{}
	}
	
    
}