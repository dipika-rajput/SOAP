@isTest
public class TriggergetCountofRegistrationTest {
    public static testMethod void unitTesting()
    {
    	test.startTest();
    	Event_Management__c e= new Event_Management__c(Name = 'pkg1');
    	insert e;
    	Group_Code__c g1 = new Group_Code__c(Name = 'demogroup',Package__c = e.id,
    	Coordinator_Email__c = 'dipikarajput30@gmail.com');
    	system.debug('insert gc');
    	insert g1;
    	Group_Code__c g2 = new Group_Code__c(Name = 'demogroup2',Package__c = e.id,
    	Coordinator_Email__c = 'dipikarajput305@gmail.com');
    	insert g2;
    	Registration_of_Guest__c r1 = new Registration_of_Guest__c(First_Name__c = 'demo1',
    	Last_Name__c='demol',Email_ID__c='demo@gmail.com',Group_Code__c = g1.id);
        System.debug('insert r1'+r1);
    	insert r1;
    	 
    	//System.debug('after insert r1'+r1);
    	Registration_of_Guest__c r2 = new Registration_of_Guest__c(First_Name__c = 'demo2',Group_Code__c = g1.id);
    	insert r2;
    	Registration_of_Guest__c r3 = new Registration_of_Guest__c(First_Name__c = 'demo2',Group_Code__c = g1.id);
    	insert r3;
    	delete r3;
    	
    	test.stopTest();
    	//System.assertEqual(g1.Count_of_Guest_Registration__c,2.0);
    }
}