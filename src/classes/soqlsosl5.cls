/* . Write a SOQL Query on to retrieve/print 10 Campaign records and sort in ascending
as well as descending order*/
public with sharing class soqlsosl5 {
	public void soql5()
	{
		List <Campaign> lstcamp = new List<Campaign>();
		lstcamp = [Select c.Name, c.Id From Campaign c order by c.Id desc limit 10];
		system.debug(lstcamp);
	}
    
}