/*1. Create a custom object called as 'Logs'. Create a long text area field called as 'Error'. Create 100
Lead records using DML operations having a unique name. For all records which were not inserted into
Lead object, insert a record in Log object along with the reason why a record was not inserted. Also,
execute assignment rules to auto allocate Lead records to correct owner*/
public with sharing class DMLquery1
{
	public void logErrorOperation()
	{
		List<Logs__c> errorList = new List<Logs__c> ();
		List <Lead>ld = new List<Lead>();
		for(Integer i=0;i<100;i++)
        {
   	 		Lead a = new Lead (	LeadName__c='lead1'+i,firstname='dipika' + i,
                               lastname='rajput' + i, company ='espl'+1, NumberOfEmployees= i);
            ld.add(a);
        }
		insert ld;
		//this function is for trying to insert duplicate records whether it is taking or notpublic void dml2()
		List<Lead>lead_duplicate = new List<Lead>();
		Lead l;
		for(Integer i = 50 ; i < 100 ; i++)
		{
			 l = new Lead(LeadName__c = 'lead1'+i,firstname = 'dipika' + i, lastname = 'rajput' + i, 
                          company = 'espl'+1, NumberOfEmployees = i);
			 lead_duplicate.add(l);
		}
		database.SaveResult[] srlist = database.insert(lead_duplicate,false);
		for(database.saveResult sr :srlist)
		{
			if(sr.isSuccess())
			{
				System.debug('record is inserted');
			}
			else
			{
				       
				Logs__c logObj = new Logs__c();	
				logObj.Error__c = String.join(sr.getErrors(), ';');
				errorList.add(logObj);
			}
		}
        insert errorList;
    }
}//done