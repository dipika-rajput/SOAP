@isTest
public with sharing class BatchSendingThankuMailTest {
	 public static testMethod void accountDetailhandling()
	 {
	 	 test.startTest();
	 	 DateTime todayDate = DateTime.now();
         DateTime dateafter24hrs = todayDate.addHours(-24);
	 	 Registration_of_Guest__c r = new Registration_of_Guest__c(Name='testReg',
	 	 Flight_Departure_Date_Time__c=dateafter24hrs,Email_ID__c='dipikarajput30@gmail.com');
	 	 insert r;
	 	 BatchSendingThankuMail b = new BatchSendingThankuMail();
		 Id batchJobId = Database.executeBatch(b);
	 }
    
}