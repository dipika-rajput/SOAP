//que 4: Contact Duplicate Avoider
Trigger ContactDuplicateAvoider on Contact (before insert,before update) 
{
    Boolean isoff = TriggerSetting__c.getInstance().ContactDuplicateAvoider__c;
    ContactDuplicateAvoiderHandler condup = new ContactDuplicateAvoiderHandler();
    if(isoff == false)
    {
    if(Trigger.isBefore && Trigger.isInsert)
    {
        condup.duplicateHandling(Trigger.new,Trigger.oldMap);  
    }
    if(Trigger.isBefore && Trigger.isUpdate)
    {
       condup.duplicateHandling(Trigger.new,Trigger.oldMap); 
    }
    }
}
    

//done