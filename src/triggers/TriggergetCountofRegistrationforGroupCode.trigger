trigger TriggergetCountofRegistrationforGroupCode on Registration_of_Guest__c (after delete,
 after insert, after undelete, after update)
{
    List<Group_Code__c> groupcodeLst = new List<Group_Code__c>();
   
   Set<Id> regId = new Set<Id>();
   
   if(Trigger.isDelete) {
     for(Registration_of_Guest__c test:Trigger.Old) {
      
        regId.add(test.Group_Code__c);   
    
     }   
   
   }
   else
   if(Trigger.isUpdate) {

     for(Registration_of_Guest__c test:Trigger.New) {
      
        regId.add(test.Group_Code__c);   
    
     }

     for(Registration_of_Guest__c test:Trigger.Old) {
      
        regId.add(test.Group_Code__c);   
    
     }   
   
   }
   else
   {
     for(Registration_of_Guest__c test:Trigger.New) {
      
        regId.add(test.Group_Code__c);   
    
     }
   }
   
   AggregateResult[] groupedResults = [SELECT COUNT(Id), Group_Code__c FROM 
   Registration_of_Guest__c where Group_Code__c IN :regId GROUP BY Group_Code__c ];
   
   for(AggregateResult ar:groupedResults) {
     
     Id custid = (ID)ar.get('Group_Code__c');
     
     Integer count = (INTEGER)ar.get('expr0');
     
     Group_Code__c cust1 = new Group_Code__c(Id=custid);
     
     cust1.Count_of_Guest_Registration__c = count;
     
     groupcodeLst.add(cust1);
      
   }
   
   
   update groupcodeLst;
    
}