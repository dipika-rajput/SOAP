Trigger Before_after_AccountTrigger on Account (after delete, after insert, after undelete,after update, before delete, before insert, before update)
{
     
     Boolean isoff = TriggerSetting__c.getInstance().BeforeAfterAccountTrigger__c;
     AccountTriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);
     if(isoff == False)
     {
    if(Trigger.isInsert && Trigger.isBefore)
    {
        System.debug('this is before insert');
         handler.OnBeforeInsert(Trigger.new);
          }
            else if(Trigger.isInsert && Trigger.isAfter)
            {
                 System.debug('this is after insert');
                handler.OnAfterInsert(Trigger.new);
              }
                else if(Trigger.isUpdate && Trigger.isBefore)
                {
                     System.debug('this is before update');
                    handler.OnBeforeUpdate(Trigger.old, Trigger.new);
                }
                    else if(Trigger.isUpdate && Trigger.isAfter)
                    {   
                         System.debug('this is after update');
                         handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
                }
                         else if(Trigger.isDelete && Trigger.isBefore)
                         {
                              System.debug('this is before delete');
                             handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);

                        }
                              else if(Trigger.isDelete && Trigger.isAfter)
                              {
                                   System.debug('this is after delete');
                                  handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
                                
                                }   

         
                                    else if(Trigger.isUnDelete)
                                    {
                                         System.debug('this is undelete');
                                          handler.OnUndelete(Trigger.new);  
                                    }
}
}