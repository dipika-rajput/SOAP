global with sharing class ClosedWonOppoSchedule implements Schedulable {
global void execute(SchedulableContext sc)
{
    ID BatchId = Database.executeBatch(new ClosedWonOppoBatch(),10);
    
}
}