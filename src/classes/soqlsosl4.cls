/* Prepare the Map structure to show the Account (As key) and Its opportunities as
List(Value)
Hint : Query on Account and get the child opportunities or
Query on Opportunities and get the parent Account Id
Hint : Your map structure will be : Map<Id,List<Id>>*/

public with sharing class soqlsosl4 {
    public void mapStructure()
    {
		//set <Account>s1=[Select (Select Id From Opportunities) From Account a];  
 		map<id,list<id>> mapoflistid = new map<id,list<id>>();
		for (Account acc : [Select a.Id ,(Select Id From Opportunities) From Account a])
		{
   			for (Opportunity opp : acc.Opportunities)
   			{
    			if (!mapoflistid.containsKey(acc.id)) 
    			{
        			mapoflistid.put(acc.id,new list<id>());
                }
   				 mapoflistid.get(acc.id).add(opp.id); 
            }
    		system.debug(mapoflistid);
        }
   }
}