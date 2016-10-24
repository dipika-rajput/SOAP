global class Batch_RemovalofDuplicateLeads implements Database.Batchable<sObject>, Database.Stateful
{
     String query;
     global Database.querylocator start(Database.BatchableContext BC)
     {
      	query = 'Select Id,Name,Email from lead order by CreatedDate Desc';
        return Database.getQueryLocator( query);
     }
     global void execute(Database.BatchableContext BC, List<Lead> leadRecords) 
     {
          Set<String>emailSet = new Set<String>();
          FieldDecision__c objField = FieldDecision__c.getValues('UniqueField');
          List<Lead>leadstobeDeleted = new List<Lead>();
          for(Lead l : leadRecords)
          {
             if(emailset.contains(String.valueOf(l.get(objField.FieldNameforUniqueness__c))) == True)
             {
                leadstobeDeleted.add(l);
             }
             else
             {
                emailSet.add(String.valueOf(l.get(objField.FieldNameforUniqueness__c)));
             }
          }
          delete leadstobeDeleted;     
     }
     global void finish(Database.BatchableContext BC)
     {
         
     }
}