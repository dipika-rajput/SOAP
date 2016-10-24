//Association between Contact and Account(Best Practice)
Trigger AssociationContactTri on Contact (before insert) {

   
     Boolean isoff = TriggerSetting__c.getInstance(). AssociationContactTri__c;
    AssociationContactTriggerHandler conacc = new AssociationContactTriggerHandler();
   if(isoff ==  false)
   {
       if(Trigger.isbefore )
       {
           if(Trigger.isinsert)
           {
                conacc.conaccAssociation(Trigger.new);
           }
   
       }
   }
   
}