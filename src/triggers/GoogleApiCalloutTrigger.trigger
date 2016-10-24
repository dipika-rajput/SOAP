Trigger GoogleApiCalloutTrigger on Email_Handler__c (after insert) {
    
   for(Email_Handler__c e : Trigger.New)
    {
        String emailbody = e.Email_Body__c;
        String idofNewRecord = e.Id;
        GoogleApiCallout.callingToApi(emailbody,idofNewRecord);
       // GoogleApiCallout.jsonParsing(idofNewRecord);
    }

}
//for email we are using Demo_Email_Handler_clasd