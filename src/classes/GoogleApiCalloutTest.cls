@isTest
global class GoogleApiCalloutTest {


	public static testmethod void unitTesting() {
        GoogleApiCalloutMockResTest fakeResponse = new GoogleApiCalloutMockResTest(200,
                                                 'Complete',
                                                 '{"items": [{"Title": "content of heading","Snippet": "this is Snippet", "Link":"This is link"}]}'

                                                 );
		Test.setMock(HttpCalloutMock.class, fakeResponse);
		GoogleApiCallout g = new GoogleApiCallout();
		//Contact con = new Contact();
		Email_Handler__c e = new Email_Handler__c(Email_Body__c='Facebook',Email_Subject__c='DemoTest');
		insert e;
		
       GoogleApiCallout.callingToApi(e.Email_Body__c,e.id);
       
        //g.callingToApi();
        //System.assertEquals(/*check for expected results here...*/);
    }
}