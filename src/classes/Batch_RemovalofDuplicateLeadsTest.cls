@isTest
public class Batch_RemovalofDuplicateLeadsTest {
Static testmethod void unitFirstTest()
{
     test.startTest();
    List<Lead> leadList = new List<Lead>();
    Lead l1=new Lead(LeadName__c = 'rec1',FirstName='Abc',LastName='Xyz',Company='Eter',Status='Closed-Converted',email='Abc@xyz.com');
    insert l1;
    Lead l2=new Lead(LeadName__c = 'rec2', FirstName='Xyz',LastName='New',Company='Eternus2',Status='Closed-Converted',email='Abc@xyz.com');
 	insert l2;
   // String query = 'select firstName from lead where createdDate = Today()';
    Batch_RemovalofDuplicateLeads b = new Batch_RemovalofDuplicateLeads ();
     Database.executeBatch(b);
    test.stopTest();
    list<lead> ldlst = [select firstName from Lead where email='abc@xyz.com'];
    //system.assert(ldlst.size() == 1);
    System.debug('this is assert:--'+ldlst.size());

    
 
}
}