@isTest
public with sharing class Basic_Information_of_guestControllerTest {
public static testMethod void unitTesting()
{       
       date start = date.today();
        start = start.addYears(2);
        date enddate = date.today();
        enddate = enddate.addDays(10);
        Event_Management__c e = new Event_Management__c(Name='demoevent',Start_Date__c=start,End_Date__c=enddate);
        insert e;
       Group_Code__c g = new Group_Code__c(Coordinator_Email__c='demo@gmail.com',Package__c = e.id);
       insert g;
       //Test.setCurrentPageReference(new PageReference('Page.Basic_Information_of_guest')); 
       
       //System.currentPageReference().getParameters().put('id', g.id);
       PageReference pr = page.Basic_Information_of_guest;
       String gcid;
       pr.getParameters().put('gcid',g.id);
      // String gcid = pr.getParameters().get('gcid');
       test.setCurrentPage(pr);
       System.debug('System.currentPageReference().getParameters().put(id, g.id);'+System.currentPageReference().getParameters().put('id', g.id));
       System.debug('test groupcode after insert'+g);
       Registration_of_Guest__c r1 =new Registration_of_Guest__c
       (First_Name__c='demo1',Last_Name__c='demo1',Email_ID__c='demo@gmail.com',Group_Code__c=gcid);
       //r1.Group_Code__c = g.id;
       insert r1;
       
       
       Test.startTest();
       //Test.setCurrentPage(Page.Basic_Information_of_guest);
       ApexPages.StandardController stdController = new ApexPages.StandardController(r1);
       Basic_Information_of_guestController b = new Basic_Information_of_guestController(stdController);
       PageReference pr1 = b.saveRec();
       //System.debug('pr'+pr);
    //Group_Code__c g = new Group_Code__c();
    
    //Registration_of_Guest__c r1 =new Registration_of_Guest__c( First_Name__c='demo1',Last_Name__c='demo1',Email_ID__c='demo@gmail.com');
    //r1.Group_Code__c=groupId;
    
}    
}