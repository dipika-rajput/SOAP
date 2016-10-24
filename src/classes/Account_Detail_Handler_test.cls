@isTest
public class Account_Detail_Handler_test {
   // Account_Details_Handler acc_detail = new Account_Details_Handler();
    public static testMethod void accountDetailhandling()
    {
        Account acc = new Account(Name='abc',Website_Domain__c='abx.com',rating='Hot',Ownership='Private');
  		insert acc;
      
    	Test.startTest();
        Test.setCurrentPage(Page.Account_Details);
        ApexPages.StandardController stdController = new ApexPages.StandardController(acc);
		Account_Details_Handler acc_handler = new Account_Details_Handler(stdController);
        //For delete attachment
   
        Attachment at = new Attachment(name = 'document1',ParentId = acc.id,Body=Blob.valueOf(''));
        insert at;
        acc_handler.IdChoosen = at.id;
        acc_handler.deleteLink();
        list<Attachment> rec = [SELECT id from Attachment where name = 'document1'];
      	system.assertEquals(rec.size(),0);
    	
		//for dosubmit
        pageReference ptr = acc_handler.dosubmit();
        System.assertNotEquals(ptr.getUrl(),null);
        System.assertEquals(ptr.getUrl().containsIgnoreCase('/apex/Account_attachment'), true);
       	
       
       
     
     
     
        
        Test.stopTest();
        

    }
}