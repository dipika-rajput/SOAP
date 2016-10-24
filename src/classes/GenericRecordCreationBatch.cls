global class GenericRecordCreationBatch implements Database.Batchable<Sobject>
     {
 	 
         String query;
 
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        query = 'Select Content_JSON_Type__c,Event_Status__c,Failure_Reason__c,Sobject_Name__c,Retrieval_Info_Id__c from Event__c';
        System.debug('this is query:-'+Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
    }
	global void execute(Database.BatchableContext BC, List<Event__c>eventList) 
    {
        System.debug('this is list of event records:-'+eventList);
      for(Event__c e : eventList)
      { 
          String objectName = e.Sobject_Name__c;
          
          System.debug('object name'+objectName);
          
        	
          String jsonEventFields = e.Content_JSON_Type__c;
         	
           List<Sobject>sobjectrecList = new List<Sobject>();
       
     
          Map<String, Object> fieldMap = (Map<String, Object>)JSON.deserializeUntyped(jsonEventFields);
         
          Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
          System.debug('this is schema map'+schemaMap);
          
          Map <String, Schema.SObjectField> fieldMap2 = schemaMap.get(objectName).getDescribe().fields.getMap();
          sObject sObj = Schema.getGlobalDescribe().get(ObjectName).newSObject() ;
         
        
          for(String key : fieldMap.keyset())
          {
              object value = fieldMap.get(key);
              System.debug('this is value:-'+value);
              System.debug('this is first field which is present in json string :-'+key);
          	for(String f : fieldMap2.keySet())
          	{
                 
                if(key.equalsIgnoreCase(f))
                {
                   
                    sObj.put(f,value);
                }
            }
          } 
         try
         {
          sobjectrecList.add(sObj);
          insert sobjectrecList;
          for(Sobject o : sobjectrecList)
          {
              e.Retrieval_Info_Id__c = o.id;
              System.debug('this is  id *****'+e.Retrieval_Info_Id__c);
              e.Event_Status__c = 'Complete';
              System.debug('this is event status:-'+e.Event_Status__c);
              
          }
          update e;
          System.Debug('this is updated e :-'+e);
          System.debug('this is record:-'+sobjectrecList);
         }
          catch(Exception ex)
          {
              e.Failure_Reason__c = ex.getMessage();
              update e;
              System.debug('inside catch insertion fail');
          }   
      }
    }
    global void finish(Database.BatchableContext BC)
     {
         
     }
}