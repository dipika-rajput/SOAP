@isTest
public class SearchControllerTest {
    public static testMethod void searching()
    {
        Account demoacc = new Account(Name='abc3',Website_Domain__c='abc3.com',rating='Hot',Ownership='Private');
        insert demoacc;
        Test.startTest();
        Test.setCurrentPage(Page.listviewdemo);
        ApexPages.StandardController std = new ApexPages.StandardController(demoacc);
        //SearchController s = new SearchController(std);
        
        
        
    }

}