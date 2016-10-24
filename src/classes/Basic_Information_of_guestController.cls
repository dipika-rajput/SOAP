public with sharing class Basic_Information_of_guestController {
    public List<Registration_of_Guest__c>regList{get;set;}
    String groupId;
    private Final Registration_of_Guest__c r1;
    public Basic_Information_of_guestController(ApexPages.StandardController controller) {
    groupId = ApexPages.currentPage().getParameters().get('SelectedGCId'); 
  
   this.r1 = (Registration_of_Guest__c)controller.getRecord();
   System.debug('current record'+r1);
 
    

    }
    public pagereference saveRec()
    {
   
         r1.Group_Code__c=groupId;
         System.debug(' r1.Group_Code__c:-'+ r1.Group_Code__c);
         regList = [Select First_Name__c,Last_Name__c,Email_ID__c,Registration_Status__c,
         Flight_Arrival_Number__c,Flight_Arrival_Code__c,Flight_Arrival_Date_Time__c,Flight_Departure_No__c,
         Flight_Departure_Code__c,Flight_Departure_Date_Time__c from Registration_of_Guest__c where Group_Code__r.id =:groupId ];
         System.debug('reglist:-'+regList);
         System.debug('r1 b4 insert:-'+r1);
         insert r1;
         System.debug('r1 after insert'+r1);
       //  String baseurl = ApexPages.currentPage().getHeaders().get('Host')+'/'+r1.id;
         //System.debug('baseurl:-'+baseurl);
     
         //PageReference ref = new PageReference(baseurl); 
         //System.debug('ref of detail page:-'+ref);
       // PageReference ref = new PageReference('/apex/Basic_Information_of_guest');
     PageReference ref = new PageReference('/'+r1.id);
          ref.setredirect(true);
          return ref;
    }

}