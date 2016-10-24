//2.c:-Prepare the Map having Key as OpportunityId and Value as AccountId
public with sharing class soqlsosl2c {
	public void funct()
	{
		Map<Id,Id> mapofid = new Map <Id,Id>();
 		list<Opportunity> lstopp = [Select Id,AccountId From Opportunity  Where AccountId !=null and StageName='Closed Won'];
 		for (Opportunity Opp : lstopp )
 		{
 	  		mapofid.put(Opp.id, Opp.AccountId);
 		}
			system.debug(mapofid.values());
			system.debug(mapofid.keySet());
	}
    
}