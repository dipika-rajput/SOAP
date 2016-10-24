global class BatchSendingThankuMail implements Database.Batchable<sObject> { 

	String query;
  global Database.querylocator start(Database.BatchableContext BC)
     {
     	System.debug('inside start');
     	//DateTime todayDate = DateTime.now();
        //DateTime dateafter24hrs = todayDate.addHours(-24);
      	query = 'Select Id,Name,Flight_Departure_Date_Time__c,Email_ID__c FROM Registration_of_Guest__c where Flight_Departure_Date_Time__c = YESTERDAY';
      	
        return Database.getQueryLocator( query);
     }
     global void execute(Database.BatchableContext BC, List<Registration_of_Guest__c>RegLst ) 
     {
     	System.debug('reg list:-'+RegLst);
     	System.debug('inside execute');
        //DateTime todayDate = DateTime.now();
       // DateTime dateafter24hrs = todayDate.addHours(-24);
	    //System.debug('dt'+dateafter24hrs);
	    List<String>thankuEmailLst = new List<String>();
        for(Registration_of_Guest__c r :RegLst )
        {
        	thankuEmailLst.add(r.Email_ID__c);
        }
        System.debug('thankuEmailLst:--'+thankuEmailLst);
        
        //Send Email
        		
          		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          		String emailbody = 'Thank you for using FlightStat';
        		mail.setToAddresses(thankuEmailLst);
              	mail.setSubject('Thank You email  !!');
        		mail.setHtmlBody(emailbody);
              	
            	Messaging.sendEmail(new Messaging.SingleEmailmessage[] {mail});
     
     }
          
     
     global void finish(Database.BatchableContext BC)
     {
         
     }   

    
}