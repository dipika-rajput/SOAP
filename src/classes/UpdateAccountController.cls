public class UpdateAccountController
{
  	Account account;
    public Account getAccount() 
    {
    	if(account == null) account = new Account();
    	return account;
	}
	public PageReference step1()
    {
      return Page.Accountpage;
   	}
	public PageReference step2() 
    {
      return Page.Accountpage2;
   	}
}