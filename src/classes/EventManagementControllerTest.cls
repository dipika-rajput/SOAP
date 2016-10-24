@isTest
public class EventManagementControllerTest {
     public static testMethod void unitTesting()
     {
     	date start = date.today();
     	start = start.addYears(2);
     	date enddate = date.today();
     	enddate = enddate.addDays(10);
     	Event_Management__c e = new Event_Management__c(Name='demoevent',Start_Date__c=start,End_Date__c=enddate);
     	insert e;
     	Test.startTest();
     	Test.setCurrentPage(page.Event_Management_page);
     	ApexPages.StandardController std = new ApexPages.StandardController(e);
     	EventManagementController ec = new EventManagementController(std);
     	List<SelectOption> s = ec.getEventObj();
     	System.debug('getEventobj:--'+s);
     	List<SelectOption> s2 = ec.getGroupCodeObj();
     	System.debug('getGroupCodeObj'+s2);
     	pageReference ptr1 = ec.redirect();
     	System.assertNotEquals(ptr1.getUrl(),null);
        System.assertEquals(ptr1.getUrl().containsIgnoreCase('/apex/Basic_Information_of_guest'), true);
        //String eventl = ec.eventLst;
     	pageReference ptr2 = ec.eventLst();
     	//System.assertEquals(ptr2.getUrl(),null);
        
     	pageReference ptr3 = ec.EventObj();
     	//System.assertEquals(ptr3.getUrl(),null);
        
     	
     	//
     }
}