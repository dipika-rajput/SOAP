public with sharing class Account_Detail_Controller {

    public PageReference edit() {
        return null;
    }


    public Account account { get; set; }
public PageReference dosubmit(){

        // create case, etc.

        system.debug('test');

        PageReference pr = new PageReference('http://login.salesforce.com/apex/Account_Attachment'); // google is blocked here
        pr.setRedirect(true);
        return pr;
    }



}