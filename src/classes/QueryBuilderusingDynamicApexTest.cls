@isTest
public class QueryBuilderusingDynamicApexTest
{
	static  testMethod void  unitTesting()
    {
        QueryBuilderusingDynamicApex q = new QueryBuilderusingDynamicApex();
        PageReference pr = Page.QueryBuilderpage;
        test.startTest();
        Account a = new Account(Name = 'demo',Phone = '885552',Fax = 'demofax',	Website_Domain__c = 'demo.com');
        insert a;
        q.objdescription = ''+a;
        q.selectedObj = 'Account';
       
        //q.sfields = 
        q.Details();
        q.show();
        List<String> l = new List<String> {'Name', 'Phone '};
        q.sfields = l;
        q.addFields();
        System.debug('after addFields');
        List<String> l1 = new List<String>{'Phone'};
        q.rfields = l1;
        q.removeFields();
        System.debug('after removefields');
        q.getOptionsSorting();
        System.debug('after getoptionsSoritng');
        q.actionSave();
        System.debug('after actionsave');
        q.getLimitValue();
        System.debug('after getlimitvalue');
        q.actionlimit();
        System.debug('after actionlomit');
       // q.querymyData();
        //System.debug('after querymydata');
        
        
        test.stopTest();
        
    }
}