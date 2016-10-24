Global class BatchFlightremainerntahnkyoumail implements Database.Batchable<sObject> {
	String query;
  global Database.querylocator start(Database.BatchableContext BC)
     {
      	query = 'SELECT Id,Name,Start_Date__c,End_Date__c FROM Event_Management__c';
        return Database.getQueryLocator( query);
     }
     global void execute(Database.BatchableContext BC, List<Event_Management__c>eventLst ) 
     {
        //querying on package to get all group code related to events 
        List<Package__c>pkgLst = new List<Package__c>();
		pkgLst = [Select Group_Connector__r.Name,Group_Connector__r.id,
        Event_connector__r.Start_Date__c,Event_connector__r.Name from Package__c];
		System.debug('pkglist:--'+pkgLst);
		//List<Registration_of_Guest__c>regLst = new List<Registration_of_Guest__c>();
    	 //  regLst = [Select Id, Email_ID__c,Name from Registration_of_Guest__c];
	  	//store 2 days less than today date in one variable d
	  	Date d = Date.Today().addDays(-1);
		System.debug(d);
		//this list is for storing ids of group code whose events having start date 2 days less than Today 
		List<Id>idsofgroupCode = new List<Id>();
		//package list to filter pkg list 
		List<Package__c>condSatisfiedpkgLst = new List<Package__c>();
		List<Group_Code__c>groupcodeToReg = new List<Group_Code__c>();
		
       for(Package__c p : pkgLst)
       {
           //system.debug('addddays:--'+p.Event_connector__r.Start_Date__c);
                        
       		if(p.Event_connector__r.Start_Date__c == d)
       		{
       			system.debug('inside if');
                condSatisfiedpkgLst.add(p);
              
                
       		}
           for(Package__c p2 : condSatisfiedpkgLst)
           {
               idsofgroupCode.add(p2.Group_Connector__r.id);
               System.debug('add those group code list whose event start date is less than 2days'+idsofgroupCode);
           
         		
           }
       }
       //To get emails of Registration 
       	groupcodeToReg = [Select Id,Name ,(Select Id,Name,Email_ID__c FROM Registration_of_Guest__r)
				FROM Group_Code__c where Id =:idsofgroupCode]; 
				System.debug('records of groups and reg whose ids are present in condition:-'+groupcodeToReg);
				//Iterate on groupcode list and stores emails in string list
				List<String>EmailsofRegLst = new List<String>();
				for(Group_Code__c g :groupcodeToReg)
				{
					for(Registration_of_Guest__c r:g.Registration_of_Guest__r)
					EmailsofRegLst.add(r.Email_ID__c);
					
				}
				System.debug('Emails of reg to which mail needs to send:-'+EmailsofRegLst);
     
				System.debug('List of package whose event start date is 2 days less than today'+condSatisfiedpkgLst);
         
          		
          		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        		mail.setToAddresses(EmailsofRegLst);
              	mail.setSubject('Flight Remainder before 2 days !!');
        		//mail.setHtmlBody(emailbody);
              	
            	Messaging.sendEmail(new Messaging.SingleEmailmessage[] {mail});
            
          /*	
          	if(DateTime.now() == Flight_Departure_Date_Time__c.addHours(24))
          	{
          		//send Thank you email
          		//List<Messaging.SingleEmailMessage>  myEmails = new List<Messaging.SingleEmailMessage>();
          		Messaging.SingleEmailMessage mail2 = new Messaging.SingleEmailMessage();
        		mail2.setToAddresses(emailregList);
              	mail2.setSubject('Thank you mail for Using our Flight ..Hope you enjoyed!!');
        		//mail.setHtmlBody(emailbody);
              	myEmails.add(mail2);
            	Messaging.sendEmail(mail2);
          		
          	}*/
          }
          
     
     global void finish(Database.BatchableContext BC)
     {
         
     }   
}