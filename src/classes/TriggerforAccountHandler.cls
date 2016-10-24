//Question 3:-clone the record done working fine
//This class is for cloning the account.

public class TriggerforAccountHandler{
    public void accountHandling(List<Account>acclst)
    {
    	List <Account> clonedRecord = new List <Account> ();
        //Here we are iterating on list to create clone copy of account. 
    	for(account a : acclst)
    	{
        	System.debug(''+acclst);
            //Here we are trying to find matching values to get that record.    
            if( ((a.rating).equalsIgnoreCase('Hot')) && ((a.Ownership).equalsIgnoreCase('Public')))
       	 	{
           	 	Account newAcc;
                
            	newAcc = a.clone(false,false,false,false);
            	newAcc.Ownership = ConstantCloneClass.OWNERSHIP;
            	newAcc.Name = ConstantCloneClass.NAME;
            	newAcc.rating = ConstantCloneClass.RATING;
            	clonedrecord.add(newAcc);
            	System.debug('this is newacc:'+newAcc);
       		 }
   	 	}
        //Here we are checking size of list if it is null then it will not get inserted.
        if(clonedrecord.size() > 0)
        	insert clonedrecord;
               
		System.debug('this cloned rec'+clonedrecord);
    
               
    }

}