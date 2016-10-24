@isTest
public with sharing class GoogleApiqueryResultControllerTest {
public static testMethod void unitTesting()
{
    
    Test.setCurrentPage(Page.GoogleApiqueryResultPage);
    GoogleApiqueryResultControllerMockTest fakeResponse = new GoogleApiqueryResultControllerMockTest(200, 'Complete', '{"items": [{"Title": "content of heading","Snippet": "this is Snippet", "Link":"This is link"}]}');
    Test.setMock(HttpCalloutMock.class, fakeResponse);
    googleApiqueryResultController g = new googleApiqueryResultController();
    g.searchQuery();
    List<Search_Result__c>searchLst = new List<Search_Result__c>();
    Test.startTest();
    Contact c = new Contact(FirstName='demofirst',LastName='demoLast',Email='demo@demo.com');
    insert c;
    Email_Handler__c e = new Email_Handler__c(Email_Body__c='Facebook',Email_Subject__c='Facebook',Contact__C=c.id);
    insert e;
     g.selectedQueryId = e.id;
    Search_Result__c s1 = new Search_Result__c(Heading_Links__c='This is heading1',Information_related_to_topic__c='this is related info1',Sub_Links__c='google.com1',Email_Header__c=e.id);
    //insert s1;
    searchLst.add(s1);
    Search_Result__c s2 = new Search_Result__c(Heading_Links__c='This is heading2',Information_related_to_topic__c='this is related info2',Sub_Links__c='google.com2',Email_Header__c=e.id);
    //insert s2;
    searchLst.add(S2);
    insert searchLst;
    g.getemailHand();
    g.resultHandler();
    

    
}   
    
}