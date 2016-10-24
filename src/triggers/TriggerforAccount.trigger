//Question 3:-clone the record done working fine
Trigger TriggerforAccount on Account (after insert) {
 
    Boolean isoff = TriggerSetting__c.getInstance().TriggerforAccount__c;
    
        
    TriggerforAccountHandler accobj = new TriggerforAccountHandler();
    if(isoff == false )
    {
   if(Trigger.isAfter && Trigger.isInsert)
   {
       accobj.accountHandling(Trigger.new);
   }
   }
}
//done