/*Write a SOQL query to display 100 opportunity records with amount greater than 10,000 order by
created date. Skip first 50 records and include records from recycle bin. */
public with sharing class query6 {
	public void  queryingonOpp()
	{
		List<Opportunity> oppLst=new List<Opportunity>([Select Name, Id, CloseDate, Amount, StageName 
                                                    From Opportunity  Where  Amount > 10000 
                                                    Order by CreatedDate LIMIT 100 OFFSET 50 ]);
         system.debug(+oppLst);


	
	}
 }
 
 //done