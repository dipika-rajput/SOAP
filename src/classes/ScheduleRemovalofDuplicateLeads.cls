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