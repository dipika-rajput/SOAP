Global class LeadManipulationusingSOAP {
    
    webService String Status {get; set;}
   // public List<Sobject> Data {get;set;}
    webService Boolean isSuccess {get;set;}
    webService String ErrorCode {get; set;}
    //public String LeadId {get;set;}
 
    webService static boolean isNotNullOrEmpty(string str)
    {
        return str!=null || !String.isBlank(str); 
    }
    
   //Method to create new Lead
    webService static Lead createLead(String firstName, String lastName, String email,String Phone,String Company,String LeadName)
    {
        //check if the fields provided on not empty
        if(isNotNullOrEmpty(firstName) && isNotNullOrEmpty(lastName) && isNotNullOrEmpty(email) && isNotNullOrEmpty(Phone))
        {
            Lead newLead = new Lead();
            newLead.FirstName = firstName;
            newLead.LastName = lastName;
            newLead.Email = email;
            newLead.Phone = phone;
            newLead.Company = Company;
            newLead.LeadName__c = LeadName;
            return newLead;         
        }
        else 
        {
            System.Debug('Required field values are not provided here');
            return null;
        }
    }
    
    //Post method to Post data
   
    webService static LeadManipulation post(String firstname, String  lastname, String email, String Phone,String Company,String LeadName)
    {
        Lead  newLead =  createLead(firstName, lastName, email, Phone,Company,LeadName);
        System.debug('this is new lead:'+newLead);
       	LeadManipulation response = new LeadManipulation();
        try
        {
            System.debug('inside try of post');
            insert newLead;
            //List<sObject> thesObjectList = new List<sObject>();
            //thesObjectList.add((sObject)newLead);
           // response.Data = thesObjectList;
            response.Status = 'Success';
           //response. = lead.id;
            response.isSuccess = True;
            response.ErrorCode = null;
        } 
        catch(DmlException e) 
        {
            System.debug('inside catch of post');
            //Add custom error code when you could not insert a record
            response.ErrorCode = 'leadManipulation - 404';
            response.Status = 'error';
            //response.Message = e.getMessage();
        }
        return response;   
    }
    
    //Delete Method for deleting the Lead
    
     webService static LeadManipulation deleteLead()
    {
        LeadManipulation response = new LeadManipulation();
        String FN = RestContext.request.params.get('FirstName');
        System.debug('FN'+FN);
        String LN = RestContext.request.params.get('LastName');
        String email1 = RestContext.request.params.get('Email');
        String phone1 = RestContext.request.params.get('Phone');
        List<Lead> deletelead = [SELECT FirstName,LastName,Email,Phone FROM Lead 
                                 WHERE FirstName= :FN AND LastName= :LN AND Email= :email1 AND Phone= :phone1 ];
        try
        {
        	delete deletelead;
        	response.Status = 'Success';
            //response. = lead.id;
            response.isSuccess = True;
            response.ErrorCode = null;

        }
        catch(DmlException e)
        {
            //Add custom error code when you could not insert a record
            response.ErrorCode = 'leadManipulation - 0001';
            response.Status = 'error';
            //response.Message = e.getMessage();
        }
        return response;
    }
    
    //update Record
   
  /*   webService static LeadManipulation updateLead(String Email1, String Phone1 ) {
        LeadManipulation response = new LeadManipulation();
         String FirstName1 = RestContext.request.params.get('FirstName');
        System.debug('this is FN for put'+FirstName1);
         String LastName1 = RestContext.request.params.get('LastName');
        System.debug('this is LN for put:'+LAstName1);
        Lead updateLead = [ Select FirstName,LastName,Email,Phone from Lead 
                           where FirstName= :FirstName1 AND LastName= :LastName1];
        System.debug('this is updated lead'+updateLead);

        updateLead.Email = Email1;
        System.debug('this is updated email'+updateLead.Email);
        updateLead.Phone = Phone1;
        System.debug('this is updated phone'+updateLead.Phone);
        try{
       			System.debug('this is inside try of put');
            	update updateLead;
            	System.debug('this is updated lead'+updateLead);
            	response.Status = 'Success';
            	//response. = lead.id;
           	 	response.isSuccess = True;
            	response.ErrorCode = null;
           }
        catch(DmlException e)
        {
            System.debug('this is inside catch of put');
            response.ErrorCode = 'leadManipulation - 0001';
            response.Status = 'error';
        }
        return response;
    }*/

}