/*5.Address Did Not Verify – AVS:
 1.Create SalesHeader__c object :(Having lookup to Account & Contact ) & Add necessary fields.
 2.Create EFT_Transaction_Status__c object with the necessary fields and add look up to
SalesHeader__c
 3. Create assignment record type on Case
 4. On Insert of a EFT_Transaction_Status__c, if
EFT_Transaction_Status__c.Method_Name__c = “Credit Card Address Verify”
EFT_Transaction_Status__c.Transaction_Status__c= “Declined”
SalesHeader__c.Status__c = “Open”
Create a Case with this mapping:
Case Field Value
Account SalesHeader__c.Bill_to_Customer__c
Contact SalesHeader__c.Bill_to_Customer__c
Record Type Assignment
Origin "Internal"
Owner AVS Queue
Reason Address Did Not Verify
Priority High
Status New
Subject Account.Name + " " + Case.Type
Type Address Did Not Verify
Open_Sales_Order__c SalesHeader__c.Id
Transaction_Status__c EFT_Transaction_Status__c.Transaction_Status__
c
Sales_Order_Number__c SalesHeader__c.Name
Order_Date__c EFT_Transaction_Status__c.Transaction_Date__c*/

public class Trigger_EFT_Transaction_Status_Handler {
    public void eftTransaction()
    {
        //list<EFT_Transaction_Status__c>ECS_List = new list<EFT_Transaction_Status__c>();
 	 //Here we are creating case for creating new case.
     Case caseAssignment = new Case ();
    //Here we are querying the contect from object to use them in if statement.
     List<EFT_Transaction_Status__c> newEFT = new List<EFT_Transaction_Status__c>();
     newEFT = [select Id,Method_Name__c,Transaction_Status__c,Transaction_Date__c,SalesHeaders_reltion__c,
               SalesHeaders_reltion__r.Bill_To_Account__c,SalesHeaders_reltion__r.Bill_To_Contact__c,
               SalesHeaders_reltion__r.Status__c ,SalesHeaders_reltion__r.Name from
               EFT_Transaction_Status__c where id IN: Trigger.newMap.Keyset()];
    //Now, we are iterating on list of newEFT object to fetch each record and to compare those records.
     for(EFT_Transaction_Status__c ecs :  newEFT )
    {   
       		//Here, we are checking criteria condtion which is given in requirement to compare. 
            if( (ecs.Method_Name__c == 'Credit Card Address Verify')
               && (ecs.Transaction_Status__c == 'Declined')
               &&(ecs.SalesHeaders_reltion__r.Status__c == 'Open') )
            {     
              	//We are assigning values to the case and we are creating new case through trigger.
                caseAssignment.AccountId = ecs.SalesHeaders_reltion__r.Bill_To_Account__c;
                caseAssignment.ContactId = ecs.SalesHeaders_reltion__r.Bill_To_Contact__c;
                caseAssignment.RecordTypeId = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('Assignment record type').getRecordTypeId();//which is created manually on case 
                caseAssignment.Origin = 'Internal';
                List<Group> ID_List = new List <group>([select Id from Group where Name = 'AVS_Queue' and Type = 'Queue']);
               //If ID_List is not empty then only it will enter in this block
                if(ID_List.isEmpty() == False)
                {
               		 caseAssignment.OwnerId = ID_List.get(0).Id;
                }
                caseAssignment.Reason = 'Address Did Not Verify';
                caseAssignment.Priority = 'High';
                caseAssignment.Status = 'New';
                caseAssignment.Subject = Account.Name+''+Case.Type;
                caseAssignment.Type = 'Address Did Not Verify';
                caseAssignment.Open_Sales_Order__c = ecs.SalesHeaders_reltion__r.Id;
                caseAssignment.Transaction_Status__c = ecs.Transaction_Status__c;
                caseAssignment.Sales_Order_Number__c = ecs.SalesHeaders_reltion__r.Name ;
                caseAssignment.Order_Date__c = ecs.Transaction_Date__c;
               
            }
       
    }
	//Inserting that case object into database.
    insert caseAssignment;
    System.debug(caseAssignment);
        
    }

}