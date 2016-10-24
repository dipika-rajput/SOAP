@istest
public with sharing class BatchFlightremainerntahnkyoumailTest {
	public static testMethod void unitTesting()
	{
		 test.startTest();
		 Date sDate = Date.newInstance(2016, 10,5);
		 Date eDate = Date.newInstance(2016,10,7);
		
		 
		 Event_Management__c e = new Event_Management__c(Name ='demotest',Start_Date__c=sDate,End_Date__c=eDate);
		 insert e;
		 BatchFlightremainerntahnkyoumail b = new BatchFlightremainerntahnkyoumail();
		 Id batchJobId = Database.executeBatch(b);
	}
    
}