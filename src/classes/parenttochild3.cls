/*Write a SOQL query on 'A' and retrieve all parents with all their child records where in child name is
'John'.
*/
public with sharing class parenttochild3
{
    public void retrievingParents()
	{
		List<A__c>ls = new List<A__c>();
		ls = [select name__c ,(select Name from c__r where Name = 'john') from A__c];
		system.debug(ls);
	}    
}
//done