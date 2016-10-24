/* Write SOQL query on 'C'(created above) to retrieve all records of 'C' with name 'John' along with
parent details.*/
public with sharing class childtoparent2 {
    
    public void retrievingRec()
    {
    	List<c__c> lst = new List<c__c>();
    	lst = [select Name , subject1__c , subject2__c , A_c__r.Name , B_c__r.Name from c__c ];
    	system.debug(lst);
    }
}

 
 //done