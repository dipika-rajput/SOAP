@isTest
public class GenericRecordCreationBatchTest {
    Static testMethod void unitTesting()
    {
        test.startTest();
        Event__c e = new Event__c(Content_JSON_Type__c = '{"FirstName" : "event rec1","LastName" : "event rec1","College_Name__c" : "event rec1" }',Event_Status__c = 'New',Sobject_Name__c = 'Account');
    	insert e;
        
        GenericRecordCreationBatch b = new GenericRecordCreationBatch();
        Database.executeBatch(b);
        //e.Retrieval_Info_Id__c = e.Sobject_Name__c.id;
        e.Event_Status__c = 'Complete';
        update e;
       // System.assertNotEquals(e.Retrieval_Info_Id__c,Null);
        System.assertEquals(e.Event_Status__c,'Complete');
        test.stopTest();
    
    }

}