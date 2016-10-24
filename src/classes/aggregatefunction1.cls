/*aggrgatefunction1 :-Write a SOQL query to retrieve sum of all closed Opportunity amount for current fiscal year. Store
this information in a map with key as year and value as sum of amount. Iterate this map to display
statistics.*/
public with sharing class aggregatefunction1
{
    public void af1()
    {
   	 	List<AggregateResult> ls = new List<AggregateResult>();
    	Map<Date,decimal>summap = new Map<Date,decimal>();
 		ls= [select closeDate,sum(amount)s1 from Opportunity Where IsClosed=true AND
             CloseDate = THIS_FISCAL_YEAR group by closeDate]; 
  		for( AggregateResult ar:ls)
  		{
    	 	System.debug(ar.get('closeDate')+'-'+ar.get('s1'));
 		}
	} 
}//done