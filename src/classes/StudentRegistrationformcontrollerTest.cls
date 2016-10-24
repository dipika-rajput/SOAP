@isTest
public class StudentRegistrationformcontrollerTest {
    static testMethod void unitTesting()
    {
      	test.startTest();
        Student_Details__c stud = new Student_Details__c(Student_Name__c = 'stud1',	Roll_No__c = 44,	
                                                         Language_Selection__c = 'French',Gender__c = 'Female',
                                                         Course_Applying_for__c = 'M.C.A');
        insert stud;
        
        test.setCurrentPage(page.StudentRegistrationform);
        ApexPages.StandardController std = new ApexPages.StandardController(stud);
        StudentRegistrationformcontroller s = new StudentRegistrationformcontroller(std);
       
       	s.getresult();
		PageReference pr = s.search();
        s.getLanguageSelected();
        s.language = 'French';
        s.currentLanguage = 'French';
        s.changeLanguagetofrench();
        s.language = 'Spanish';
        s.changeLanguagetofrench();
        s.language = 'English';
        s.changeLanguagetofrench();
        
        
        
    }

}