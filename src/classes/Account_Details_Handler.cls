public with sharing class Account_Details_Handler {

    //getter and setter for Attachment
 public String AccIDx {get; set;}

   public Account_Details_Handler(ApexPages.StandardController controller) 
   {
        Account acc = new Account();
        AccIDx = controller.getId();
         String AccountIDp = ApexPages.currentPAge().getParameters().get('AccountIDx');

   }
   public String IdChoosen{get; set;}

   public pageReference deleteLink()
     {
        Attachment AttachmenttoDel = new Attachment(id = IdChoosen);
        delete AttachmenttoDel;
        return null;
     }
  
   public PageReference dosubmit()
   {
        system.debug('test');
        PageReference pr = new PageReference('/apex/Account_Attachment'); 
        pr.getParameters().put('AccIDx',AccIDx);
        pr.setRedirect(true);
        return pr;
    }

}