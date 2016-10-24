public with sharing class dbquery {
 public void dbquery1()
    {
    	string str = 'dipika';
    	List <Account> list_account= Database.query('Select Id From Account where Name =:str');
    	System.debug(list_account);
    }    
}