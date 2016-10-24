//Add all Account Id’s to the set and print the result

public with sharing class soqlsosl2b {
    
    public void func()
    {
    	List<Opportunity>acc = new List<Opportunity>();
    	acc = [Select AccountId From Opportunity ];
    	Set<Opportunity>accset = new Set<opportunity>(acc);
        system.debug(accset); 
    }
}