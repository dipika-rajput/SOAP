@isTest
public class LeadManipulationTest 
{
	Static testMethod void testPost()
    {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/Services/apexrest/leadManipulator';
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        LeadManipulation leadmani = new LeadManipulation();
        LeadManipulation.post('Demotest', 'DemoLastTest', 'demo@gmail.com',
                              '45454584', 'Eternus Solutions', 'Leaddemo');
        //call Delete
        Lead l1 = new Lead(FirstName = 'demod12',LastName = 'demod12',
                          Email = 'demod12@gmail.com',Phone = '45415488',Company = 'demdodddd',
                          LeadName__C = 'ldeaddd');
        insert l1;
        req.addParameter('FirstName' , 'demod12');
        req.addParameter('LastName' , 'demod12');
        req.addParameter( 'Email' , 'demod12@gmail.com');
        req.addParameter('Phone' , '45415488');
        LeadManipulation.deleteLead();
        
        //call update 
         Lead l2 = new Lead(FirstName = 'demod123',LastName = 'demod123',
                          Email = 'demod123@gmail.com',Phone = '454154883',Company = 'demdodddd3',
                          LeadName__C = 'ldeaddd3');
        insert l2;
       	req.addParameter('FirstName','demod123');
        req.addParameter('LastName','demod123');
        LeadManipulation.updateLead('demo@gmail.com', '454577584');
      //  System.assertEquals(l.Email,'demo@gmail.com');
        //System.assertEquals(l.Phone,'4545488');
        
        
    }
}