Trigger PrimaryContactValidate on Contact(Before Insert,Before Update)
{
  Set<Id> accIdSet = new Set<Id>();
    for(Contact con : Trigger.new)
    {
        if(con.AccountId != Null)
        {
            if(Trigger.isUpdate)
            {
                Contact oldDetails = Trigger.oldMap.get(con.Id);
                if(con.Primary_Contact__c == True && oldDetails.Primary_Contact__c == False)
                {
                    accIdset.add(con.AccountId);
                   // System.debug();
                }
            }
            else
            {
                if(con.Primary_Contact__c == True)
                {
                    accIdset.add(con.AccountId);
                }
            }
        }
    }
  if(accIdset.size() > 0)
  {
    List<Contact>contactList = [SELECT Id,AccountId,Primary_Contact__c,FirstName,LastName 
                                FROM Contact
                                WHERE Primary_Contact__c = True 
                                AND AccountId IN : accIdset];
      if(contactList != NULL && contactList.size() > 0)
      {
          Map<Id,List<Contact>> acctoContactListMap = new Map<Id,List<Contact>>();
          for(Contact con : contactList)
          {
              List<Contact> dummyConList = acctoContactListMap.get(con.AccountId);
              if(dummyConList == Null)
              {
                  dummyConList = new List<Contact>();
              }
              dummyConList.add(con);
              acctoContactListMap.put(con.AccountId,dummyConList);
          }
          for(Id accId : acctoContactListMap.keySet())
          {
              List<Contact> dummyConList = acctoContactListMap.get(accId);
              if(dummyConList != Null || dummyConList.size() > 0)
              {
                  Contact cont = dummyConList[0];
                  Trigger.new[0].addError('Primary Contact already assigned to '
                                          +cont.FirstName+''+cont.LastName+
                                          'You Cannot Change the PRimary Contact');
                  
              }
          }
      }
  }
    
}