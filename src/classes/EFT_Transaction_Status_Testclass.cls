@isTest
public class EFT_Transaction_Status_Testclass {
    static testMethod void eftTransactionTest()
    {
		List<EFT_Transaction_Status__c> Neweftlist = new List<EFT_Transaction_Status__c>();
        List<  SalesHeader__c> salesList = new List<SalesHeader__c>();
        Test.startTest();
        EFT_Transaction_Status__c Neweft = new EFT_Transaction_Status__c(Method_Name__c ='Credit Card Address Verify',
        Transaction_Status__c = 'Declined');
        Neweftlist.add(Neweft);
        SalesHeader__c sales = new SalesHeader__c(Status__c = 'Open');
        salesList.add(sales);
        insert Neweftlist;
        insert salesList;
        for(EFT_Transaction_Status__c e : Neweftlist)
        {
         	System.assertEquals(e.Method_Name__c,'Credit Card Address Verify');
            System.assertEquals(e.Transaction_Status__c,'Declined');          
        }
        for(SalesHeader__c s : salesList )
        {
          System.assertEquals(s.Status__c ,'Open');  
        }	
        List<case>caselist = new List<case>();
        caselist = [select AccountId,ContactId,Reason,Priority,Status from case where Priority = 'High'];
        for(Case c : caselist)
        {
            //system.assertEquals(c.AccountId,caselist.SalesHeaders_reltion__r.Bill_To_Account__c);
            //system.assertEquals(ContactId,caselist.SalesHeaders_reltion__r.Bill_To_Contact__c);
            //system.assertEquals(c.AccountId,'');
           	system.assertEquals(c.Reason,'Address Did Not Verify');
            system.assertEquals(c.Priority,'High');
            System.assertEquals(c.Status,'New');
            System.assertEquals(c.Type,'Address Did Not Verify');
           // System.assertEquals(c.Transaction_Status__c,Transaction_Status__c);
            //System.assertEquals();
            
        }
                
        
      }
        
      
        
  }