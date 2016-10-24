@isTest
public class secondReferenceControllerTest {
     static testMethod void seconpageTesting()
     {

         Test.setCurrentPage(Page.secondReference);
         secondReferenceController sec = new secondReferenceController();
         //for goBack function
         pageReference pr = sec.goBack();
         
     }

}