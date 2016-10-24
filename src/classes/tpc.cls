public class tpc{

    public PageReference dosubmit(){

        // create case, etc.

        system.debug('test');

        PageReference pr = new PageReference('http://login.salesforce.com/apex/Account_Attachment'); // google is blocked here
        pr.setRedirect(true);
        return pr;
    }

}