public with sharing class aggregatefunction2 {
    public void aggregatefun2()
 {
 	List<aggregateResult>distlist = new List<aggregateResult>([select count_distinct(ID) from 
                                                               lead Group by leadsource having count(ID)> 10]);
 	system.debug(distlist);
 }   
}
//done