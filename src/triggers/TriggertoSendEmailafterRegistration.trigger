Trigger TriggertoSendEmailafterRegistration on Registration_of_Guest__c (before insert,after insert, after update) {
    /*List<Group_Code__c>groupcodeList = new List<Group_Code__c>();
    Set<Id> setId = new Set<Id>();
    groupcodeList = [SELECT Id,
                            Coordinator_Email__c 
                     FROM Group_Code__c];
    System.debug('groupcodeList:-'+groupcodeList);
    for(Group_Code__c g : groupcodeList)
    {
        setId.add(g.Id);
        System.debug('--setId:--'+setId);
    }*/
    //List<Id>recId = new List<Id>();
    Set<Id>idsofGroupCode = new Set<Id>();
    List<String>EmailofCoord = new List<String>();
    List<Group_Code__c>gcList = new List<Group_Code__c>();
    for(Registration_of_Guest__c r :Trigger.new)
    {
        //List<Registration_of_Guest__c> EmailofCoord = [SELECT Id,Group_Code__r.Id,Group_Code__r.Coordinator_Email__c FROM Registration_of_Guest__c];
        //System.debug('email of that emailcoord r:**'+EmailofCoord);
        // String em = r.EmailofCoord.Coordinator_Email__c;
        //for(Registration_of_Guest__c r1 : EmailofCoord )
        //recId.add(r1.Group_Code__r.Id);
        //System.debug('recId****'+recId);
         System.debug('get Id of gc%%%'+r.Group_Code__c);
         idsofGroupCode.add(r.Group_Code__c);
         gcList = [SELECT id,Coordinator_Email__c FROM Group_Code__c where id =:idsofGroupCode];
         System.debug('gcListemail^^^'+gcList);
         for(Group_Code__c g1 : gcList)
            EmailofCoord.add(g1.Coordinator_Email__c);
         System.debug('EmailofCoord'+EmailofCoord);
        // System.debug('Idgc'+idsofGroupCode);
         //System.debug('id of gc:&&'+r.Group_Code__r.id);
        System.debug('newly registered:--'+r);
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE 
        developerName = 'Email_to_Groupcode_coordinator_after_guest_is_registered'];
        System.debug('email template :-'+et);
       
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           System.debug('mail:--'+mail);
        mail.setTargetObjectId(r.Group_Code__r.id);
        System.debug('targetobject id:-'+r.Group_Code__r.id);
        //string[] toAddress = new string[]{};
      //  List<String>toAddress = new List<String>();
        //toAddress.add(EmailofCoord);
        System.debug('toAddresses:-'+EmailofCoord);
        mail.setToaddresses(EmailofCoord);
        mail.setSubject('Registration of Guest is Done!!');
                //mail.setHtmlBody(emailbody);
                mail.setTemplateId(et.id);
                
                System.debug('individual mail:-'+mail);
              // System.debug('my Mails*****'+myEmails);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
    
}