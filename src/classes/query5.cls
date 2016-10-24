public with sharing class query5 {
	public void querying(){
	List<Account> lstAcc = [SELECT a.Id, a.Name, a.Phone FROM Account a 
                      WHERE BillingState Not In('Maharashtra','Kerala')ORDER BY 
                      a.BillingState DESC NULLS LAST limit 10000];
    system.debug(+lstAcc);
    
}
}
//done