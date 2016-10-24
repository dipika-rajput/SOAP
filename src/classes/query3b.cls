public with sharing class query3b {
    
    public void q3b()
    {
    	Map<Id,Account> mapdemo = new Map<Id,Account>([select name ,phone from Account]);
    	for (Id idKey : mapdemo.keyset()) {
			 Account a = mapdemo.get(idKey);
			 System.debug(a);
    	}
    	
    }
}