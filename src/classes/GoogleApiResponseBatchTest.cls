@isTest
public class GoogleApiResponseBatchTest {
    static testMethod void unitTesting()
    {
        test.startTest();
        Contact c = new Contact(FirstName='democon',LastName='democonlast',Email='con@gmail.com');
        insert c;
        Email_Handler__c e = new Email_Handler__c(Email_Subject__c = 'Test Email',Email_Body__c = 'Testing',Contact__c=c.id);
        insert e;
        Search_Result__c s = new Search_Result__c(Email_Header__c= e.id,Heading_Links__c='search1',Information_related_to_topic__c='search1',Sub_Links__c='search1');
        insert s;
         GoogleApiResponseBatchMockTest fakeResponse = new GoogleApiResponseBatchMockTest(200, 'Complete', '{"items": [{"Title": "content of heading","Snippet": "this is Snippet", "Link":"This is link"}]}');
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        googleAPiResponseBatch g = new googleAPiResponseBatch ();
        Database.executeBatch(g);
       
        
    }
}