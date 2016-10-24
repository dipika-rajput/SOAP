global class RemovalofDuplicateLeadsBatch implements Database.Batchable<sObject>, Database.Stateful
{
     String query;
     global Database.querylocator start(Database.BatchableContext BC)
     {
         //Here we are querying on lead to get all records of lead in descending order by created date
      	query = 'Select Id,Name,Email from lead order by CreatedDate Desc';
        System.debug('this is query result:---'+Database.getQueryLocator( query));
        return Database.getQueryLocator( query);
      }  
     global void execute(Database.BatchableContext BC, List<Lead> leadRecords) 
     {
         System.debug('this is query res**>>>>>>>>>>'+leadRecords);
         //Here we have created one set to store emails 
         Set<String>fieldSet = new Set<String>() ;
         //Here FieldDecision is custom setting of list type is storing information about the uniqueField
         FieldDecision__c objField = FieldDecision__c.getValues('UniqueField');
         System.debug('this is email field selected---->>>>'+objField);
         //Here we have created list of Leads to store the records which needs to be deleted after checking 
         //duplication on the basis of custom field record name(FieldNameForUniqueness__C)where we are storing api name
         //of your particular field which needs to be set for uniqueness
         List<Lead>leadstobeDeleted = new List<Lead>();
         for(Lead l : leadRecords)
         {
             //Here we are iterating on lead record one by one to search for
             // all leads which we get after querying on them
             System.debug('this is new lead'+l);
             //Inside if we compare value of our API Name which is given in fieldnameforuniqueness with the 
             //set of fieldset which will store set of values for any field which is given by user in api name  
             if(fieldset.contains(String.valueOf(l.get(objField.FieldNameforUniqueness__c))) == True)
             {
                 //If they found true we will add that lead in list of leads which needs to be delete
                leadstobeDeleted.add(l);
             }
             else
             {
                 //Else add that lead into fieldset
                 fieldSet.add(String.valueOf(l.get(objField.FieldNameforUniqueness__c)));
                 System.debug('added email into set'+fieldSet);
             }
            
         } 
         System.debug('leads needs to be deleted'+leadstobeDeleted);
         //At the end we are deleting all the leads which are duplicate
         delete leadstobeDeleted;    
     }
     global void finish(Database.BatchableContext BC)
     {
         
     }
}

/*Batch_RemovalofDuplicateLeads  c = new Batch_RemovalofDuplicateLeads();
Id batchId = Database.executeBatch(c);
         
global class ScheduleRemovalofDuplicateLeads implements Schedulable  {
 global void execute(SchedulableContext sc)
 {
  		ID BatchId = Database.executeBatch(new Batch_RemovalofDuplicateLeads (), 10);
 } 
 Public static void SchedulerMethod() 
 {
  	string con_exp= '0 0 0/3 1/1 ?';
  	System.schedule('RemovalofDuplicateLeads', con_exp, new ScheduleRemovalofDuplicateLeads());
 }
}
    
/*string con_exp= '0 0 0/3 1/1 * ? *';
Id jobid = System.schedule('RemovalofDuplicateLeads', con_exp, new ScheduleRemovalofDuplicateLeads());*/