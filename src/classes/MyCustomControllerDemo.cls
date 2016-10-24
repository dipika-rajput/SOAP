public with sharing class MyCustomControllerDemo {
       Account account;
    public PageReference save() {
    update account;
    pageReference secondpage = page.secondPageDemo;
    secondpage.setRedirect(True);
    secondpage.getParameters().put('id',account.id);
     return secondpage;
    }

public String getName()
{
    return 'MyController';
}
public Account getAccount()
{
    account =[select id,name,Website_Domain__c from account where id=:ApexPages.currentPage().getParameters().get('id')];
    return account;
}

}