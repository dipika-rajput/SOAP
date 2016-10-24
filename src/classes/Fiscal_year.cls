public with sharing class Fiscal_year {
	public void fiscalAggregate()
	{
        List<AggregateResult> lsagg = new List<AggregateResult>();
  		Map<Date,Decimal>summap = new Map<Date,Decimal>();
  		lsagg = [select closeDate,sum(amount)s1 from opportunity Where 
             IsClosed = true and CloseDate = THIS_FISCAL_YEAR group by closeDate]; 
  		for( AggregateResult ar:lsagg)
   		{ 
       		Decimal s=(Decimal)ar.get('s1');
       		Date d=(Date)ar.get('closeDate');
        	summap.put(d,s);
      	}
 			system.debug(summap);    
    }
}