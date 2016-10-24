@istest
public class SearchControllerTestClass {
   static testMethod void searchTesting()
 {
     //list of records 
     List<Account>accLst = new List<Account>();
 	 Account acc1 = new Account(Name='abcd',Website_Domain__c='abx.com',rating='Hot',Ownership='Private');
     Account acc2 = new Account(Name='xyz',Website_Domain__c='xyz.com',rating='Hot',Ownership='Private');
     accLst.add(acc1);
     accLst.add(acc2);
     insert accLst;
     Test.startTest();
     //set current page for testing
     Test.setCurrentPage(Page.listviewdemo);
     ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(accLst);
     stdSetController.setSelected(accLst);
     SearchController searchcon = new  SearchController(stdsetController);
     //for search function

     searchcon.searchString = 'abcd1234'; 
     searchcon.search();
    
    //for clear function
   	 searchcon.clear();
         
     //refreshList2() method
     String s = 'a';
     pageReference pref = searchcon.refreshList2();
  
     
     //getContactRecords() methods
       PageReference pr = searchcon.getContactsRecords();
      // System.assertEquals(pr,'/apex/secondReference');   
 
     
	 Test.stopTest();
     }
}