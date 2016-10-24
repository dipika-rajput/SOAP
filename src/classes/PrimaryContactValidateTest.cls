@isTest
public class PrimaryContactValidateTest {
Static testMethod void unitTesting()
{
    test.startTest();
       Account acct = new Account();
        acct.name='TestAccount1';
        insert acct;
         ID accId=acct.Id;
       system.debug('AccountID'+accId);
          Contact c1=new contact(Firstname='Amit',LastName='Vasudevan',Primary_Contact__c=true,accountID=accId);
         insert c1;
    System.debug('Contact1 inserted!'+c1);
        Contact c2=new contact(Firstname='Amit2',LastName='Vasudevan2',Primary_Contact__c=true,accountID=accId);
        try
        {
       
         insert c2;
            }
        catch(DmlException e)
        {}
    System.debug('Contact2 inserted!');
        
        Opportunity opp1=new Opportunity(name='oppSample',closeDate=System.today(),stageName='closed won',accountId=accId);
        insert opp1;
        System.assert(c1.AccountId==opp1.AccountId);
        
        list<contact> con=[select firstname from contact where accountID=:accId];
       System.debug('size is:'+con.size());
        System.assert(con.size()==1);
            
    }
    
    
    }