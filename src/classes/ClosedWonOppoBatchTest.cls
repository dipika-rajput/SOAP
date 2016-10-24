@isTest
public class ClosedWonOppoBatchTest {
    Static testMethod void unitTesting()
    {
        test.startTest();
        Contact c1 = new Contact(FirstName = 'rec1',Email = 'dipikarajput30@gmail.com', LastName = 'rec123',College_Name__c = 'col1',Primary_Contact__c = True);
        insert c1;
        //List<Contact> conLst = [SELECT Contact.Account.Id FROM Contact WHERE Primary_Contact__c = True];
		//for(Contact c : conLst)        
        Opportunity o1 = new Opportunity(Name = 'rec1',Amount = 1000,StageName = 'Prospecting',CloseDate = Date.newInstance(2016, 2, 17));
        insert o1;
          Opportunity o2 = new Opportunity(Name = 'rec12',Amount = 2000,StageName = 'Prospecting',CloseDate = Date.newInstance(2017, 2, 17));
        insert o2;
        //List<Opportunity>oppoLst = [Select ];
        ClosedWonOppoBatch c = new  ClosedWonOppoBatch();
        Database.executeBatch(c);
       
        //List<Opportunity>oppoLst = [];
        //System.assertEqual();
        test.stopTest();
    }

}