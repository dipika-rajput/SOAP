@isTest
public class TriggerforAccountTest {
    static testMethod void CloneAccountTest() 
    {
        List<Account>listofAccount = new List<Account>();
        Test.startTest();
      	Account a = new Account(Rating = 'Hot',Ownership = 'Public', Name = 'amit', Website_Domain__c = 'gmail.com');
       	listofAccount.add(a);
        System.assertEquals(a.Rating,'Hot');
        System.assertEquals(a.Ownership,'Public');
        insert listofAccount;//check here whether clone copy is generated or not
        Account CloneAcc = a;
        if(CloneAcc.isClone() == true)
       	{
        	CloneAcc.Name = 'amit';
  			CloneAcc.Rating = 'cool';
    		CloneAcc.Ownership = 'Private';
        	update CloneAcc;
       	}
         System.assertEquals(CloneAcc.Name,'amit' );
         System.assertEquals(CloneAcc.Rating, 'Hot');
       	 System.assertEquals(CloneAcc.Ownership,'Public');
         Test.stopTest();
        
    }

}//is this test class correct