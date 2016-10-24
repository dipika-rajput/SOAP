@isTest
public with sharing class FlightStatusValidatorControllerTest {
	public static testMethod void unitTesting()
	{
		Test.setCurrentPage(Page.FlightStatusValidatorPage);
		FlightStatusValidatorControllerMockTest fakeresponse = new FlightStatusValidatorControllerMockTest(200, 'Complete','{"attributes":{"type":"Flight__c","url":"/services/data/v36.0/sobjects/Flight__c/a082800000pXU8yAAG"},"Id":"a082800000pXU8yAAG","Airline_Code__c":"a100","Flight_Number__c":"LH4242","Arrival_Time__c":"2016-10-10T10:08:00.000+0000","Departure_Time__c":"10/10/2016 4.00AM","Airport__c":"a092800000LWWoUAAX","Arrival_Airport_Code__c":"ABR","Arrival_Terminal__c":"T1","Departure_Airport_Code__c":"ABR","Departure_Terminal__c":"T2"}');
		Test.setMock(HttpCalloutMock.class, fakeResponse);
		FlightStatusValidatorController f = new FlightStatusValidatorController();
		f.Login();
		
		f.callflightGet();
		
	}
    
}