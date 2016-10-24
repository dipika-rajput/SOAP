/*aggregatefunction2:- Find total number of distinct Lead records on basis of 'Lead Source' having greater than 10 leads.
Print this information.*/
public with sharing class distinctlead
{
 	public void aggregatefunction2()
 	{
 		List<aggregateResult>distlist = new List<aggregateResult>([select count_distinct(ID) from Lead
                                                               group by leadsource having count(ID) > 10]);
 		system.debug(distlist);
 	}   
}
//done