global class Schedular_RemovalofDuplicateLeads implements Schedulable 
{
    global void execute(SchedulableContext sc)
{
	ID BatchId = Database.executeBatch(new Batch_RemovalofDuplicateLeads(),10);  
}

}