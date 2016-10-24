Trigger Trigger_for_Opportunity on Opportunity (after insert,after update) {
     Boolean isoff = TriggerSetting__c.getInstance().EFT_Transaction_Status__c;  
     List<Sales_stream_Points__c>listofsales = new List<Sales_stream_Points__c>();
     //Sales_stream_Points__c sale = new Sales_stream_Points__c();
     Sales_stream_Points__c[] sale = new Sales_stream_Points__c[6];
     if(isoff == false)
     {
     for(Opportunity o : Trigger.new)
     {
            for(integer i = 0; i <= 6;i++)
            {
                
                sale[i].Point_Type__c = 'Collaborate' ;  
                sale[i].Opportunity__c = o.Id;
                insert sale[i];
                System.debug('this is new sales'+sale);
            }
         
         
     }
     }
    //insert sale;
    //System.debug('this is new sales'+sale);
}