public with sharing class SOQLSOSL {
	//here are fridays 8 last sections assignments
	//advance set 2: Query on all Opportunity records where its Account != NULL and Status = Closed
    // a. Add all Opportunity Id’s to the List and print the result
	public void  soql()
	{
		List<Opportunity> Mylist = new List<Opportunity>();
      	Mylist = [Select Id From Opportunity Where AccountId !=null and StageName='Closed Won'] ;
      	system.debug(+Mylist);
    }
}